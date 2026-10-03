import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../struct/documentFunctions.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.onOpenDocuments,
    required this.onOpenSearch,
    super.key,
  });

  final VoidCallback onOpenDocuments;
  final VoidCallback onOpenSearch;

  @override
  Widget build(BuildContext context) {
    final functions = context.read<DocumentFunctions>();
    return FutureBuilder(
      future: functions.getDocuments(),
      builder: (context, snapshot) {
        final count = snapshot.data?.length ?? 0;
        final favorites =
            snapshot.data?.where((document) => document.isFavorite).length ?? 0;
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Không gian học tập của bạn',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text(
              'Lưu trữ, tìm kiếm và quản lý tài liệu học tập tại một nơi.',
            ),
            const SizedBox(height: 24),
            if (snapshot.hasError)
              Text('Không tải được thống kê: ${snapshot.error}')
            else if (snapshot.connectionState == ConnectionState.waiting)
              const LinearProgressIndicator()
            else
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _SummaryCard(
                    label: 'Tài liệu',
                    value: '$count',
                    icon: Icons.folder,
                  ),
                  _SummaryCard(
                    label: 'Yêu thích',
                    value: '$favorites',
                    icon: Icons.star,
                  ),
                ],
              ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onOpenDocuments,
              icon: const Icon(Icons.library_books_outlined),
              label: const Text('Xem tất cả tài liệu'),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: onOpenSearch,
              icon: const Icon(Icons.search),
              label: const Text('Tìm tài liệu'),
            ),
          ],
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 180,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon),
            const SizedBox(height: 12),
            Text(value, style: Theme.of(context).textTheme.headlineMedium),
            Text(label),
          ],
        ),
      ),
    ),
  );
}
