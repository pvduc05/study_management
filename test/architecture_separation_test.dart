import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'pages and widgets do not contain direct SQL or write operations',
    () async {
      for (final folder in ['lib/pages', 'lib/widgets']) {
        final directory = Directory(folder);
        await for (final entity in directory.list(recursive: true)) {
          if (entity is! File || !entity.path.endsWith('.dart')) continue;
          final source = await entity.readAsString();
          expect(source, isNot(contains('customSelect(')), reason: entity.path);
          expect(source, isNot(contains('into(')), reason: entity.path);
          expect(source, isNot(contains('..where(')), reason: entity.path);
        }
      }
    },
  );

  test('application logic has no widget or BuildContext dependency', () async {
    final source = await File('lib/struct/documentFunctions.dart')
        .readAsString();
    expect(source, isNot(contains('BuildContext')));
    expect(source, isNot(contains('package:flutter/')));
  });

  test('database module has no presentation dependency', () async {
    final directory = Directory('lib/database');
    await for (final entity in directory.list(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      final source = await entity.readAsString();
      expect(
        source,
        isNot(contains('package:flutter/material.dart')),
        reason: entity.path,
      );
      expect(source, isNot(contains('Widget')), reason: entity.path);
    }
  });

  test('search page delegates to application logic rather than SQL', () async {
    final source = await File('lib/pages/searchDocumentsPage.dart')
        .readAsString();
    expect(source, contains('.searchDocuments(query)'));
    expect(source, isNot(contains('LIKE')));
    expect(source, isNot(contains('customSelect(')));
  });
}
