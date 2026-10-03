# StudyDocs architecture

## 20.1 Tổng quan

StudyDocs quản lý tài liệu cục bộ bằng Flutter, Drift và SQLite. Các khu vực được tổ chức theo nguyên lý quan sát từ Cashew — `pages/`, `widgets/`, `struct/`, `functions.dart`, `database/` — thay vì áp một tên kiến trúc khác lên source. Luồng chính là Presentation → Application Logic → Data Access → SQLite.

## 20.2 Kiến trúc Cashew áp dụng

| Khu vực | Vị trí thật | Trách nhiệm / lý do đặt ở đây |
|---|---|---|
| Presentation | `lib/pages/` | Mỗi file là một luồng màn hình; điều phối interaction và navigation. Không viết query SQL. |
| UI tái sử dụng | `lib/widgets/` | `DocumentForm`, `DocumentEntry`, search bar, empty state và snackbar tách khỏi từng màn hình để tái dùng. |
| Application / Business Logic | `lib/struct/documentFunctions.dart` | Validate draft, chuẩn hóa tags, phối hợp lookup và write; không phụ thuộc `BuildContext`. |
| Shared functions | `lib/functions.dart` | Hằng loại/danh mục, chuẩn hóa tags, định dạng ngày và lưu file; tiện ích dùng ở nhiều màn hình. |
| Data access | `lib/database/` | Bảng Drift, CRUD/query và migration; database không import Flutter UI. |
| Global/application state | `lib/struct/databaseGlobal.dart`, `lib/struct/appState.dart` | Một điểm khởi tạo DB dùng chung; state cài đặt chỉ giữ dark mode. |
| Persistence | SQLite + application documents directory | SQLite lưu metadata; bản sao file ở vùng lưu trữ cục bộ của app. |

Sơ đồ và luồng CRUD chi tiết: [diagrams/architecture_and_flows.md](diagrams/architecture_and_flows.md).

## 20.3 Presentation

- `pages/addDocumentPage.dart` và `pages/editDocumentPage.dart` kết nối biểu mẫu với callback application logic.
- `pages/documentsListPage.dart`, `pages/searchDocumentsPage.dart`, `pages/documentDetailsPage.dart` hiển thị dữ liệu và nhận thao tác người dùng.
- `widgets/documentForm.dart` quản lý input, kiểm tra bắt buộc của tiêu đề, loading state và gọi callback `onSave`; không biết database.
- `widgets/documentEntry/documentEntry.dart` dùng chung cho danh sách và favorites.
- `widgets/navigationFramework.dart` quản lý năm đích chính: Trang chủ, Tài liệu, Tìm kiếm, Yêu thích, Cài đặt.

Widget không thao tác DB. `DocumentEntry` nhận một data object để trình bày, không thực hiện query hoặc write.

## 20.4 Application Logic

`DocumentFunctions` được đặt trong `struct/` vì đây là xử lý nghiệp vụ điều phối chứ không phải UI hay schema:

- `addDocument`: validate, trim trường text, chuẩn hóa tags, gán timestamps rồi gọi insert.
- `updateDocument`: lookup ID trước, ghi đè cùng ID, giữ `createdAt` và `isFavorite`, cập nhật `updatedAt`.
- `deleteDocument`: gọi delete theo khóa chính và báo lỗi nếu không xóa bản ghi nào.
- `getDocuments`, `getDocument`, `searchDocuments`, `filterDocuments`, `toggleFavorite`, `getFavorites`: các thao tác ứng dụng không cần widget context.

Search cụ thể nằm trong `StudyDatabase.searchDocuments`, còn `DocumentFunctions.searchDocuments` là điểm điều phối của ứng dụng. Như vậy điều kiện SQL ở data access; page chỉ cung cấp chuỗi tìm kiếm và render kết quả.

## 20.5 Database

`lib/database/tables.dart` mô tả `Documents`. `lib/database/study_database.dart` giữ các hàm create/read/update/delete, search và favorite. Drift-generated code ở `study_database.g.dart` được tạo bằng build_runner. `schema_versions.dart` giữ version hiện tại (2); chiến lược migration nằm trong getter `migration` ở `StudyDatabase`.

Version 2 thêm `isFavorite`; nhánh upgrade từ version nhỏ hơn 2 gọi `migrator.addColumn`. Test migration tạo file SQLite legacy version 1, mở bằng database hiện tại và xác nhận cột mới đã có.

## 20.6 SQLite

`DatabaseGlobal.initialize()` lấy application support directory, mở `study_docs.sqlite` qua `NativeDatabase.createInBackground`, bật WAL và chạy `SELECT 1` để ép Drift mở kết nối/migrate trước `runApp`. Test CRUD chạy trên `NativeDatabase.memory()`; test migration sử dụng file SQLite tạm thật.

Các trường tags lưu dưới dạng chuỗi phân tách dấu phẩy, phù hợp quy mô ứng dụng môn học; nếu cần truy vấn quan hệ/chuẩn hóa tag ở quy mô lớn có thể tách bảng `Tags` và bảng liên kết.

## 20.7 Navigation

`widgets/navigationFramework.dart` là điểm tập trung navigation tab. Chi tiết, thêm và sửa dùng route push tạm thời từ page chủ quản. Điều này giữ điều hướng chính nhất quán nhưng vẫn tận dụng Navigator cho màn hình CRUD.

## 20.8 Data Flow

