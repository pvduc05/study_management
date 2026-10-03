import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../database/study_database.dart';
import '../functions.dart';
import '../struct/documentFunctions.dart';
import '../widgets/documentEntry/documentEntryTag.dart';
import '../widgets/globalSnackbar.dart';
import 'editDocumentPage.dart';

class DocumentDetailsPage extends StatefulWidget {
  const DocumentDetailsPage({required this.documentId, super.key});

  final int documentId;

  @override
  State<DocumentDetailsPage> createState() => _DocumentDetailsPageState();
}

class _DocumentDetailsPageState extends State<DocumentDetailsPage> {
  late Future<StudyDocument?> _document;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _document = context.read<DocumentFunctions>().getDocument(
      widget.documentId,
    );
  }

  Future<void> _edit(StudyDocument document) async {
    final changed = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => EditDocumentPage(document: document)),
    );
    if (changed == true && mounted) setState(_reload);
  }

  Future<void> _delete(StudyDocument document) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Xóa tài liệu'),
        content: const Text('Bạn có chắc chắn muốn xóa tài liệu này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Hủy'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    try {
      await context.read<DocumentFunctions>().deleteDocument(document.id);
      if (!mounted) return;
      showAppSnackbar(context, 'Đã xóa tài liệu.');
      Navigator.of(context).pop(true);
    } on Exception catch (error) {
      if (mounted) showAppSnackbar(context, error.toString(), error: true);
    }
  }

  Future<void> _openSource(StudyDocument document) async {
    final source = document.filePath;
    if (source == null || source.isEmpty) {
      showAppSnackbar(context, 'Tài liệu chưa có tệp hoặc URL.', error: true);
      return;
    }
    final uri = source.startsWith('http')
        ? Uri.tryParse(source)
        : Uri.file(source);
    if (uri == null || !await launchUrl(uri)) {
      if (mounted) {
        showAppSnackbar(context, 'Không thể mở tài liệu.', error: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<StudyDocument?>(
    future: _document,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(
          appBar: AppBar(title: const Text('Chi tiết tài liệu')),
          body: const Center(child: CircularProgressIndicator()),
        );
      }
      final document = snapshot.data;
      if (snapshot.hasError || document == null) {
        return Scaffold(
          appBar: AppBar(title: const Text('Chi tiết tài liệu')),
          body: Center(
            child: Text(
              snapshot.hasError
                  ? 'Không tải được tài liệu: ${snapshot.error}'
                  : 'Tài liệu không tồn tại.',
            ),
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text('Chi tiết tài liệu'),
          actions: [
            IconButton(
              tooltip: 'Chỉnh sửa',
              onPressed: () => _edit(document),
              icon: const Icon(Icons.edit_outlined),
            ),
            IconButton(
              tooltip: 'Xóa',
              onPressed: () => _delete(document),
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              document.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            _DetailRow(label: 'Môn học', value: document.subject),
            _DetailRow(label: 'Danh mục', value: document.category),
            _DetailRow(label: 'Loại', value: document.documentType),
            _DetailRow(
              label: 'Ngày tạo',
              value: formatDate(document.createdAt),
            ),
            _DetailRow(
              label: 'Cập nhật',
              value: formatDate(document.updatedAt),
            ),
            if (document.description.isNotEmpty) ...[
              const SizedBox(height: 20),
              Text('Mô tả', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(document.description),
            ],
            if (document.tags.isNotEmpty) ...[
              const SizedBox(height: 20),
              Text('Tags', style: Theme.of(context).textTheme.titleMedium),
              Wrap(
                spacing: 8,
                children: parseTags(document.tags)
                    .map(DocumentEntryTag.new)
                    .toList(),
              ),
            ],
            if (document.filePath != null) ...[
              const SizedBox(height: 20),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  document.filePath!.startsWith('http')
                      ? Icons.link
                      : Icons.attach_file,
                ),
                title: Text(document.fileName ?? document.filePath!),
                subtitle: document.fileName == null
                    ? null
                    : Text(document.filePath!),
                trailing: const Icon(Icons.open_in_new),
                onTap: () => _openSource(document),
              ),
            ],
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () async {
                try {
                  await context.read<DocumentFunctions>().toggleFavorite(
                    document,
                  );
                  if (mounted) setState(_reload);
                } on Exception catch (error) {
                  if (context.mounted) {
                    showAppSnackbar(context, error.toString(), error: true);
                  }
                }
              },
              icon: Icon(document.isFavorite ? Icons.star : Icons.star_border),
              label: Text(
                document.isFavorite
                    ? 'Bỏ khỏi yêu thích'
                    : 'Thêm vào yêu thích',
              ),
            ),
          ],
        ),
      );
    },
  );
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        SizedBox(
          width: 110,
          child: Text(label, style: Theme.of(context).textTheme.labelLarge),
        ),
        Expanded(child: Text(value.isEmpty ? 'Chưa có' : value)),
      ],
    ),
  );
}
