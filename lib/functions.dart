import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as paths;
import 'package:path_provider/path_provider.dart';

const documentTypes = [
  'Lecture',
  'Exercise',
  'Reference',
  'Textbook',
  'Slide',
  'PDF',
  'Link',
  'Other',
];

const documentCategories = [
  'Công nghệ phần mềm',
  'Lập trình',
  'Cơ sở dữ liệu',
  'Mạng máy tính',
  'Trí tuệ nhân tạo',
  'Hệ điều hành',
  'Kiểm thử phần mềm',
  'Khác',
];

List<String> parseTags(String value) => value
    .split(',')
    .map((tag) => tag.trim())
    .where((tag) => tag.isNotEmpty)
    .toSet()
    .toList(growable: false);

String formatDate(DateTime value) {
  final date = value.toLocal();
  return '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/${date.year}';
}

Future<File> storePickedFile(PlatformFile pickedFile) async {
  final sourcePath = pickedFile.path;
  if (sourcePath == null) {
    throw const FileSystemException(
      'Không thể truy cập đường dẫn tệp đã chọn.',
    );
  }
  final appDirectory = await getApplicationDocumentsDirectory();
  final storageDirectory = Directory(
    paths.join(appDirectory.path, 'StudyDocs', 'documents'),
  );
  await storageDirectory.create(recursive: true);
  final safeName = paths.basename(pickedFile.name);
  final destination = paths.join(
    storageDirectory.path,
    '${DateTime.now().microsecondsSinceEpoch}_$safeName',
  );
  return File(sourcePath).copy(destination);
}
