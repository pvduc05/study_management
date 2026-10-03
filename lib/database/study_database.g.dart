// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_database.dart';

// ignore_for_file: type=lint
class $DocumentsTable extends Documents
    with TableInfo<$DocumentsTable, StudyDocument> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _subjectMeta = const VerificationMeta(
    'subject',
  );
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
    'subject',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Khác'),
  );
  static const VerificationMeta _documentTypeMeta = const VerificationMeta(
    'documentType',
  );
  @override
  late final GeneratedColumn<String> documentType = GeneratedColumn<String>(
    'document_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    subject,
    category,
    documentType,
    filePath,
    fileName,
    tags,
    createdAt,
    updatedAt,
    isFavorite,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudyDocument> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('subject')) {
      context.handle(
        _subjectMeta,
        subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('document_type')) {
      context.handle(
        _documentTypeMeta,
        documentType.isAcceptableOrUnknown(
          data['document_type']!,
          _documentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_documentTypeMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudyDocument map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyDocument(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      subject: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      documentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_type'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      ),
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      ),
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
    );
  }

  @override
  $DocumentsTable createAlias(String alias) {
    return $DocumentsTable(attachedDatabase, alias);
  }
}

class StudyDocument extends DataClass implements Insertable<StudyDocument> {
  final int id;
  final String title;
  final String description;
  final String subject;
  final String category;
  final String documentType;
  final String? filePath;
  final String? fileName;
  final String tags;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isFavorite;
  const StudyDocument({
    required this.id,
    required this.title,
    required this.description,
    required this.subject,
    required this.category,
    required this.documentType,
    this.filePath,
    this.fileName,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
    required this.isFavorite,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['subject'] = Variable<String>(subject);
    map['category'] = Variable<String>(category);
    map['document_type'] = Variable<String>(documentType);
    if (!nullToAbsent || filePath != null) {
      map['file_path'] = Variable<String>(filePath);
    }
    if (!nullToAbsent || fileName != null) {
      map['file_name'] = Variable<String>(fileName);
    }
    map['tags'] = Variable<String>(tags);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      subject: Value(subject),
      category: Value(category),
      documentType: Value(documentType),
      filePath: filePath == null && nullToAbsent
          ? const Value.absent()
          : Value(filePath),
      fileName: fileName == null && nullToAbsent
          ? const Value.absent()
          : Value(fileName),
      tags: Value(tags),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isFavorite: Value(isFavorite),
    );
  }

  factory StudyDocument.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyDocument(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      subject: serializer.fromJson<String>(json['subject']),
      category: serializer.fromJson<String>(json['category']),
      documentType: serializer.fromJson<String>(json['documentType']),
      filePath: serializer.fromJson<String?>(json['filePath']),
      fileName: serializer.fromJson<String?>(json['fileName']),
      tags: serializer.fromJson<String>(json['tags']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'subject': serializer.toJson<String>(subject),
      'category': serializer.toJson<String>(category),
      'documentType': serializer.toJson<String>(documentType),
      'filePath': serializer.toJson<String?>(filePath),
      'fileName': serializer.toJson<String?>(fileName),
      'tags': serializer.toJson<String>(tags),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  StudyDocument copyWith({
    int? id,
    String? title,
    String? description,
    String? subject,
    String? category,
    String? documentType,
    Value<String?> filePath = const Value.absent(),
    Value<String?> fileName = const Value.absent(),
    String? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isFavorite,
  }) => StudyDocument(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    subject: subject ?? this.subject,
    category: category ?? this.category,
    documentType: documentType ?? this.documentType,
    filePath: filePath.present ? filePath.value : this.filePath,
    fileName: fileName.present ? fileName.value : this.fileName,
    tags: tags ?? this.tags,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isFavorite: isFavorite ?? this.isFavorite,
  );
  StudyDocument copyWithCompanion(DocumentsCompanion data) {
    return StudyDocument(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      subject: data.subject.present ? data.subject.value : this.subject,
      category: data.category.present ? data.category.value : this.category,
      documentType: data.documentType.present
          ? data.documentType.value
          : this.documentType,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      tags: data.tags.present ? data.tags.value : this.tags,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudyDocument(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('subject: $subject, ')
          ..write('category: $category, ')
          ..write('documentType: $documentType, ')
          ..write('filePath: $filePath, ')
          ..write('fileName: $fileName, ')
          ..write('tags: $tags, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    subject,
    category,
    documentType,
    filePath,
    fileName,
    tags,
    createdAt,
    updatedAt,
    isFavorite,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudyDocument &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.subject == this.subject &&
          other.category == this.category &&
          other.documentType == this.documentType &&
          other.filePath == this.filePath &&
          other.fileName == this.fileName &&
          other.tags == this.tags &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isFavorite == this.isFavorite);
}

class DocumentsCompanion extends UpdateCompanion<StudyDocument> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> description;
  final Value<String> subject;
  final Value<String> category;
  final Value<String> documentType;
  final Value<String?> filePath;
  final Value<String?> fileName;
  final Value<String> tags;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isFavorite;
  const DocumentsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.subject = const Value.absent(),
    this.category = const Value.absent(),
    this.documentType = const Value.absent(),
    this.filePath = const Value.absent(),
    this.fileName = const Value.absent(),
    this.tags = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isFavorite = const Value.absent(),
  });
  DocumentsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.subject = const Value.absent(),
    this.category = const Value.absent(),
    required String documentType,
    this.filePath = const Value.absent(),
    this.fileName = const Value.absent(),
    this.tags = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isFavorite = const Value.absent(),
  }) : title = Value(title),
       documentType = Value(documentType);
  static Insertable<StudyDocument> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? subject,
    Expression<String>? category,
    Expression<String>? documentType,
    Expression<String>? filePath,
    Expression<String>? fileName,
    Expression<String>? tags,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isFavorite,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (subject != null) 'subject': subject,
      if (category != null) 'category': category,
      if (documentType != null) 'document_type': documentType,
      if (filePath != null) 'file_path': filePath,
      if (fileName != null) 'file_name': fileName,
      if (tags != null) 'tags': tags,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isFavorite != null) 'is_favorite': isFavorite,
    });
  }

  DocumentsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? description,
    Value<String>? subject,
    Value<String>? category,
    Value<String>? documentType,
    Value<String?>? filePath,
    Value<String?>? fileName,
    Value<String>? tags,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isFavorite,
  }) {
    return DocumentsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      subject: subject ?? this.subject,
      category: category ?? this.category,
      documentType: documentType ?? this.documentType,
      filePath: filePath ?? this.filePath,
      fileName: fileName ?? this.fileName,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (documentType.present) {
      map['document_type'] = Variable<String>(documentType.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('subject: $subject, ')
          ..write('category: $category, ')
          ..write('documentType: $documentType, ')
          ..write('filePath: $filePath, ')
          ..write('fileName: $fileName, ')
          ..write('tags: $tags, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }
}

abstract class _$StudyDatabase extends GeneratedDatabase {
  _$StudyDatabase(QueryExecutor e) : super(e);
  $StudyDatabaseManager get managers => $StudyDatabaseManager(this);
  late final $DocumentsTable documents = $DocumentsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [documents];
}

typedef $$DocumentsTableCreateCompanionBuilder = DocumentsCompanion Function({
  Value<int> id,
  required String title,
  Value<String> description,
  Value<String> subject,
  Value<String> category,
  required String documentType,
  Value<String?> filePath,
  Value<String?> fileName,
  Value<String> tags,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> isFavorite,
});
typedef $$DocumentsTableUpdateCompanionBuilder = DocumentsCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> description,
  Value<String> subject,
  Value<String> category,
  Value<String> documentType,
  Value<String?> filePath,
  Value<String?> fileName,
  Value<String> tags,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> isFavorite,
});

class $$DocumentsTableFilterComposer
    extends Composer<_$StudyDatabase, $DocumentsTable> {
  $$DocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DocumentsTableOrderingComposer
    extends Composer<_$StudyDatabase, $DocumentsTable> {
  $$DocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DocumentsTableAnnotationComposer
    extends Composer<_$StudyDatabase, $DocumentsTable> {
  $$DocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );
}

class $$DocumentsTableTableManager
    extends
        RootTableManager<
          _$StudyDatabase,
          $DocumentsTable,
          StudyDocument,
          $$DocumentsTableFilterComposer,
          $$DocumentsTableOrderingComposer,
          $$DocumentsTableAnnotationComposer,
          $$DocumentsTableCreateCompanionBuilder,
          $$DocumentsTableUpdateCompanionBuilder,
          (
            StudyDocument,
            BaseReferences<_$StudyDatabase, $DocumentsTable, StudyDocument>,
          ),
          StudyDocument,
          PrefetchHooks Function()
        > {
  $$DocumentsTableTableManager(_$StudyDatabase db, $DocumentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> subject = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> documentType = const Value.absent(),
                Value<String?> filePath = const Value.absent(),
                Value<String?> fileName = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
              }) => DocumentsCompanion(
                id: id,
                title: title,
                description: description,
                subject: subject,
                category: category,
                documentType: documentType,
                filePath: filePath,
                fileName: fileName,
                tags: tags,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isFavorite: isFavorite,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String> description = const Value.absent(),
                Value<String> subject = const Value.absent(),
                Value<String> category = const Value.absent(),
                required String documentType,
                Value<String?> filePath = const Value.absent(),
                Value<String?> fileName = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
              }) => DocumentsCompanion.insert(
                id: id,
                title: title,
                description: description,
                subject: subject,
                category: category,
                documentType: documentType,
                filePath: filePath,
                fileName: fileName,
                tags: tags,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isFavorite: isFavorite,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DocumentsTable, StudyDocument>(table),
                  BaseReferences<
                    _$StudyDatabase,
                    $DocumentsTable,
                    StudyDocument
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$StudyDatabase,
      $DocumentsTable,
      StudyDocument,
      $$DocumentsTableFilterComposer,
      $$DocumentsTableOrderingComposer,
      $$DocumentsTableAnnotationComposer,
      $$DocumentsTableCreateCompanionBuilder,
      $$DocumentsTableUpdateCompanionBuilder,
      (
        StudyDocument,
        BaseReferences<_$StudyDatabase, $DocumentsTable, StudyDocument>,
      ),
      StudyDocument,
      PrefetchHooks Function()
    >;

class $StudyDatabaseManager {
  final _$StudyDatabase _db;
  $StudyDatabaseManager(this._db);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db, _db.documents);
}
