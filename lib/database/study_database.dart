import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'schema_versions.dart';
import 'tables.dart';

part 'study_database.g.dart';

@DriftDatabase(tables: [Documents])
class StudyDatabase extends _$StudyDatabase {
  StudyDatabase(super.executor);

  @override
  int get schemaVersion => studySchemaVersion;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.addColumn(documents, documents.isFavorite);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  Future<int> createDocument(DocumentsCompanion document) =>
      into(documents).insert(document);

  Future<bool> updateDocument(DocumentsCompanion document) =>
      update(documents).replace(document);

  Future<int> deleteDocument(int id) =>
      (delete(documents)..where((row) => row.id.equals(id))).go();

  Future<StudyDocument?> getDocument(int id) =>
      (select(documents)..where((row) => row.id.equals(id))).getSingleOrNull();

  Future<List<StudyDocument>> getDocuments() async => (select(
    documents,
  )..orderBy([(row) => OrderingTerm.desc(row.createdAt)])).get();

  Future<List<StudyDocument>> getFavorites() async =>
      (select(documents)
            ..where((row) => row.isFavorite.equals(true))
            ..orderBy([(row) => OrderingTerm.desc(row.createdAt)]))
          .get();

  Future<List<StudyDocument>> searchDocuments(String query) async {
    final normalized = query.trim();
    final statement = select(documents);
    if (normalized.isNotEmpty) {
      final pattern = '%$normalized%';
      statement.where(
        (row) =>
            row.title.like(pattern) |
            row.subject.like(pattern) |
            row.documentType.like(pattern) |
            row.category.like(pattern) |
            row.tags.like(pattern),
      );
    }
    statement.orderBy([(row) => OrderingTerm.desc(row.createdAt)]);
    return statement.get();
  }

  Future<void> setFavorite(int id, bool value) async {
    await (update(documents)..where((row) => row.id.equals(id))).write(
      DocumentsCompanion(
        isFavorite: Value(value),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}

QueryExecutor createInMemoryExecutor() => NativeDatabase.memory();
