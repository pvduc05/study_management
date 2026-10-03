import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;
import 'package:study_docs/database/study_database.dart';

void main() {
  test('upgrades schema version 1 by adding the favorite column', () async {
    final directory = await Directory.systemTemp.createTemp('study_docs_test');
    final path = '${directory.path}${Platform.pathSeparator}legacy.sqlite';
    final legacy = sqlite.sqlite3.open(path);
    legacy.execute('''
      CREATE TABLE documents (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL DEFAULT '',
        subject TEXT NOT NULL DEFAULT '',
        category TEXT NOT NULL DEFAULT 'Khác',
        document_type TEXT NOT NULL,
        file_path TEXT,
        file_name TEXT,
        tags TEXT NOT NULL DEFAULT '',
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');
    legacy.execute('PRAGMA user_version = 1');
    legacy.close();

    final database = StudyDatabase(NativeDatabase(File(path)));
    try {
      await database.getDocuments();
      expect(database.schemaVersion, 2);
      final rows = await database
          .customSelect('PRAGMA table_info(documents)')
          .get();
      expect(
        rows.map((row) => row.read<String>('name')),
        contains('is_favorite'),
      );
    } finally {
      await database.close();
      await directory.delete(recursive: true);
    }
  });
}
