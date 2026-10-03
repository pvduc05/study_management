import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../database/study_database.dart';
import '../functions.dart';
import '../struct/documentFunctions.dart';
import 'globalSnackbar.dart';

class DocumentForm extends StatefulWidget {
  const DocumentForm({required this.onSave, this.document, super.key});

  final StudyDocument? document;
  final Future<void> Function(DocumentDraft draft) onSave;

  @override
  State<DocumentForm> createState() => _DocumentFormState();
}

class _DocumentFormState extends State<DocumentForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _description;
  late final TextEditingController _subject;
  late final TextEditingController _tags;
  late final TextEditingController _source;
  late String _category;
  late String _type;
  String? _fileName;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final document = widget.document;
    _title = TextEditingController(text: document?.title ?? '');
    _description = TextEditingController(text: document?.description ?? '');
    _subject = TextEditingController(text: document?.subject ?? '');
    _tags = TextEditingController(text: document?.tags ?? '');
    _source = TextEditingController(text: document?.filePath ?? '');
    _category = document?.category ?? documentCategories.last;
    _type = document?.documentType ?? documentTypes.first;
    _fileName = document?.fileName;
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _subject.dispose();
    _tags.dispose();
    _source.dispose();
    super.dispose();
  }

  Future<void> _selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null || result.files.isEmpty) return;
    try {
      final stored = await storePickedFile(result.files.single);
      if (!mounted) return;
      setState(() {
        _source.text = stored.path;
        _fileName = result.files.single.name;
      });
    } on Exception catch (error) {
      if (mounted) showAppSnackbar(context, error.toString(), error: true);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await widget.onSave(
        DocumentDraft(
          title: _title.text,
          description: _description.text,
          subject: _subject.text,
          category: _category,
          documentType: _type,
          tags: _tags.text,
          filePath: _source.text.trim().isEmpty ? null : _source.text.trim(),
          fileName: _fileName,
        ),
      );
    } on Exception catch (error) {
      if (mounted) showAppSnackbar(context, error.toString(), error: true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) => Form(
    key: _formKey,
    child: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        TextFormField(
          controller: _title,
          maxLength: 200,
          decoration: const InputDecoration(
            labelText: 'Tên tài liệu *',
            border: OutlineInputBorder(),
          ),
          validator: (value) => value == null || value.trim().isEmpty
              ? 'Nhập tên tài liệu'
              : null,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _description,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Mô tả',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _subject,
          decoration: const InputDecoration(
            labelText: 'Môn học',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _category,
          decoration: const InputDecoration(
            labelText: 'Danh mục',
            border: OutlineInputBorder(),
          ),
          items: documentCategories
              .map(
                (value) => DropdownMenuItem(value: value, child: Text(value)),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) setState(() => _category = value);
          },
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _type,
          decoration: const InputDecoration(
            labelText: 'Loại tài liệu *',
            border: OutlineInputBorder(),
          ),
          items: documentTypes
              .map(
                (value) => DropdownMenuItem(value: value, child: Text(value)),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) setState(() => _type = value);
          },
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _tags,
          decoration: const InputDecoration(
            labelText: 'Tags',
            hintText: 'flutter, mobile, bài giảng',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _source,
          decoration: InputDecoration(
            labelText: 'URL hoặc đường dẫn tài liệu',
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              tooltip: 'Chọn tệp',
              onPressed: _selectFile,
              icon: const Icon(Icons.attach_file),
            ),
          ),
          onChanged: (_) => _fileName = null,
        ),
        if (_fileName != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('Tệp: $_fileName'),
          ),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: _saving ? null : _submit,
          icon: _saving
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.save_outlined),
          label: Text(_saving ? 'Đang lưu...' : 'Lưu tài liệu'),
        ),
      ],
    ),
  );
}
