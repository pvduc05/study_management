import 'package:drift/drift.dart';

@DataClassName('StudyDocument')
class Documents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get subject => text().withDefault(const Constant(''))();
  TextColumn get category => text().withDefault(const Constant('Khác'))();
  TextColumn get documentType => text()();
  TextColumn get filePath => text().nullable()();
  TextColumn get fileName => text().nullable()();
  TextColumn get tags => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
}