Ví dụ Add: `AddDocumentPage → DocumentForm callback → DocumentFunctions.addDocument → StudyDatabase.createDocument → Drift → SQLite`. Update/Delete/Search và ERD được mô tả trong Mermaid tại `diagrams/architecture_and_flows.md`. File attachment đi qua helper `storePickedFile` vào thư mục app; URL metadata nằm trong SQLite.

Khởi tạo thực tế trong `main.dart`: `WidgetsFlutterBinding.ensureInitialized()` → `SharedPreferences.getInstance()` → `DatabaseGlobal.initialize()` (mở file SQLite và ép Drift khởi tạo) → `AppState.initialize()` → `runApp(StudyDocsApp)` → Provider cung cấp database/logic/settings → `NavigationFramework`.

## 20.9 Dependency

| Package | Nhóm | Mục đích | Vị trí sử dụng |
|---|---|---|---|
| `flutter` | Framework | UI/runtime | Toàn project |
| `drift` | Data access | Schema/query typed | `database/` |
| `sqlite3_flutter_libs` | Native SQLite | SQLite runtime native | `database/` |
| `provider` | Dependency/state | Chia sẻ database, logic, settings | `main.dart`, pages |
| `shared_preferences` | Local settings | Lưu dark mode | `struct/appState.dart`, `main.dart` |
| `path_provider` | Local storage | Đường dẫn support/documents | `struct/databaseGlobal.dart`, `functions.dart` |
| `path` | File utility | Ghép và chuẩn hóa đường dẫn | `functions.dart`, `databaseGlobal.dart` |
| `file_picker` | File input | Chọn tài liệu local | `functions.dart`, `widgets/documentForm.dart` |
| `url_launcher` | External integration | Mở URL/tệp | `pages/documentDetailsPage.dart` |
| `drift_dev` | Dev codegen | Generate database code | `study_database.g.dart` |
| `build_runner` | Dev codegen | Chạy generator Drift | Quy trình phát triển |
| `sqlite3` | Dev test | Tạo DB version cũ cho migration test | `test/study_database_migration_test.dart` |
| `flutter_test` | Dev test | Widget/unit test | `test/` |
| `flutter_lints` | Dev quality | Analyzer rules | `analysis_options.yaml` |

## 20.10 Testing

- `test/document_functions_test.dart`: CRUD SQLite, tìm kiếm nhiều trường, validate và giữ ID/timestamp/favorite khi update.
- `test/study_database_migration_test.dart`: nâng database version 1 lên 2.
- `test/presentation_separation_test.dart`: form gọi callback application thay vì truy cập database.
- `test/architecture_separation_test.dart`: kiểm tra source pages/widgets không chứa query/write SQL; application logic không phụ thuộc UI; database không chứa UI; search page gọi application logic.

## 20.11 Khả năng mở rộng

SQLite và các nguồn cloud chưa được trừu tượng hóa sau interface tổng quát; đây là lựa chọn có chủ đích để tránh thêm lớp rỗng ở quy mô bài tập. Khi cần đồng bộ, có thể mở rộng `DocumentFunctions` cùng một module trong `struct/` để điều phối thao tác local và sync; thêm trường sync status/conflict policy ở database, và thêm client Google Drive/Firebase làm external integration. UI vẫn gọi luồng application hiện tại. Nếu thay hoàn toàn SQLite bằng cloud, `StudyDatabase`, `DatabaseGlobal`, migration và test data-access sẽ đổi; các page/form và phần lớn nghiệp vụ validate vẫn giữ nguyên.

```text
Hiện tại: Page → DocumentFunctions → StudyDatabase/Drift → SQLite
Mở rộng:  Page → DocumentFunctions → SQLite local ↔ Sync logic → Drive/Firebase
```

Web chưa được bật làm target dữ liệu: `NativeDatabase`/file-system hiện tại chưa có cấu hình Drift WASM worker.

## SOLID và modularity ở mức bài tập

**Điểm đang làm tốt**

- Single Responsibility: `Documents` chỉ mô tả schema; `StudyDatabase` truy vấn; `DocumentFunctions` validate/điều phối; `DocumentForm` quản lý input.
- Separation of Concerns: page không chứa SQL; test separation kiểm tra điều này bằng source.
- Reusability: `DocumentEntry`, `DocumentEntryTag`, `EmptyState`, `DocumentForm`, `DocumentSearchBar` dùng độc lập với một màn hình cụ thể.
- Maintainability: migration có version; `DatabaseGlobal` và `AppState` chỉ giữ đúng các đối tượng dùng chung.

**Điểm cần cải thiện**

- `filterDocuments` hiện lấy toàn bộ dữ liệu rồi lọc trong application logic; phù hợp dữ liệu nhỏ, nhưng dataset lớn nên đưa filter xuống query Drift.
- Tags là chuỗi phân tách; chưa có unique tag, index hoặc full-text search.
- `DocumentFunctions` nhận `StudyDatabase` cụ thể; chưa có sync/conflict abstraction vì bản hiện tại chỉ cần SQLite.
- Chọn file đang dùng đường dẫn native; nếu hỗ trợ web cần storage interface và cấu hình Drift WASM.

**Đề xuất refactor khi phạm vi tăng**

- Tách bảng `Tags`/liên kết nếu cần lọc/tag thống kê phức tạp, migration tương ứng trong `StudyDatabase`.
- Đẩy filter và sort vào các query database để tránh tải toàn bộ tài liệu.
- Thêm sync queue/module trong `struct/` và xử lý conflict rõ ràng trước khi tích hợp Drive/Firebase.
- Bổ sung integration test mở file SQLite thật và test file picker trên từng platform.
