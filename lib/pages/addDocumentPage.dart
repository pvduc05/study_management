import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../struct/documentFunctions.dart';
import '../widgets/documentForm.dart';
import '../widgets/globalSnackbar.dart';

class AddDocumentPage extends StatelessWidget {
  const AddDocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final functions = context.read<DocumentFunctions>();
    return Scaffold(
      appBar: AppBar(title: const Text('Thêm tài liệu')),
      body: DocumentForm(
        onSave: (draft) async {
          await functions.addDocument(draft);
          if (!context.mounted) return;
          showAppSnackbar(context, 'Đã thêm tài liệu.');
          Navigator.of(context).pop(true);
        },
      ),
    );
  }
}
