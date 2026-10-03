import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/study_database.dart';
import '../struct/documentFunctions.dart';
import '../widgets/documentEntry/documentEntry.dart';
import '../widgets/emptyState.dart';
import '../widgets/globalSnackbar.dart';
import 'documentDetailsPage.dart';

class DocumentsListPage extends StatefulWidget {
  const DocumentsListPage({super.key});

  @override
  State<DocumentsListPage> createState() => _DocumentsListPageState();
}

class _DocumentsListPageState extends State<DocumentsListPage> {
  late Future<List<StudyDocument>> _documents;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _documents = context.read<DocumentFunctions>().getDocuments();
  }

  Future<void> _openDetails(StudyDocument document) async {
    final changed = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => DocumentDetailsPage(documentId: document.id),
      ),
    );
    if (changed == true && mounted) setState(_reload);
  }

  Future<void> _toggleFavorite(StudyDocument document) async {
    try {
      await context.read<DocumentFunctions>().toggleFavorite(document);
      if (mounted) setState(_reload);
    } on Exception catch (error) {
      if (mounted) showAppSnackbar(context, error.toString(), error: true);
    }
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<List<StudyDocument>>(
    future: _documents,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasError) {
        return Center(
          child: Text('Không tải được tài liệu: ${snapshot.error}'),
        );
      }
      final documents = snapshot.data ?? [];
      if (documents.isEmpty) {
        return const EmptyState(
          title: 'Chưa có tài liệu',
          message: 'Nhấn nút + để thêm bài giảng, giáo trình hoặc đường dẫn.',
        );
      }
      return RefreshIndicator(
        onRefresh: () async => setState(_reload),
        child: ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) => DocumentEntry(
            document: documents[index],
            onTap: () => _openDetails(documents[index]),
            onFavorite: () => _toggleFavorite(documents[index]),
          ),
        ),
      );
    },
  );
}
