import 'package:flutter_test/flutter_test.dart';
import 'package:study_docs/database/study_database.dart';
import 'package:study_docs/struct/documentFunctions.dart';

void main() {
  late StudyDatabase database;
  late DocumentFunctions functions;

  setUp(() {
    database = StudyDatabase(createInMemoryExecutor());
    functions = DocumentFunctions(database);
  });

  tearDown(() async {
    await database.close();
  });

  DocumentDraft draft({
    String title = 'Flutter nhập môn',
    String subject = 'Lập trình di động',
    String type = 'Lecture',
    String tags = 'flutter, mobile',
  }) => DocumentDraft(
    title: title,
    description: 'Ghi chú bài học',
    subject: subject,
    category: 'Lập trình',
    documentType: type,
    tags: tags,
  );

  test('create, read, update and delete persist one database row', () async {
    final id = await functions.addDocument(draft());
    final original = await functions.getDocument(id);
    expect(original, isNotNull);
    expect(original!.title, 'Flutter nhập môn');

    await functions.updateDocument(id, draft(title: 'Flutter nâng cao'));
    final updated = await functions.getDocument(id);
    expect(updated!.id, id);
    expect(updated.title, 'Flutter nâng cao');
    expect(await functions.getDocuments(), hasLength(1));

    await functions.deleteDocument(id);
    expect(await functions.getDocument(id), isNull);
    expect(await functions.getDocuments(), isEmpty);
  });

  test('search matches title, subject, type and tags', () async {
    await functions.addDocument(draft());
    await functions.addDocument(
      draft(
        title: 'Mô hình quan hệ',
        subject: 'Cơ sở dữ liệu',
        type: 'Textbook',
        tags: 'sql, normalization',
      ),
    );

    expect(await functions.searchDocuments('FLUTTER'), hasLength(1));
    expect(await functions.searchDocuments('dữ liệu'), hasLength(1));
    expect(await functions.searchDocuments('Textbook'), hasLength(1));
    expect(await functions.searchDocuments('normalization'), hasLength(1));
    expect(await functions.searchDocuments(''), hasLength(2));
  });

  test('validation rejects blank title before reaching SQLite', () async {
    await expectLater(
      functions.addDocument(draft(title: '   ')),
      throwsFormatException,
    );
    expect(await functions.getDocuments(), isEmpty);
  });

  test('Link documents require a valid HTTP or HTTPS URL', () async {
    await expectLater(
      functions.addDocument(draft(type: 'Link')),
      throwsFormatException,
    );
    final linkDraft = DocumentDraft(
      title: 'Tài liệu trực tuyến',
      description: '',
      subject: '',
      category: 'Khác',
      documentType: 'Link',
      tags: '',
      filePath: 'https://example.org/notes',
    );
    final id = await functions.addDocument(linkDraft);
    expect(
      (await functions.getDocument(id))!.filePath,
      'https://example.org/notes',
    );
  });

  test(
    'update preserves favorite state and original creation timestamp',
    () async {
      final id = await functions.addDocument(draft());
      final created = (await functions.getDocument(id))!;
      await functions.toggleFavorite(created);
      final favorited = (await functions.getDocument(id))!;

      await functions.updateDocument(id, draft(title: 'Đã chỉnh sửa'));
      final changed = (await functions.getDocument(id))!;
      expect(changed.id, id);
      expect(changed.createdAt, created.createdAt);
      expect(changed.isFavorite, isTrue);
      expect(
        changed.updatedAt.isAfter(favorited.updatedAt) ||
            changed.updatedAt.isAtSameMomentAs(favorited.updatedAt),
        isTrue,
      );
    },
  );
}
