import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_docs/struct/documentFunctions.dart';
import 'package:study_docs/widgets/documentForm.dart';

void main() {
  testWidgets('form passes validated input to its application callback', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    DocumentDraft? savedDraft;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DocumentForm(onSave: (draft) async => savedDraft = draft),
        ),
      ),
    );

    await tester.enterText(
      find.byType(TextFormField).first,
      'Bài giảng Flutter',
    );
    final saveButton = find.text('Lưu tài liệu');
    await tester.ensureVisible(saveButton);
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    expect(savedDraft, isNotNull);
    expect(savedDraft!.title, 'Bài giảng Flutter');
    expect(savedDraft!.documentType, 'Lecture');
  });
}
