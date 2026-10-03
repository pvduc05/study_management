import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/study_database.dart';
import '../struct/documentFunctions.dart';
import '../widgets/documentEntry/documentEntry.dart';
import '../widgets/emptyState.dart';
import '../widgets/globalSnackbar.dart';
import '../widgets/searchBar.dart';
import 'documentDetailsPage.dart';

class SearchDocumentsPage extends StatefulWidget {
  const SearchDocumentsPage({super.key});

  @override
  State<SearchDocumentsPage> createState() => _SearchDocumentsPageState();
}

class _SearchDocumentsPageState extends State<SearchDocumentsPage> {
  final _controller = TextEditingController();
  Future<List<StudyDocument>>? _results;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _search(String query) {
    setState(() {
      _results = context.read<DocumentFunctions>().searchDocuments(query);
    });
  }

  Future<void> _toggleFavorite(StudyDocument document) async {
    try {
      await context.read<DocumentFunctions>().toggleFavorite(document);
      _search(_controller.text);
    } on Exception catch (error) {
      if (mounted) showAppSnackbar(context, error.toString(), error: true);
    }
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: DocumentSearchBar(controller: _controller, onChanged: _search),
      ),
      Expanded(
        child: _results == null
            ? const EmptyState(
                title: 'Tìm tài liệu',
                message:
                    'Nhập từ khóa để tìm theo tên, môn học, loại hoặc tags.',
                icon: Icons.search,
              )
            : FutureBuilder<List<StudyDocument>>(
                future: _results,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Tìm kiếm thất bại: ${snapshot.error}'),
                    );
                  }
                  final documents = snapshot.data ?? [];
                  if (documents.isEmpty) {
                    return const EmptyState(
                      title: 'Không tìm thấy tài liệu',
                      message: 'Thử từ khóa khác.',
                      icon: Icons.search_off,
                    );
                  }
                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final document = documents[index];
                      return DocumentEntry(
                        document: document,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                DocumentDetailsPage(documentId: document.id),
                          ),
                        ),
                        onFavorite: () => _toggleFavorite(document),
                      );
                    },
                  );
                },
              ),
      ),
    ],
  );
}
