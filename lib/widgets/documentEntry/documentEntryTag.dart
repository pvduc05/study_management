import 'package:flutter/material.dart';

class DocumentEntryTag extends StatelessWidget {
  const DocumentEntryTag(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) => Chip(
    label: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
    visualDensity: VisualDensity.compact,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    padding: EdgeInsets.zero,
  );
}
