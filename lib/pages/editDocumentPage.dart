import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/study_database.dart';
import '../struct/documentFunctions.dart';
import '../widgets/documentForm.dart';
import '../widgets/globalSnackbar.dart';

class EditDocumentPage extends StatelessWidget {
  const EditDocumentPage({required this.document, super.key});

  final StudyDocument document;

  @override
  Widget build(BuildContext context) {
    final functions = context.read<DocumentFunctions>();
    return Scaffold(
      appBar: AppBar(title: const Text('Chỉnh sửa tài liệu')),
      body: DocumentForm(
        document: document,
        onSave: (draft) async {
          await functions.updateDocument(document.id, draft);
          if (!context.mounted) return;
          showAppSnackbar(context, 'Đã cập nhật tài liệu.');
          Navigator.of(context).pop(true);
        },
      ),
    );
  }
}
