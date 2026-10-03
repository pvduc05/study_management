# StudyDocs

StudyDocs là ứng dụng Flutter giúp sinh viên lưu trữ, tra cứu và cập nhật bài giảng, bài tập, giáo trình, PDF và liên kết học tập. Dữ liệu tài liệu được lưu bền vững bằng Drift trên SQLite cục bộ; không cần backend hoặc tài khoản cloud.

## Công nghệ

| Package | Vai trò |
|---|---|
| Flutter / Dart | Giao diện và runtime |
| Drift + SQLite | Schema, migration và truy vấn CRUD/search |
| `sqlite3_flutter_libs` | SQLite native runtime |
| Provider | Chia sẻ database, logic và state thiết lập |
| `shared_preferences` | Lưu lựa chọn giao diện tối |
| `path_provider` + `path` | Thư mục dữ liệu ứng dụng và quản lý đường dẫn |
| `file_picker` | Chọn tài liệu trên thiết bị |
| `url_launcher` | Mở URL hoặc tệp từ chi tiết |

## Chạy ứng dụng

```powershell
flutter pub get
flutter run
```

Ứng dụng dùng `NativeDatabase`; các mục tiêu native (Android, iOS, Windows) là phạm vi lưu SQLite hiện tại. Web scaffold được Flutter tạo sẵn nhưng chưa cấu hình Drift WASM/worker nên không phải mục tiêu chạy được của phiên bản này.
Trên Windows, Flutter cần quyền tạo symlink cho plugin; nếu build báo thiếu symlink support, bật Windows Developer Mode rồi chạy lại.

Tệp do người dùng chọn được sao chép vào thư mục documents của ứng dụng; URL được lưu nguyên văn trong SQLite. CSDL nằm trong application support directory với tên `study_docs.sqlite`.

## Chức năng

- Tạo, xem, chỉnh sửa và xóa tài liệu; xóa luôn cần xác nhận.
- Tìm theo tên, môn học, loại tài liệu, danh mục và tags bằng truy vấn Drift/SQLite.
- Quản lý tags, môn học, loại, danh mục, mô tả, URL/tệp và yêu thích.
- Lọc trang yêu thích, xem chi tiết, mở tài liệu, bật giao diện tối.
- Trạng thái loading, lỗi, rỗng và thông báo thao tác.

## Kiến trúc và cấu trúc

```text
lib/
├── main.dart
├── functions.dart
├── database/
│   ├── schema_versions.dart
│   ├── study_database.dart
│   ├── study_database.g.dart
│   └── tables.dart
├── pages/
├── struct/
└── widgets/
```

`pages/` điều phối màn hình và tương tác; `widgets/` chứa thành phần UI tái sử dụng; `struct/` chứa nghiệp vụ tài liệu, khởi tạo DB và state thiết lập; `database/` giữ schema, migration, CRUD/query Drift; `functions.dart` giữ hàm tiện ích và lưu tệp. Phân lớp chi tiết và sơ đồ có ở [architecture.md](architecture.md) và [diagrams/architecture_and_flows.md](diagrams/architecture_and_flows.md).

## Database

`Documents` dùng khóa chính tự tăng và lưu title, description, subject, category, documentType, filePath, fileName, tags, createdAt, updatedAt, isFavorite. Schema version 2 bổ sung migration v1 → v2 cho `isFavorite`. Mã generated Drift được tạo từ bảng và database source, không chỉnh sửa thủ công.

## Kiểm thử

```powershell
flutter test
flutter analyze
```

Test gồm CRUD/search qua SQLite in-memory, migration nâng cấp trên SQLite v1 thật, callback presentation và static architecture-separation. Dùng `dart run build_runner build` để tái tạo generated Drift code sau khi đổi schema.

## Tài liệu dự án

- [requirements.md](requirements.md): functional requirements, use cases và data flow.
- [architecture.md](architecture.md): phân tích kiến trúc, dependency, modularity và mở rộng.
- [diagrams/architecture_and_flows.md](diagrams/architecture_and_flows.md): Mermaid architecture, DFD và ERD.
- [report/cashew_architecture_report.md](report/cashew_architecture_report.md): báo cáo giải trình áp dụng kiến trúc Cashew theo source thực tế.
- [report/final_report.md](report/final_report.md): kiểm tra source, test cases và final checklist có bằng chứng.
