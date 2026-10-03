import 'package:drift/drift.dart' show Value;

import '../database/study_database.dart';
import '../functions.dart';

class DocumentDraft {
  const DocumentDraft({
    required this.title,
    required this.description,
    required this.subject,
    required this.category,
    required this.documentType,
    required this.tags,
    this.filePath,
    this.fileName,
  });

  final String title;
  final String description;
  final String subject;
  final String category;
  final String documentType;
  final String tags;
  final String? filePath;
  final String? fileName;
}

class DocumentFunctions {
  const DocumentFunctions(this.database);

  final StudyDatabase database;

  Future<int> addDocument(DocumentDraft draft) async {
    _validate(draft);
    final now = DateTime.now();
    return database.createDocument(
      DocumentsCompanion.insert(
        title: draft.title.trim(),
        description: Value(draft.description.trim()),
        subject: Value(draft.subject.trim()),
        category: Value(draft.category),
        documentType: draft.documentType,
        filePath: Value(draft.filePath),
        fileName: Value(draft.fileName),
        tags: Value(parseTags(draft.tags).join(', ')),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  Future<void> updateDocument(int id, DocumentDraft draft) async {
    _validate(draft);
    final existing = await database.getDocument(id);
    if (existing == null) {
      throw Exception('Không tìm thấy tài liệu cần cập nhật.');
    }
    await database.updateDocument(
      DocumentsCompanion(
        id: Value(id),
        title: Value(draft.title.trim()),
        description: Value(draft.description.trim()),
        subject: Value(draft.subject.trim()),
        category: Value(draft.category),
        documentType: Value(draft.documentType),
        filePath: Value(draft.filePath),
        fileName: Value(draft.fileName),
        tags: Value(parseTags(draft.tags).join(', ')),
        createdAt: Value(existing.createdAt),
        updatedAt: Value(DateTime.now()),
        isFavorite: Value(existing.isFavorite),
      ),
    );
  }

  Future<void> deleteDocument(int id) async {
    final deletedCount = await database.deleteDocument(id);
    if (deletedCount == 0) {
      throw Exception('Tài liệu không còn tồn tại.');
    }
  }

  Future<List<StudyDocument>> getDocuments() => database.getDocuments();

  Future<StudyDocument?> getDocument(int id) => database.getDocument(id);

  Future<List<StudyDocument>> searchDocuments(String query) =>
      database.searchDocuments(query);

  Future<List<StudyDocument>> filterDocuments({
    String? subject,
    String? documentType,
  }) async {
    final documents = await database.getDocuments();
    return documents
        .where((document) {
          final matchesSubject =
              subject == null || subject.isEmpty || document.subject == subject;
          final matchesType =
              documentType == null ||
              documentType.isEmpty ||
              document.documentType == documentType;
          return matchesSubject && matchesType;
        })
        .toList(growable: false);
  }

  Future<void> toggleFavorite(StudyDocument document) =>
      database.setFavorite(document.id, !document.isFavorite);

  Future<List<StudyDocument>> getFavorites() => database.getFavorites();

  void _validate(DocumentDraft draft) {
    if (draft.title.trim().isEmpty) {
      throw FormatException('Tên tài liệu không được để trống.');
    }
    if (draft.title.trim().length > 200) {
      throw FormatException('Tên tài liệu không được vượt quá 200 ký tự.');
    }
    if (draft.documentType.trim().isEmpty) {
      throw FormatException('Vui lòng chọn loại tài liệu.');
    }
    if (draft.documentType == 'Link') {
      final uri = Uri.tryParse(draft.filePath?.trim() ?? '');
      if (uri == null ||
          !uri.hasScheme ||
          !{'http', 'https'}.contains(uri.scheme.toLowerCase())) {
        throw FormatException(
          'Tài liệu loại Link cần URL HTTP hoặc HTTPS hợp lệ.',
        );
      }
    }
  }
}
