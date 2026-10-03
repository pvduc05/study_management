import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/study_database.dart';
import '../struct/documentFunctions.dart';
import '../widgets/documentEntry/documentEntry.dart';
import '../widgets/emptyState.dart';
import '../widgets/globalSnackbar.dart';
import 'documentDetailsPage.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<List<StudyDocument>> _documents;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _documents = context.read<DocumentFunctions>().getFavorites();
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
          child: Text('Không tải được yêu thích: ${snapshot.error}'),
        );
      }
      final documents = snapshot.data ?? [];
      if (documents.isEmpty) {
        return const EmptyState(
          title: 'Chưa có mục yêu thích',
          message: 'Đánh dấu sao cho tài liệu để xem lại tại đây.',
          icon: Icons.star_border,
        );
      }
      return ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) => DocumentEntry(
          document: documents[index],
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  DocumentDetailsPage(documentId: documents[index].id),
            ),
          ),
          onFavorite: () async {
            try {
              await context.read<DocumentFunctions>().toggleFavorite(
                documents[index],
              );
              if (mounted) setState(_reload);
            } on Exception catch (error) {
              if (context.mounted) {
                showAppSnackbar(context, error.toString(), error: true);
              }
            }
          },
        ),
      );
    },
  );
}
