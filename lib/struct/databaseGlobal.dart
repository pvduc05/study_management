import 'dart:io';

import 'package:drift/native.dart';
import 'package:path/path.dart' as paths;
import 'package:path_provider/path_provider.dart';

import '../database/study_database.dart';

class DatabaseGlobal {
  StudyDatabase? _database;

  Future<StudyDatabase> initialize() async {
    if (_database != null) return _database!;
    final appDirectory = await getApplicationSupportDirectory();
    final databaseFile = paths.join(appDirectory.path, 'study_docs.sqlite');
    _database = StudyDatabase(
      NativeDatabase.createInBackground(
        File(databaseFile),
        setup: (database) {
          database.execute('PRAGMA journal_mode = WAL');
        },
      ),
    );
    await _database!.customSelect('SELECT 1').get();
    return _database!;
  }

  Future<void> close() async {
    await _database?.close();
    _database = null;
  }
}
