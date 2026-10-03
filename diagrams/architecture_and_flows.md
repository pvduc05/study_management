# Architecture and data-flow diagrams

## Tổng quan kiến trúc StudyDocs

```mermaid
flowchart TD
    USER[User]
    subgraph PRESENTATION[Presentation]
        NAV[NavigationFramework]
        PAGES[Pages]
        WIDGETS[Reusable widgets]
        FORM[DocumentForm]
    end
    subgraph LOGIC[Application logic]
        DF[DocumentFunctions]
        UTIL[functions.dart utilities]
        STATE[AppState]
    end
    subgraph DATA[Data access]
        DB[StudyDatabase]
        DRIFT[Drift generated queries]
    end
    subgraph STORAGE[Local storage]
        SQL[(SQLite)]
        FILES[App documents directory]
        PREFS[SharedPreferences]
    end
    USER --> NAV
    NAV --> PAGES
    PAGES --> WIDGETS
    PAGES --> DF
    FORM --> UTIL
    DF --> DB
    DB --> DRIFT
    DRIFT --> SQL
    UTIL --> FILES
    STATE --> PREFS
```

`DocumentForm` nhận callback do Page cung cấp; thao tác database chỉ được gọi qua `DocumentFunctions`. `functions.dart` xử lý tiện ích định dạng/tags và sao chép file, không phát sinh SQL.

## DFD thêm tài liệu

```mermaid
flowchart TD
    U[User]
    P[AddDocumentPage]
    F[DocumentForm validation and draft]
    L[DocumentFunctions.addDocument]
    DB[StudyDatabase.createDocument]
    D[Drift insert]
    SQL[(SQLite)]
    U --> P --> F --> L --> DB --> D --> SQL
```

## DFD sửa tài liệu

```mermaid
flowchart TD
    U[User]
    DETAIL[DocumentDetailsPage]
    EDIT[EditDocumentPage and DocumentForm]
    LOGIC[DocumentFunctions.updateDocument]
    LOOKUP[StudyDatabase.getDocument by ID]
    UPDATE[StudyDatabase.updateDocument]
    DRIFT[Drift UPDATE]
    SQL[(SQLite)]
    U --> DETAIL --> EDIT --> LOGIC
    LOGIC --> LOOKUP --> SQL
    LOGIC --> UPDATE --> DRIFT --> SQL
```

## DFD xóa tài liệu

```mermaid
flowchart TD
    U[User]
    DETAIL[DocumentDetailsPage]
    CONFIRM{Bạn có chắc chắn muốn xóa tài liệu này?}
    LOGIC[DocumentFunctions.deleteDocument]
    DB[StudyDatabase.deleteDocument ID]
    DRIFT[Drift DELETE]
    SQL[(SQLite)]
    U --> DETAIL --> CONFIRM
    CONFIRM -- Hủy --> DETAIL
    CONFIRM -- Xác nhận --> LOGIC --> DB --> DRIFT --> SQL
```

## DFD tìm kiếm tài liệu

```mermaid
flowchart TD
    U[User]
    BAR[DocumentSearchBar]
    PAGE[SearchDocumentsPage]
    LOGIC[DocumentFunctions.searchDocuments]
    DB[StudyDatabase.searchDocuments]
    DRIFT[Drift LIKE query]
    SQL[(SQLite)]
    RESULTS[Search results]
    U --> BAR --> PAGE --> LOGIC --> DB --> DRIFT --> SQL
    SQL --> RESULTS --> PAGE
```

## ERD

```mermaid
erDiagram
    DOCUMENTS {
        integer id PK
        string title
        string description
        string subject
        string category
        string documentType
        string filePath
        string fileName
        string tags
        datetime createdAt
        datetime updatedAt
        boolean isFavorite
    }
```
