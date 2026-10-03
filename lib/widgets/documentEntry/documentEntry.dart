import 'package:flutter/material.dart';

import '../../database/study_database.dart';
import '../../functions.dart';
import 'documentEntryTag.dart';

class DocumentEntry extends StatelessWidget {
  const DocumentEntry({
    required this.document,
    required this.onTap,
    required this.onFavorite,
    super.key,
  });

  final StudyDocument document;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    final tags = parseTags(document.tags);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          child: Icon(
            document.filePath?.startsWith('http') == true
                ? Icons.link
                : Icons.description_outlined,
          ),
        ),
        title: Text(
          document.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              [
                if (document.subject.isNotEmpty) document.subject,
                document.documentType,
                formatDate(document.updatedAt),
              ].join(' • '),
            ),
            if (tags.isNotEmpty)
              Wrap(
                spacing: 4,
                children: tags.take(3).map(DocumentEntryTag.new).toList(),
              ),
          ],
        ),
        isThreeLine: tags.isNotEmpty,
        trailing: IconButton(
          tooltip: document.isFavorite ? 'Bỏ yêu thích' : 'Yêu thích',
          onPressed: onFavorite,
          icon: Icon(document.isFavorite ? Icons.star : Icons.star_border),
        ),
      ),
    );
  }
}
