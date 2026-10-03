# Phân tích yêu cầu và data flow

## Mục tiêu và phạm vi

StudyDocs quản lý tài liệu học tập offline-first. Bản cơ bản dùng Flutter, Drift và SQLite; không có backend. Tệp được sao chép vào vùng lưu trữ tài liệu của ứng dụng; URL được lưu như một nguồn tài liệu. Search được thực hiện từ SQLite thay vì lọc một danh sách RAM.

## Functional requirements

| ID | Chức năng | Mô tả | Bằng chứng triển khai |
|---|---|---|---|
| FR01 | Thêm | Nhập tiêu đề, mô tả, môn học, loại, danh mục, tags và URL/tệp | `pages/addDocumentPage.dart`, `widgets/documentForm.dart`, `struct/documentFunctions.dart` |
| FR02 | Đọc/chi tiết | Hiển thị danh sách và chi tiết tài liệu | `pages/documentsListPage.dart`, `pages/documentDetailsPage.dart` |
| FR03 | Sửa | Cập nhật bản ghi có ID hiện tại, giữ nguyên ngày tạo/yêu thích | `pages/editDocumentPage.dart`, `DocumentFunctions.updateDocument` |
| FR04 | Xóa | Yêu cầu xác nhận trước khi xóa bản ghi | `pages/documentDetailsPage.dart`, `DocumentFunctions.deleteDocument` |
| FR05 | Tìm kiếm | Tìm theo tiêu đề, môn học, loại, danh mục và tags | `pages/searchDocumentsPage.dart`, `StudyDatabase.searchDocuments` |
| FR06 | Yêu thích | Đánh dấu/bỏ đánh dấu và xem danh sách yêu thích | `DocumentFunctions.toggleFavorite`, `pages/favoritesPage.dart` |
| FR07 | File/URL | Chọn, sao chép tệp vào thư mục app; mở tệp/URL | `functions.dart`, `pages/documentDetailsPage.dart` |
| FR08 | Cài đặt | Lưu dark mode trên thiết bị | `struct/appState.dart` |

## Use cases

| Actor | Use case | Luồng chính |
|---|---|---|
| Sinh viên | Thêm tài liệu | Mở form → nhập/đính kèm nguồn → validate → insert Drift/SQLite → nhận thông báo |
| Sinh viên | Sửa tài liệu | Mở chi tiết → sửa → lookup ID → UPDATE cùng ID → tải lại chi tiết |
| Sinh viên | Xóa tài liệu | Mở chi tiết → xác nhận → DELETE theo ID → quay lại danh sách |
| Sinh viên | Tìm kiếm | Nhập từ khóa → application logic → truy vấn `LIKE` → hiển thị kết quả |
| Sinh viên | Yêu thích | Chạm biểu tượng sao → cập nhật boolean trên bản ghi |

## Data flow

DFD tổng quát và DFD thêm/sửa/xóa/tìm kiếm được mô tả bằng Mermaid trong [diagrams/architecture_and_flows.md](diagrams/architecture_and_flows.md). Luồng thực thi trong source:

```text
NavigationFramework / Page
  → DocumentForm hoặc tương tác màn hình
  → DocumentFunctions (validation/điều phối)
  → StudyDatabase (CRUD/query Drift)
  → SQLite native
```

Search đi qua `SearchDocumentsPage → DocumentFunctions.searchDocuments → StudyDatabase.searchDocuments → SQLite LIKE`. Page không tự xây SQL; thao tác ghi không nằm trong widget.
