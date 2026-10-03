import 'package:flutter/material.dart';

class DocumentSearchBar extends StatelessWidget {
  const DocumentSearchBar({
    required this.controller,
    required this.onChanged,
    this.hintText = 'Tìm theo tên, môn học, loại hoặc tags',
    super.key,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    onChanged: onChanged,
    decoration: InputDecoration(
      hintText: hintText,
      prefixIcon: const Icon(Icons.search),
      suffixIcon: controller.text.isEmpty
          ? null
          : IconButton(
              tooltip: 'Xóa tìm kiếm',
              onPressed: () {
                controller.clear();
                onChanged('');
              },
              icon: const Icon(Icons.clear),
            ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
