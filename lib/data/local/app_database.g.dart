// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ContentPackagesTable extends ContentPackages
    with TableInfo<$ContentPackagesTable, ContentPackage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContentPackagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
      'version', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _generatedAtMeta =
      const VerificationMeta('generatedAt');
  @override
  late final GeneratedColumn<String> generatedAt = GeneratedColumn<String>(
      'generated_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _importedAtMeta =
      const VerificationMeta('importedAt');
  @override
  late final GeneratedColumn<DateTime> importedAt = GeneratedColumn<DateTime>(
      'imported_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, version, generatedAt, importedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'content_packages';
  @override
  VerificationContext validateIntegrity(Insertable<ContentPackage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('generated_at')) {
      context.handle(
          _generatedAtMeta,
          generatedAt.isAcceptableOrUnknown(
              data['generated_at']!, _generatedAtMeta));
    } else if (isInserting) {
      context.missing(_generatedAtMeta);
    }
    if (data.containsKey('imported_at')) {
      context.handle(
          _importedAtMeta,
          importedAt.isAcceptableOrUnknown(
              data['imported_at']!, _importedAtMeta));
    } else if (isInserting) {
      context.missing(_importedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContentPackage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContentPackage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}version'])!,
      generatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}generated_at'])!,
      importedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}imported_at'])!,
    );
  }

  @override
  $ContentPackagesTable createAlias(String alias) {
    return $ContentPackagesTable(attachedDatabase, alias);
  }
}

class ContentPackage extends DataClass implements Insertable<ContentPackage> {
  final String id;
  final String version;
  final String generatedAt;
  final DateTime importedAt;
  const ContentPackage(
      {required this.id,
      required this.version,
      required this.generatedAt,
      required this.importedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['version'] = Variable<String>(version);
    map['generated_at'] = Variable<String>(generatedAt);
    map['imported_at'] = Variable<DateTime>(importedAt);
    return map;
  }

  ContentPackagesCompanion toCompanion(bool nullToAbsent) {
    return ContentPackagesCompanion(
      id: Value(id),
      version: Value(version),
      generatedAt: Value(generatedAt),
      importedAt: Value(importedAt),
    );
  }

  factory ContentPackage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContentPackage(
      id: serializer.fromJson<String>(json['id']),
      version: serializer.fromJson<String>(json['version']),
      generatedAt: serializer.fromJson<String>(json['generatedAt']),
      importedAt: serializer.fromJson<DateTime>(json['importedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'version': serializer.toJson<String>(version),
      'generatedAt': serializer.toJson<String>(generatedAt),
      'importedAt': serializer.toJson<DateTime>(importedAt),
    };
  }

  ContentPackage copyWith(
          {String? id,
          String? version,
          String? generatedAt,
          DateTime? importedAt}) =>
      ContentPackage(
        id: id ?? this.id,
        version: version ?? this.version,
        generatedAt: generatedAt ?? this.generatedAt,
        importedAt: importedAt ?? this.importedAt,
      );
  ContentPackage copyWithCompanion(ContentPackagesCompanion data) {
    return ContentPackage(
      id: data.id.present ? data.id.value : this.id,
      version: data.version.present ? data.version.value : this.version,
      generatedAt:
          data.generatedAt.present ? data.generatedAt.value : this.generatedAt,
      importedAt:
          data.importedAt.present ? data.importedAt.value : this.importedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContentPackage(')
          ..write('id: $id, ')
          ..write('version: $version, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('importedAt: $importedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, version, generatedAt, importedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContentPackage &&
          other.id == this.id &&
          other.version == this.version &&
          other.generatedAt == this.generatedAt &&
          other.importedAt == this.importedAt);
}

class ContentPackagesCompanion extends UpdateCompanion<ContentPackage> {
  final Value<String> id;
  final Value<String> version;
  final Value<String> generatedAt;
  final Value<DateTime> importedAt;
  final Value<int> rowid;
  const ContentPackagesCompanion({
    this.id = const Value.absent(),
    this.version = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.importedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContentPackagesCompanion.insert({
    required String id,
    required String version,
    required String generatedAt,
    required DateTime importedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        version = Value(version),
        generatedAt = Value(generatedAt),
        importedAt = Value(importedAt);
  static Insertable<ContentPackage> custom({
    Expression<String>? id,
    Expression<String>? version,
    Expression<String>? generatedAt,
    Expression<DateTime>? importedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (version != null) 'version': version,
      if (generatedAt != null) 'generated_at': generatedAt,
      if (importedAt != null) 'imported_at': importedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContentPackagesCompanion copyWith(
      {Value<String>? id,
      Value<String>? version,
      Value<String>? generatedAt,
      Value<DateTime>? importedAt,
      Value<int>? rowid}) {
    return ContentPackagesCompanion(
      id: id ?? this.id,
      version: version ?? this.version,
      generatedAt: generatedAt ?? this.generatedAt,
      importedAt: importedAt ?? this.importedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<String>(generatedAt.value);
    }
    if (importedAt.present) {
      map['imported_at'] = Variable<DateTime>(importedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContentPackagesCompanion(')
          ..write('id: $id, ')
          ..write('version: $version, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('importedAt: $importedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TaskContentsTableTable extends TaskContentsTable
    with TableInfo<$TaskContentsTableTable, TaskContentsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskContentsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
      'number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _skillMeta = const VerificationMeta('skill');
  @override
  late final GeneratedColumn<String> skill = GeneratedColumn<String>(
      'skill', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _shortDescriptionMeta =
      const VerificationMeta('shortDescription');
  @override
  late final GeneratedColumn<String> shortDescription = GeneratedColumn<String>(
      'short_description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _officialBasisMeta =
      const VerificationMeta('officialBasis');
  @override
  late final GeneratedColumn<String> officialBasis = GeneratedColumn<String>(
      'official_basis', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isEssayMeta =
      const VerificationMeta('isEssay');
  @override
  late final GeneratedColumn<bool> isEssay = GeneratedColumn<bool>(
      'is_essay', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_essay" IN (0, 1))'));
  static const VerificationMeta _tagsJsonMeta =
      const VerificationMeta('tagsJson');
  @override
  late final GeneratedColumn<String> tagsJson = GeneratedColumn<String>(
      'tags_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        number,
        title,
        skill,
        shortDescription,
        officialBasis,
        isEssay,
        tagsJson
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task_contents_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TaskContentsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('number')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['number']!, _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('skill')) {
      context.handle(
          _skillMeta, skill.isAcceptableOrUnknown(data['skill']!, _skillMeta));
    } else if (isInserting) {
      context.missing(_skillMeta);
    }
    if (data.containsKey('short_description')) {
      context.handle(
          _shortDescriptionMeta,
          shortDescription.isAcceptableOrUnknown(
              data['short_description']!, _shortDescriptionMeta));
    } else if (isInserting) {
      context.missing(_shortDescriptionMeta);
    }
    if (data.containsKey('official_basis')) {
      context.handle(
          _officialBasisMeta,
          officialBasis.isAcceptableOrUnknown(
              data['official_basis']!, _officialBasisMeta));
    } else if (isInserting) {
      context.missing(_officialBasisMeta);
    }
    if (data.containsKey('is_essay')) {
      context.handle(_isEssayMeta,
          isEssay.isAcceptableOrUnknown(data['is_essay']!, _isEssayMeta));
    } else if (isInserting) {
      context.missing(_isEssayMeta);
    }
    if (data.containsKey('tags_json')) {
      context.handle(_tagsJsonMeta,
          tagsJson.isAcceptableOrUnknown(data['tags_json']!, _tagsJsonMeta));
    } else if (isInserting) {
      context.missing(_tagsJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskContentsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskContentsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      number: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}number'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      skill: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}skill'])!,
      shortDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}short_description'])!,
      officialBasis: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}official_basis'])!,
      isEssay: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_essay'])!,
      tagsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags_json'])!,
    );
  }

  @override
  $TaskContentsTableTable createAlias(String alias) {
    return $TaskContentsTableTable(attachedDatabase, alias);
  }
}

class TaskContentsTableData extends DataClass
    implements Insertable<TaskContentsTableData> {
  final String id;
  final int number;
  final String title;
  final String skill;
  final String shortDescription;
  final String officialBasis;
  final bool isEssay;
  final String tagsJson;
  const TaskContentsTableData(
      {required this.id,
      required this.number,
      required this.title,
      required this.skill,
      required this.shortDescription,
      required this.officialBasis,
      required this.isEssay,
      required this.tagsJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['number'] = Variable<int>(number);
    map['title'] = Variable<String>(title);
    map['skill'] = Variable<String>(skill);
    map['short_description'] = Variable<String>(shortDescription);
    map['official_basis'] = Variable<String>(officialBasis);
    map['is_essay'] = Variable<bool>(isEssay);
    map['tags_json'] = Variable<String>(tagsJson);
    return map;
  }

  TaskContentsTableCompanion toCompanion(bool nullToAbsent) {
    return TaskContentsTableCompanion(
      id: Value(id),
      number: Value(number),
      title: Value(title),
      skill: Value(skill),
      shortDescription: Value(shortDescription),
      officialBasis: Value(officialBasis),
      isEssay: Value(isEssay),
      tagsJson: Value(tagsJson),
    );
  }

  factory TaskContentsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskContentsTableData(
      id: serializer.fromJson<String>(json['id']),
      number: serializer.fromJson<int>(json['number']),
      title: serializer.fromJson<String>(json['title']),
      skill: serializer.fromJson<String>(json['skill']),
      shortDescription: serializer.fromJson<String>(json['shortDescription']),
      officialBasis: serializer.fromJson<String>(json['officialBasis']),
      isEssay: serializer.fromJson<bool>(json['isEssay']),
      tagsJson: serializer.fromJson<String>(json['tagsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'number': serializer.toJson<int>(number),
      'title': serializer.toJson<String>(title),
      'skill': serializer.toJson<String>(skill),
      'shortDescription': serializer.toJson<String>(shortDescription),
      'officialBasis': serializer.toJson<String>(officialBasis),
      'isEssay': serializer.toJson<bool>(isEssay),
      'tagsJson': serializer.toJson<String>(tagsJson),
    };
  }

  TaskContentsTableData copyWith(
          {String? id,
          int? number,
          String? title,
          String? skill,
          String? shortDescription,
          String? officialBasis,
          bool? isEssay,
          String? tagsJson}) =>
      TaskContentsTableData(
        id: id ?? this.id,
        number: number ?? this.number,
        title: title ?? this.title,
        skill: skill ?? this.skill,
        shortDescription: shortDescription ?? this.shortDescription,
        officialBasis: officialBasis ?? this.officialBasis,
        isEssay: isEssay ?? this.isEssay,
        tagsJson: tagsJson ?? this.tagsJson,
      );
  TaskContentsTableData copyWithCompanion(TaskContentsTableCompanion data) {
    return TaskContentsTableData(
      id: data.id.present ? data.id.value : this.id,
      number: data.number.present ? data.number.value : this.number,
      title: data.title.present ? data.title.value : this.title,
      skill: data.skill.present ? data.skill.value : this.skill,
      shortDescription: data.shortDescription.present
          ? data.shortDescription.value
          : this.shortDescription,
      officialBasis: data.officialBasis.present
          ? data.officialBasis.value
          : this.officialBasis,
      isEssay: data.isEssay.present ? data.isEssay.value : this.isEssay,
      tagsJson: data.tagsJson.present ? data.tagsJson.value : this.tagsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskContentsTableData(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('title: $title, ')
          ..write('skill: $skill, ')
          ..write('shortDescription: $shortDescription, ')
          ..write('officialBasis: $officialBasis, ')
          ..write('isEssay: $isEssay, ')
          ..write('tagsJson: $tagsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, number, title, skill, shortDescription,
      officialBasis, isEssay, tagsJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskContentsTableData &&
          other.id == this.id &&
          other.number == this.number &&
          other.title == this.title &&
          other.skill == this.skill &&
          other.shortDescription == this.shortDescription &&
          other.officialBasis == this.officialBasis &&
          other.isEssay == this.isEssay &&
          other.tagsJson == this.tagsJson);
}

class TaskContentsTableCompanion
    extends UpdateCompanion<TaskContentsTableData> {
  final Value<String> id;
  final Value<int> number;
  final Value<String> title;
  final Value<String> skill;
  final Value<String> shortDescription;
  final Value<String> officialBasis;
  final Value<bool> isEssay;
  final Value<String> tagsJson;
  final Value<int> rowid;
  const TaskContentsTableCompanion({
    this.id = const Value.absent(),
    this.number = const Value.absent(),
    this.title = const Value.absent(),
    this.skill = const Value.absent(),
    this.shortDescription = const Value.absent(),
    this.officialBasis = const Value.absent(),
    this.isEssay = const Value.absent(),
    this.tagsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TaskContentsTableCompanion.insert({
    required String id,
    required int number,
    required String title,
    required String skill,
    required String shortDescription,
    required String officialBasis,
    required bool isEssay,
    required String tagsJson,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        number = Value(number),
        title = Value(title),
        skill = Value(skill),
        shortDescription = Value(shortDescription),
        officialBasis = Value(officialBasis),
        isEssay = Value(isEssay),
        tagsJson = Value(tagsJson);
  static Insertable<TaskContentsTableData> custom({
    Expression<String>? id,
    Expression<int>? number,
    Expression<String>? title,
    Expression<String>? skill,
    Expression<String>? shortDescription,
    Expression<String>? officialBasis,
    Expression<bool>? isEssay,
    Expression<String>? tagsJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (number != null) 'number': number,
      if (title != null) 'title': title,
      if (skill != null) 'skill': skill,
      if (shortDescription != null) 'short_description': shortDescription,
      if (officialBasis != null) 'official_basis': officialBasis,
      if (isEssay != null) 'is_essay': isEssay,
      if (tagsJson != null) 'tags_json': tagsJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TaskContentsTableCompanion copyWith(
      {Value<String>? id,
      Value<int>? number,
      Value<String>? title,
      Value<String>? skill,
      Value<String>? shortDescription,
      Value<String>? officialBasis,
      Value<bool>? isEssay,
      Value<String>? tagsJson,
      Value<int>? rowid}) {
    return TaskContentsTableCompanion(
      id: id ?? this.id,
      number: number ?? this.number,
      title: title ?? this.title,
      skill: skill ?? this.skill,
      shortDescription: shortDescription ?? this.shortDescription,
      officialBasis: officialBasis ?? this.officialBasis,
      isEssay: isEssay ?? this.isEssay,
      tagsJson: tagsJson ?? this.tagsJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (skill.present) {
      map['skill'] = Variable<String>(skill.value);
    }
    if (shortDescription.present) {
      map['short_description'] = Variable<String>(shortDescription.value);
    }
    if (officialBasis.present) {
      map['official_basis'] = Variable<String>(officialBasis.value);
    }
    if (isEssay.present) {
      map['is_essay'] = Variable<bool>(isEssay.value);
    }
    if (tagsJson.present) {
      map['tags_json'] = Variable<String>(tagsJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskContentsTableCompanion(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('title: $title, ')
          ..write('skill: $skill, ')
          ..write('shortDescription: $shortDescription, ')
          ..write('officialBasis: $officialBasis, ')
          ..write('isEssay: $isEssay, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TaskTheorySectionsTableTable extends TaskTheorySectionsTable
    with TableInfo<$TaskTheorySectionsTableTable, TaskTheorySectionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskTheorySectionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
      'task_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES task_contents_table (id)'));
  static const VerificationMeta _sectionTypeMeta =
      const VerificationMeta('sectionType');
  @override
  late final GeneratedColumn<String> sectionType = GeneratedColumn<String>(
      'section_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderIndexMeta =
      const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
      'order_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pointsJsonMeta =
      const VerificationMeta('pointsJson');
  @override
  late final GeneratedColumn<String> pointsJson = GeneratedColumn<String>(
      'points_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, taskId, sectionType, title, orderIndex, pointsJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task_theory_sections_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TaskTheorySectionsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta));
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('section_type')) {
      context.handle(
          _sectionTypeMeta,
          sectionType.isAcceptableOrUnknown(
              data['section_type']!, _sectionTypeMeta));
    } else if (isInserting) {
      context.missing(_sectionTypeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
          _orderIndexMeta,
          orderIndex.isAcceptableOrUnknown(
              data['order_index']!, _orderIndexMeta));
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('points_json')) {
      context.handle(
          _pointsJsonMeta,
          pointsJson.isAcceptableOrUnknown(
              data['points_json']!, _pointsJsonMeta));
    } else if (isInserting) {
      context.missing(_pointsJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskTheorySectionsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskTheorySectionsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      taskId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task_id'])!,
      sectionType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}section_type'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
      pointsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}points_json'])!,
    );
  }

  @override
  $TaskTheorySectionsTableTable createAlias(String alias) {
    return $TaskTheorySectionsTableTable(attachedDatabase, alias);
  }
}

class TaskTheorySectionsTableData extends DataClass
    implements Insertable<TaskTheorySectionsTableData> {
  final String id;
  final String taskId;
  final String sectionType;
  final String title;
  final int orderIndex;
  final String pointsJson;
  const TaskTheorySectionsTableData(
      {required this.id,
      required this.taskId,
      required this.sectionType,
      required this.title,
      required this.orderIndex,
      required this.pointsJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['task_id'] = Variable<String>(taskId);
    map['section_type'] = Variable<String>(sectionType);
    map['title'] = Variable<String>(title);
    map['order_index'] = Variable<int>(orderIndex);
    map['points_json'] = Variable<String>(pointsJson);
    return map;
  }

  TaskTheorySectionsTableCompanion toCompanion(bool nullToAbsent) {
    return TaskTheorySectionsTableCompanion(
      id: Value(id),
      taskId: Value(taskId),
      sectionType: Value(sectionType),
      title: Value(title),
      orderIndex: Value(orderIndex),
      pointsJson: Value(pointsJson),
    );
  }

  factory TaskTheorySectionsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskTheorySectionsTableData(
      id: serializer.fromJson<String>(json['id']),
      taskId: serializer.fromJson<String>(json['taskId']),
      sectionType: serializer.fromJson<String>(json['sectionType']),
      title: serializer.fromJson<String>(json['title']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      pointsJson: serializer.fromJson<String>(json['pointsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'taskId': serializer.toJson<String>(taskId),
      'sectionType': serializer.toJson<String>(sectionType),
      'title': serializer.toJson<String>(title),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'pointsJson': serializer.toJson<String>(pointsJson),
    };
  }

  TaskTheorySectionsTableData copyWith(
          {String? id,
          String? taskId,
          String? sectionType,
          String? title,
          int? orderIndex,
          String? pointsJson}) =>
      TaskTheorySectionsTableData(
        id: id ?? this.id,
        taskId: taskId ?? this.taskId,
        sectionType: sectionType ?? this.sectionType,
        title: title ?? this.title,
        orderIndex: orderIndex ?? this.orderIndex,
        pointsJson: pointsJson ?? this.pointsJson,
      );
  TaskTheorySectionsTableData copyWithCompanion(
      TaskTheorySectionsTableCompanion data) {
    return TaskTheorySectionsTableData(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      sectionType:
          data.sectionType.present ? data.sectionType.value : this.sectionType,
      title: data.title.present ? data.title.value : this.title,
      orderIndex:
          data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
      pointsJson:
          data.pointsJson.present ? data.pointsJson.value : this.pointsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskTheorySectionsTableData(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('sectionType: $sectionType, ')
          ..write('title: $title, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('pointsJson: $pointsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, taskId, sectionType, title, orderIndex, pointsJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskTheorySectionsTableData &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.sectionType == this.sectionType &&
          other.title == this.title &&
          other.orderIndex == this.orderIndex &&
          other.pointsJson == this.pointsJson);
}

class TaskTheorySectionsTableCompanion
    extends UpdateCompanion<TaskTheorySectionsTableData> {
  final Value<String> id;
  final Value<String> taskId;
  final Value<String> sectionType;
  final Value<String> title;
  final Value<int> orderIndex;
  final Value<String> pointsJson;
  final Value<int> rowid;
  const TaskTheorySectionsTableCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.sectionType = const Value.absent(),
    this.title = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.pointsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TaskTheorySectionsTableCompanion.insert({
    required String id,
    required String taskId,
    required String sectionType,
    required String title,
    required int orderIndex,
    required String pointsJson,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        taskId = Value(taskId),
        sectionType = Value(sectionType),
        title = Value(title),
        orderIndex = Value(orderIndex),
        pointsJson = Value(pointsJson);
  static Insertable<TaskTheorySectionsTableData> custom({
    Expression<String>? id,
    Expression<String>? taskId,
    Expression<String>? sectionType,
    Expression<String>? title,
    Expression<int>? orderIndex,
    Expression<String>? pointsJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (sectionType != null) 'section_type': sectionType,
      if (title != null) 'title': title,
      if (orderIndex != null) 'order_index': orderIndex,
      if (pointsJson != null) 'points_json': pointsJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TaskTheorySectionsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? taskId,
      Value<String>? sectionType,
      Value<String>? title,
      Value<int>? orderIndex,
      Value<String>? pointsJson,
      Value<int>? rowid}) {
    return TaskTheorySectionsTableCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      sectionType: sectionType ?? this.sectionType,
      title: title ?? this.title,
      orderIndex: orderIndex ?? this.orderIndex,
      pointsJson: pointsJson ?? this.pointsJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (sectionType.present) {
      map['section_type'] = Variable<String>(sectionType.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (pointsJson.present) {
      map['points_json'] = Variable<String>(pointsJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskTheorySectionsTableCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('sectionType: $sectionType, ')
          ..write('title: $title, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('pointsJson: $pointsJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TaskSourcesTableTable extends TaskSourcesTable
    with TableInfo<$TaskSourcesTableTable, TaskSourcesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskSourcesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
      'task_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES task_contents_table (id)'));
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
      'kind', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderIndexMeta =
      const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
      'order_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, taskId, label, url, kind, orderIndex];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task_sources_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TaskSourcesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta));
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
          _kindMeta, kind.isAcceptableOrUnknown(data['kind']!, _kindMeta));
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
          _orderIndexMeta,
          orderIndex.isAcceptableOrUnknown(
              data['order_index']!, _orderIndexMeta));
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskSourcesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskSourcesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      taskId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task_id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
      kind: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kind'])!,
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
    );
  }

  @override
  $TaskSourcesTableTable createAlias(String alias) {
    return $TaskSourcesTableTable(attachedDatabase, alias);
  }
}

class TaskSourcesTableData extends DataClass
    implements Insertable<TaskSourcesTableData> {
  final String id;
  final String taskId;
  final String label;
  final String url;
  final String kind;
  final int orderIndex;
  const TaskSourcesTableData(
      {required this.id,
      required this.taskId,
      required this.label,
      required this.url,
      required this.kind,
      required this.orderIndex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['task_id'] = Variable<String>(taskId);
    map['label'] = Variable<String>(label);
    map['url'] = Variable<String>(url);
    map['kind'] = Variable<String>(kind);
    map['order_index'] = Variable<int>(orderIndex);
    return map;
  }

  TaskSourcesTableCompanion toCompanion(bool nullToAbsent) {
    return TaskSourcesTableCompanion(
      id: Value(id),
      taskId: Value(taskId),
      label: Value(label),
      url: Value(url),
      kind: Value(kind),
      orderIndex: Value(orderIndex),
    );
  }

  factory TaskSourcesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskSourcesTableData(
      id: serializer.fromJson<String>(json['id']),
      taskId: serializer.fromJson<String>(json['taskId']),
      label: serializer.fromJson<String>(json['label']),
      url: serializer.fromJson<String>(json['url']),
      kind: serializer.fromJson<String>(json['kind']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'taskId': serializer.toJson<String>(taskId),
      'label': serializer.toJson<String>(label),
      'url': serializer.toJson<String>(url),
      'kind': serializer.toJson<String>(kind),
      'orderIndex': serializer.toJson<int>(orderIndex),
    };
  }

  TaskSourcesTableData copyWith(
          {String? id,
          String? taskId,
          String? label,
          String? url,
          String? kind,
          int? orderIndex}) =>
      TaskSourcesTableData(
        id: id ?? this.id,
        taskId: taskId ?? this.taskId,
        label: label ?? this.label,
        url: url ?? this.url,
        kind: kind ?? this.kind,
        orderIndex: orderIndex ?? this.orderIndex,
      );
  TaskSourcesTableData copyWithCompanion(TaskSourcesTableCompanion data) {
    return TaskSourcesTableData(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      label: data.label.present ? data.label.value : this.label,
      url: data.url.present ? data.url.value : this.url,
      kind: data.kind.present ? data.kind.value : this.kind,
      orderIndex:
          data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskSourcesTableData(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('label: $label, ')
          ..write('url: $url, ')
          ..write('kind: $kind, ')
          ..write('orderIndex: $orderIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, taskId, label, url, kind, orderIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskSourcesTableData &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.label == this.label &&
          other.url == this.url &&
          other.kind == this.kind &&
          other.orderIndex == this.orderIndex);
}

class TaskSourcesTableCompanion extends UpdateCompanion<TaskSourcesTableData> {
  final Value<String> id;
  final Value<String> taskId;
  final Value<String> label;
  final Value<String> url;
  final Value<String> kind;
  final Value<int> orderIndex;
  final Value<int> rowid;
  const TaskSourcesTableCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.label = const Value.absent(),
    this.url = const Value.absent(),
    this.kind = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TaskSourcesTableCompanion.insert({
    required String id,
    required String taskId,
    required String label,
    required String url,
    required String kind,
    required int orderIndex,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        taskId = Value(taskId),
        label = Value(label),
        url = Value(url),
        kind = Value(kind),
        orderIndex = Value(orderIndex);
  static Insertable<TaskSourcesTableData> custom({
    Expression<String>? id,
    Expression<String>? taskId,
    Expression<String>? label,
    Expression<String>? url,
    Expression<String>? kind,
    Expression<int>? orderIndex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (label != null) 'label': label,
      if (url != null) 'url': url,
      if (kind != null) 'kind': kind,
      if (orderIndex != null) 'order_index': orderIndex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TaskSourcesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? taskId,
      Value<String>? label,
      Value<String>? url,
      Value<String>? kind,
      Value<int>? orderIndex,
      Value<int>? rowid}) {
    return TaskSourcesTableCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      label: label ?? this.label,
      url: url ?? this.url,
      kind: kind ?? this.kind,
      orderIndex: orderIndex ?? this.orderIndex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskSourcesTableCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('label: $label, ')
          ..write('url: $url, ')
          ..write('kind: $kind, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PracticeItemsTableTable extends PracticeItemsTable
    with TableInfo<$PracticeItemsTableTable, PracticeItemsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PracticeItemsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
      'task_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES task_contents_table (id)'));
  static const VerificationMeta _taskNumberMeta =
      const VerificationMeta('taskNumber');
  @override
  late final GeneratedColumn<int> taskNumber = GeneratedColumn<int>(
      'task_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _topicMeta = const VerificationMeta('topic');
  @override
  late final GeneratedColumn<String> topic = GeneratedColumn<String>(
      'topic', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _questionMeta =
      const VerificationMeta('question');
  @override
  late final GeneratedColumn<String> question = GeneratedColumn<String>(
      'question', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _optionsJsonMeta =
      const VerificationMeta('optionsJson');
  @override
  late final GeneratedColumn<String> optionsJson = GeneratedColumn<String>(
      'options_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _correctIndexMeta =
      const VerificationMeta('correctIndex');
  @override
  late final GeneratedColumn<int> correctIndex = GeneratedColumn<int>(
      'correct_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _explanationMeta =
      const VerificationMeta('explanation');
  @override
  late final GeneratedColumn<String> explanation = GeneratedColumn<String>(
      'explanation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ruleSummaryMeta =
      const VerificationMeta('ruleSummary');
  @override
  late final GeneratedColumn<String> ruleSummary = GeneratedColumn<String>(
      'rule_summary', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rulePointsJsonMeta =
      const VerificationMeta('rulePointsJson');
  @override
  late final GeneratedColumn<String> rulePointsJson = GeneratedColumn<String>(
      'rule_points_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _difficultyMeta =
      const VerificationMeta('difficulty');
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
      'difficulty', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tagsJsonMeta =
      const VerificationMeta('tagsJson');
  @override
  late final GeneratedColumn<String> tagsJson = GeneratedColumn<String>(
      'tags_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        taskId,
        taskNumber,
        title,
        topic,
        question,
        optionsJson,
        correctIndex,
        explanation,
        ruleSummary,
        rulePointsJson,
        source,
        difficulty,
        tagsJson
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'practice_items_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<PracticeItemsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta));
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('task_number')) {
      context.handle(
          _taskNumberMeta,
          taskNumber.isAcceptableOrUnknown(
              data['task_number']!, _taskNumberMeta));
    } else if (isInserting) {
      context.missing(_taskNumberMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('topic')) {
      context.handle(
          _topicMeta, topic.isAcceptableOrUnknown(data['topic']!, _topicMeta));
    } else if (isInserting) {
      context.missing(_topicMeta);
    }
    if (data.containsKey('question')) {
      context.handle(_questionMeta,
          question.isAcceptableOrUnknown(data['question']!, _questionMeta));
    } else if (isInserting) {
      context.missing(_questionMeta);
    }
    if (data.containsKey('options_json')) {
      context.handle(
          _optionsJsonMeta,
          optionsJson.isAcceptableOrUnknown(
              data['options_json']!, _optionsJsonMeta));
    } else if (isInserting) {
      context.missing(_optionsJsonMeta);
    }
    if (data.containsKey('correct_index')) {
      context.handle(
          _correctIndexMeta,
          correctIndex.isAcceptableOrUnknown(
              data['correct_index']!, _correctIndexMeta));
    } else if (isInserting) {
      context.missing(_correctIndexMeta);
    }
    if (data.containsKey('explanation')) {
      context.handle(
          _explanationMeta,
          explanation.isAcceptableOrUnknown(
              data['explanation']!, _explanationMeta));
    } else if (isInserting) {
      context.missing(_explanationMeta);
    }
    if (data.containsKey('rule_summary')) {
      context.handle(
          _ruleSummaryMeta,
          ruleSummary.isAcceptableOrUnknown(
              data['rule_summary']!, _ruleSummaryMeta));
    } else if (isInserting) {
      context.missing(_ruleSummaryMeta);
    }
    if (data.containsKey('rule_points_json')) {
      context.handle(
          _rulePointsJsonMeta,
          rulePointsJson.isAcceptableOrUnknown(
              data['rule_points_json']!, _rulePointsJsonMeta));
    } else if (isInserting) {
      context.missing(_rulePointsJsonMeta);
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
          _difficultyMeta,
          difficulty.isAcceptableOrUnknown(
              data['difficulty']!, _difficultyMeta));
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('tags_json')) {
      context.handle(_tagsJsonMeta,
          tagsJson.isAcceptableOrUnknown(data['tags_json']!, _tagsJsonMeta));
    } else if (isInserting) {
      context.missing(_tagsJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PracticeItemsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PracticeItemsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      taskId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task_id'])!,
      taskNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}task_number'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      topic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}topic'])!,
      question: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question'])!,
      optionsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}options_json'])!,
      correctIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}correct_index'])!,
      explanation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}explanation'])!,
      ruleSummary: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rule_summary'])!,
      rulePointsJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}rule_points_json'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      difficulty: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}difficulty'])!,
      tagsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags_json'])!,
    );
  }

  @override
  $PracticeItemsTableTable createAlias(String alias) {
    return $PracticeItemsTableTable(attachedDatabase, alias);
  }
}

class PracticeItemsTableData extends DataClass
    implements Insertable<PracticeItemsTableData> {
  final String id;
  final String taskId;
  final int taskNumber;
  final String title;
  final String topic;
  final String question;
  final String optionsJson;
  final int correctIndex;
  final String explanation;
  final String ruleSummary;
  final String rulePointsJson;
  final String source;
  final String difficulty;
  final String tagsJson;
  const PracticeItemsTableData(
      {required this.id,
      required this.taskId,
      required this.taskNumber,
      required this.title,
      required this.topic,
      required this.question,
      required this.optionsJson,
      required this.correctIndex,
      required this.explanation,
      required this.ruleSummary,
      required this.rulePointsJson,
      required this.source,
      required this.difficulty,
      required this.tagsJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['task_id'] = Variable<String>(taskId);
    map['task_number'] = Variable<int>(taskNumber);
    map['title'] = Variable<String>(title);
    map['topic'] = Variable<String>(topic);
    map['question'] = Variable<String>(question);
    map['options_json'] = Variable<String>(optionsJson);
    map['correct_index'] = Variable<int>(correctIndex);
    map['explanation'] = Variable<String>(explanation);
    map['rule_summary'] = Variable<String>(ruleSummary);
    map['rule_points_json'] = Variable<String>(rulePointsJson);
    map['source'] = Variable<String>(source);
    map['difficulty'] = Variable<String>(difficulty);
    map['tags_json'] = Variable<String>(tagsJson);
    return map;
  }

  PracticeItemsTableCompanion toCompanion(bool nullToAbsent) {
    return PracticeItemsTableCompanion(
      id: Value(id),
      taskId: Value(taskId),
      taskNumber: Value(taskNumber),
      title: Value(title),
      topic: Value(topic),
      question: Value(question),
      optionsJson: Value(optionsJson),
      correctIndex: Value(correctIndex),
      explanation: Value(explanation),
      ruleSummary: Value(ruleSummary),
      rulePointsJson: Value(rulePointsJson),
      source: Value(source),
      difficulty: Value(difficulty),
      tagsJson: Value(tagsJson),
    );
  }

  factory PracticeItemsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PracticeItemsTableData(
      id: serializer.fromJson<String>(json['id']),
      taskId: serializer.fromJson<String>(json['taskId']),
      taskNumber: serializer.fromJson<int>(json['taskNumber']),
      title: serializer.fromJson<String>(json['title']),
      topic: serializer.fromJson<String>(json['topic']),
      question: serializer.fromJson<String>(json['question']),
      optionsJson: serializer.fromJson<String>(json['optionsJson']),
      correctIndex: serializer.fromJson<int>(json['correctIndex']),
      explanation: serializer.fromJson<String>(json['explanation']),
      ruleSummary: serializer.fromJson<String>(json['ruleSummary']),
      rulePointsJson: serializer.fromJson<String>(json['rulePointsJson']),
      source: serializer.fromJson<String>(json['source']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      tagsJson: serializer.fromJson<String>(json['tagsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'taskId': serializer.toJson<String>(taskId),
      'taskNumber': serializer.toJson<int>(taskNumber),
      'title': serializer.toJson<String>(title),
      'topic': serializer.toJson<String>(topic),
      'question': serializer.toJson<String>(question),
      'optionsJson': serializer.toJson<String>(optionsJson),
      'correctIndex': serializer.toJson<int>(correctIndex),
      'explanation': serializer.toJson<String>(explanation),
      'ruleSummary': serializer.toJson<String>(ruleSummary),
      'rulePointsJson': serializer.toJson<String>(rulePointsJson),
      'source': serializer.toJson<String>(source),
      'difficulty': serializer.toJson<String>(difficulty),
      'tagsJson': serializer.toJson<String>(tagsJson),
    };
  }

  PracticeItemsTableData copyWith(
          {String? id,
          String? taskId,
          int? taskNumber,
          String? title,
          String? topic,
          String? question,
          String? optionsJson,
          int? correctIndex,
          String? explanation,
          String? ruleSummary,
          String? rulePointsJson,
          String? source,
          String? difficulty,
          String? tagsJson}) =>
      PracticeItemsTableData(
        id: id ?? this.id,
        taskId: taskId ?? this.taskId,
        taskNumber: taskNumber ?? this.taskNumber,
        title: title ?? this.title,
        topic: topic ?? this.topic,
        question: question ?? this.question,
        optionsJson: optionsJson ?? this.optionsJson,
        correctIndex: correctIndex ?? this.correctIndex,
        explanation: explanation ?? this.explanation,
        ruleSummary: ruleSummary ?? this.ruleSummary,
        rulePointsJson: rulePointsJson ?? this.rulePointsJson,
        source: source ?? this.source,
        difficulty: difficulty ?? this.difficulty,
        tagsJson: tagsJson ?? this.tagsJson,
      );
  PracticeItemsTableData copyWithCompanion(PracticeItemsTableCompanion data) {
    return PracticeItemsTableData(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      taskNumber:
          data.taskNumber.present ? data.taskNumber.value : this.taskNumber,
      title: data.title.present ? data.title.value : this.title,
      topic: data.topic.present ? data.topic.value : this.topic,
      question: data.question.present ? data.question.value : this.question,
      optionsJson:
          data.optionsJson.present ? data.optionsJson.value : this.optionsJson,
      correctIndex: data.correctIndex.present
          ? data.correctIndex.value
          : this.correctIndex,
      explanation:
          data.explanation.present ? data.explanation.value : this.explanation,
      ruleSummary:
          data.ruleSummary.present ? data.ruleSummary.value : this.ruleSummary,
      rulePointsJson: data.rulePointsJson.present
          ? data.rulePointsJson.value
          : this.rulePointsJson,
      source: data.source.present ? data.source.value : this.source,
      difficulty:
          data.difficulty.present ? data.difficulty.value : this.difficulty,
      tagsJson: data.tagsJson.present ? data.tagsJson.value : this.tagsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PracticeItemsTableData(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('taskNumber: $taskNumber, ')
          ..write('title: $title, ')
          ..write('topic: $topic, ')
          ..write('question: $question, ')
          ..write('optionsJson: $optionsJson, ')
          ..write('correctIndex: $correctIndex, ')
          ..write('explanation: $explanation, ')
          ..write('ruleSummary: $ruleSummary, ')
          ..write('rulePointsJson: $rulePointsJson, ')
          ..write('source: $source, ')
          ..write('difficulty: $difficulty, ')
          ..write('tagsJson: $tagsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      taskId,
      taskNumber,
      title,
      topic,
      question,
      optionsJson,
      correctIndex,
      explanation,
      ruleSummary,
      rulePointsJson,
      source,
      difficulty,
      tagsJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PracticeItemsTableData &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.taskNumber == this.taskNumber &&
          other.title == this.title &&
          other.topic == this.topic &&
          other.question == this.question &&
          other.optionsJson == this.optionsJson &&
          other.correctIndex == this.correctIndex &&
          other.explanation == this.explanation &&
          other.ruleSummary == this.ruleSummary &&
          other.rulePointsJson == this.rulePointsJson &&
          other.source == this.source &&
          other.difficulty == this.difficulty &&
          other.tagsJson == this.tagsJson);
}

class PracticeItemsTableCompanion
    extends UpdateCompanion<PracticeItemsTableData> {
  final Value<String> id;
  final Value<String> taskId;
  final Value<int> taskNumber;
  final Value<String> title;
  final Value<String> topic;
  final Value<String> question;
  final Value<String> optionsJson;
  final Value<int> correctIndex;
  final Value<String> explanation;
  final Value<String> ruleSummary;
  final Value<String> rulePointsJson;
  final Value<String> source;
  final Value<String> difficulty;
  final Value<String> tagsJson;
  final Value<int> rowid;
  const PracticeItemsTableCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.taskNumber = const Value.absent(),
    this.title = const Value.absent(),
    this.topic = const Value.absent(),
    this.question = const Value.absent(),
    this.optionsJson = const Value.absent(),
    this.correctIndex = const Value.absent(),
    this.explanation = const Value.absent(),
    this.ruleSummary = const Value.absent(),
    this.rulePointsJson = const Value.absent(),
    this.source = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.tagsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PracticeItemsTableCompanion.insert({
    required String id,
    required String taskId,
    required int taskNumber,
    required String title,
    required String topic,
    required String question,
    required String optionsJson,
    required int correctIndex,
    required String explanation,
    required String ruleSummary,
    required String rulePointsJson,
    required String source,
    required String difficulty,
    required String tagsJson,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        taskId = Value(taskId),
        taskNumber = Value(taskNumber),
        title = Value(title),
        topic = Value(topic),
        question = Value(question),
        optionsJson = Value(optionsJson),
        correctIndex = Value(correctIndex),
        explanation = Value(explanation),
        ruleSummary = Value(ruleSummary),
        rulePointsJson = Value(rulePointsJson),
        source = Value(source),
        difficulty = Value(difficulty),
        tagsJson = Value(tagsJson);
  static Insertable<PracticeItemsTableData> custom({
    Expression<String>? id,
    Expression<String>? taskId,
    Expression<int>? taskNumber,
    Expression<String>? title,
    Expression<String>? topic,
    Expression<String>? question,
    Expression<String>? optionsJson,
    Expression<int>? correctIndex,
    Expression<String>? explanation,
    Expression<String>? ruleSummary,
    Expression<String>? rulePointsJson,
    Expression<String>? source,
    Expression<String>? difficulty,
    Expression<String>? tagsJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (taskNumber != null) 'task_number': taskNumber,
      if (title != null) 'title': title,
      if (topic != null) 'topic': topic,
      if (question != null) 'question': question,
      if (optionsJson != null) 'options_json': optionsJson,
      if (correctIndex != null) 'correct_index': correctIndex,
      if (explanation != null) 'explanation': explanation,
      if (ruleSummary != null) 'rule_summary': ruleSummary,
      if (rulePointsJson != null) 'rule_points_json': rulePointsJson,
      if (source != null) 'source': source,
      if (difficulty != null) 'difficulty': difficulty,
      if (tagsJson != null) 'tags_json': tagsJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PracticeItemsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? taskId,
      Value<int>? taskNumber,
      Value<String>? title,
      Value<String>? topic,
      Value<String>? question,
      Value<String>? optionsJson,
      Value<int>? correctIndex,
      Value<String>? explanation,
      Value<String>? ruleSummary,
      Value<String>? rulePointsJson,
      Value<String>? source,
      Value<String>? difficulty,
      Value<String>? tagsJson,
      Value<int>? rowid}) {
    return PracticeItemsTableCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      taskNumber: taskNumber ?? this.taskNumber,
      title: title ?? this.title,
      topic: topic ?? this.topic,
      question: question ?? this.question,
      optionsJson: optionsJson ?? this.optionsJson,
      correctIndex: correctIndex ?? this.correctIndex,
      explanation: explanation ?? this.explanation,
      ruleSummary: ruleSummary ?? this.ruleSummary,
      rulePointsJson: rulePointsJson ?? this.rulePointsJson,
      source: source ?? this.source,
      difficulty: difficulty ?? this.difficulty,
      tagsJson: tagsJson ?? this.tagsJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (taskNumber.present) {
      map['task_number'] = Variable<int>(taskNumber.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (topic.present) {
      map['topic'] = Variable<String>(topic.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (optionsJson.present) {
      map['options_json'] = Variable<String>(optionsJson.value);
    }
    if (correctIndex.present) {
      map['correct_index'] = Variable<int>(correctIndex.value);
    }
    if (explanation.present) {
      map['explanation'] = Variable<String>(explanation.value);
    }
    if (ruleSummary.present) {
      map['rule_summary'] = Variable<String>(ruleSummary.value);
    }
    if (rulePointsJson.present) {
      map['rule_points_json'] = Variable<String>(rulePointsJson.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (tagsJson.present) {
      map['tags_json'] = Variable<String>(tagsJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PracticeItemsTableCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('taskNumber: $taskNumber, ')
          ..write('title: $title, ')
          ..write('topic: $topic, ')
          ..write('question: $question, ')
          ..write('optionsJson: $optionsJson, ')
          ..write('correctIndex: $correctIndex, ')
          ..write('explanation: $explanation, ')
          ..write('ruleSummary: $ruleSummary, ')
          ..write('rulePointsJson: $rulePointsJson, ')
          ..write('source: $source, ')
          ..write('difficulty: $difficulty, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserProfilesTableTable extends UserProfilesTable
    with TableInfo<$UserProfilesTableTable, UserProfilesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passwordHashMeta =
      const VerificationMeta('passwordHash');
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
      'password_hash', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastLoginAtMeta =
      const VerificationMeta('lastLoginAt');
  @override
  late final GeneratedColumn<DateTime> lastLoginAt = GeneratedColumn<DateTime>(
      'last_login_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, email, displayName, passwordHash, createdAt, lastLoginAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<UserProfilesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
          _passwordHashMeta,
          passwordHash.isAcceptableOrUnknown(
              data['password_hash']!, _passwordHashMeta));
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_login_at')) {
      context.handle(
          _lastLoginAtMeta,
          lastLoginAt.isAcceptableOrUnknown(
              data['last_login_at']!, _lastLoginAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfilesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfilesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name'])!,
      passwordHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password_hash'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      lastLoginAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_login_at']),
    );
  }

  @override
  $UserProfilesTableTable createAlias(String alias) {
    return $UserProfilesTableTable(attachedDatabase, alias);
  }
}

class UserProfilesTableData extends DataClass
    implements Insertable<UserProfilesTableData> {
  final String id;
  final String email;
  final String displayName;
  final String passwordHash;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  const UserProfilesTableData(
      {required this.id,
      required this.email,
      required this.displayName,
      required this.passwordHash,
      required this.createdAt,
      this.lastLoginAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['email'] = Variable<String>(email);
    map['display_name'] = Variable<String>(displayName);
    map['password_hash'] = Variable<String>(passwordHash);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastLoginAt != null) {
      map['last_login_at'] = Variable<DateTime>(lastLoginAt);
    }
    return map;
  }

  UserProfilesTableCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesTableCompanion(
      id: Value(id),
      email: Value(email),
      displayName: Value(displayName),
      passwordHash: Value(passwordHash),
      createdAt: Value(createdAt),
      lastLoginAt: lastLoginAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastLoginAt),
    );
  }

  factory UserProfilesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfilesTableData(
      id: serializer.fromJson<String>(json['id']),
      email: serializer.fromJson<String>(json['email']),
      displayName: serializer.fromJson<String>(json['displayName']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastLoginAt: serializer.fromJson<DateTime?>(json['lastLoginAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'email': serializer.toJson<String>(email),
      'displayName': serializer.toJson<String>(displayName),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastLoginAt': serializer.toJson<DateTime?>(lastLoginAt),
    };
  }

  UserProfilesTableData copyWith(
          {String? id,
          String? email,
          String? displayName,
          String? passwordHash,
          DateTime? createdAt,
          Value<DateTime?> lastLoginAt = const Value.absent()}) =>
      UserProfilesTableData(
        id: id ?? this.id,
        email: email ?? this.email,
        displayName: displayName ?? this.displayName,
        passwordHash: passwordHash ?? this.passwordHash,
        createdAt: createdAt ?? this.createdAt,
        lastLoginAt: lastLoginAt.present ? lastLoginAt.value : this.lastLoginAt,
      );
  UserProfilesTableData copyWithCompanion(UserProfilesTableCompanion data) {
    return UserProfilesTableData(
      id: data.id.present ? data.id.value : this.id,
      email: data.email.present ? data.email.value : this.email,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastLoginAt:
          data.lastLoginAt.present ? data.lastLoginAt.value : this.lastLoginAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesTableData(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('displayName: $displayName, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastLoginAt: $lastLoginAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, email, displayName, passwordHash, createdAt, lastLoginAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfilesTableData &&
          other.id == this.id &&
          other.email == this.email &&
          other.displayName == this.displayName &&
          other.passwordHash == this.passwordHash &&
          other.createdAt == this.createdAt &&
          other.lastLoginAt == this.lastLoginAt);
}

class UserProfilesTableCompanion
    extends UpdateCompanion<UserProfilesTableData> {
  final Value<String> id;
  final Value<String> email;
  final Value<String> displayName;
  final Value<String> passwordHash;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastLoginAt;
  final Value<int> rowid;
  const UserProfilesTableCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.displayName = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastLoginAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProfilesTableCompanion.insert({
    required String id,
    required String email,
    required String displayName,
    required String passwordHash,
    required DateTime createdAt,
    this.lastLoginAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        email = Value(email),
        displayName = Value(displayName),
        passwordHash = Value(passwordHash),
        createdAt = Value(createdAt);
  static Insertable<UserProfilesTableData> custom({
    Expression<String>? id,
    Expression<String>? email,
    Expression<String>? displayName,
    Expression<String>? passwordHash,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastLoginAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (displayName != null) 'display_name': displayName,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (createdAt != null) 'created_at': createdAt,
      if (lastLoginAt != null) 'last_login_at': lastLoginAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProfilesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? email,
      Value<String>? displayName,
      Value<String>? passwordHash,
      Value<DateTime>? createdAt,
      Value<DateTime?>? lastLoginAt,
      Value<int>? rowid}) {
    return UserProfilesTableCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      passwordHash: passwordHash ?? this.passwordHash,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastLoginAt.present) {
      map['last_login_at'] = Variable<DateTime>(lastLoginAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesTableCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('displayName: $displayName, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastLoginAt: $lastLoginAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserAttemptsTableTable extends UserAttemptsTable
    with TableInfo<$UserAttemptsTableTable, UserAttemptsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserAttemptsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _remoteAttemptIdMeta =
      const VerificationMeta('remoteAttemptId');
  @override
  late final GeneratedColumn<int> remoteAttemptId = GeneratedColumn<int>(
      'remote_attempt_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false);
  static const VerificationMeta _practiceItemIdMeta =
      const VerificationMeta('practiceItemId');
  @override
  late final GeneratedColumn<String> practiceItemId = GeneratedColumn<String>(
      'practice_item_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES practice_items_table (id)'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES user_profiles_table (id)'));
  static const VerificationMeta _selectedIndexMeta =
      const VerificationMeta('selectedIndex');
  @override
  late final GeneratedColumn<int> selectedIndex = GeneratedColumn<int>(
      'selected_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isCorrectMeta =
      const VerificationMeta('isCorrect');
  @override
  late final GeneratedColumn<bool> isCorrect = GeneratedColumn<bool>(
      'is_correct', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_correct" IN (0, 1))'));
  static const VerificationMeta _answeredAtMeta =
      const VerificationMeta('answeredAt');
  @override
  late final GeneratedColumn<DateTime> answeredAt = GeneratedColumn<DateTime>(
      'answered_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [
        id,
        remoteAttemptId,
        practiceItemId,
        userId,
        selectedIndex,
        isCorrect,
        answeredAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_attempts_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<UserAttemptsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_attempt_id')) {
      context.handle(
          _remoteAttemptIdMeta,
          remoteAttemptId.isAcceptableOrUnknown(
              data['remote_attempt_id']!, _remoteAttemptIdMeta));
    }
    if (data.containsKey('practice_item_id')) {
      context.handle(
          _practiceItemIdMeta,
          practiceItemId.isAcceptableOrUnknown(
              data['practice_item_id']!, _practiceItemIdMeta));
    } else if (isInserting) {
      context.missing(_practiceItemIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('selected_index')) {
      context.handle(
          _selectedIndexMeta,
          selectedIndex.isAcceptableOrUnknown(
              data['selected_index']!, _selectedIndexMeta));
    } else if (isInserting) {
      context.missing(_selectedIndexMeta);
    }
    if (data.containsKey('is_correct')) {
      context.handle(_isCorrectMeta,
          isCorrect.isAcceptableOrUnknown(data['is_correct']!, _isCorrectMeta));
    } else if (isInserting) {
      context.missing(_isCorrectMeta);
    }
    if (data.containsKey('answered_at')) {
      context.handle(
          _answeredAtMeta,
          answeredAt.isAcceptableOrUnknown(
              data['answered_at']!, _answeredAtMeta));
    } else if (isInserting) {
      context.missing(_answeredAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserAttemptsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserAttemptsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      remoteAttemptId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}remote_attempt_id']),
      practiceItemId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}practice_item_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      selectedIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}selected_index'])!,
      isCorrect: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_correct'])!,
      answeredAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}answered_at'])!,
    );
  }

  @override
  $UserAttemptsTableTable createAlias(String alias) {
    return $UserAttemptsTableTable(attachedDatabase, alias);
  }
}

class UserAttemptsTableData extends DataClass
    implements Insertable<UserAttemptsTableData> {
  final int id;
  final int? remoteAttemptId;
  final String practiceItemId;
  final String? userId;
  final int selectedIndex;
  final bool isCorrect;
  final DateTime answeredAt;
  const UserAttemptsTableData(
      {required this.id,
      this.remoteAttemptId,
      required this.practiceItemId,
      this.userId,
      required this.selectedIndex,
      required this.isCorrect,
      required this.answeredAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || remoteAttemptId != null) {
      map['remote_attempt_id'] = Variable<int>(remoteAttemptId);
    }
    map['practice_item_id'] = Variable<String>(practiceItemId);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['selected_index'] = Variable<int>(selectedIndex);
    map['is_correct'] = Variable<bool>(isCorrect);
    map['answered_at'] = Variable<DateTime>(answeredAt);
    return map;
  }

  UserAttemptsTableCompanion toCompanion(bool nullToAbsent) {
    return UserAttemptsTableCompanion(
      id: Value(id),
      remoteAttemptId: remoteAttemptId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteAttemptId),
      practiceItemId: Value(practiceItemId),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      selectedIndex: Value(selectedIndex),
      isCorrect: Value(isCorrect),
      answeredAt: Value(answeredAt),
    );
  }

  factory UserAttemptsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserAttemptsTableData(
      id: serializer.fromJson<int>(json['id']),
      remoteAttemptId: serializer.fromJson<int?>(json['remoteAttemptId']),
      practiceItemId: serializer.fromJson<String>(json['practiceItemId']),
      userId: serializer.fromJson<String?>(json['userId']),
      selectedIndex: serializer.fromJson<int>(json['selectedIndex']),
      isCorrect: serializer.fromJson<bool>(json['isCorrect']),
      answeredAt: serializer.fromJson<DateTime>(json['answeredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteAttemptId': serializer.toJson<int?>(remoteAttemptId),
      'practiceItemId': serializer.toJson<String>(practiceItemId),
      'userId': serializer.toJson<String?>(userId),
      'selectedIndex': serializer.toJson<int>(selectedIndex),
      'isCorrect': serializer.toJson<bool>(isCorrect),
      'answeredAt': serializer.toJson<DateTime>(answeredAt),
    };
  }

  UserAttemptsTableData copyWith(
          {int? id,
          Value<int?> remoteAttemptId = const Value.absent(),
          String? practiceItemId,
          Value<String?> userId = const Value.absent(),
          int? selectedIndex,
          bool? isCorrect,
          DateTime? answeredAt}) =>
      UserAttemptsTableData(
        id: id ?? this.id,
        remoteAttemptId: remoteAttemptId.present
            ? remoteAttemptId.value
            : this.remoteAttemptId,
        practiceItemId: practiceItemId ?? this.practiceItemId,
        userId: userId.present ? userId.value : this.userId,
        selectedIndex: selectedIndex ?? this.selectedIndex,
        isCorrect: isCorrect ?? this.isCorrect,
        answeredAt: answeredAt ?? this.answeredAt,
      );
  UserAttemptsTableData copyWithCompanion(UserAttemptsTableCompanion data) {
    return UserAttemptsTableData(
      id: data.id.present ? data.id.value : this.id,
      remoteAttemptId: data.remoteAttemptId.present
          ? data.remoteAttemptId.value
          : this.remoteAttemptId,
      practiceItemId: data.practiceItemId.present
          ? data.practiceItemId.value
          : this.practiceItemId,
      userId: data.userId.present ? data.userId.value : this.userId,
      selectedIndex: data.selectedIndex.present
          ? data.selectedIndex.value
          : this.selectedIndex,
      isCorrect: data.isCorrect.present ? data.isCorrect.value : this.isCorrect,
      answeredAt:
          data.answeredAt.present ? data.answeredAt.value : this.answeredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserAttemptsTableData(')
          ..write('id: $id, ')
          ..write('remoteAttemptId: $remoteAttemptId, ')
          ..write('practiceItemId: $practiceItemId, ')
          ..write('userId: $userId, ')
          ..write('selectedIndex: $selectedIndex, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('answeredAt: $answeredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, remoteAttemptId, practiceItemId, userId,
      selectedIndex, isCorrect, answeredAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserAttemptsTableData &&
          other.id == this.id &&
          other.remoteAttemptId == this.remoteAttemptId &&
          other.practiceItemId == this.practiceItemId &&
          other.userId == this.userId &&
          other.selectedIndex == this.selectedIndex &&
          other.isCorrect == this.isCorrect &&
          other.answeredAt == this.answeredAt);
}

class UserAttemptsTableCompanion
    extends UpdateCompanion<UserAttemptsTableData> {
  final Value<int> id;
  final Value<int?> remoteAttemptId;
  final Value<String> practiceItemId;
  final Value<String?> userId;
  final Value<int> selectedIndex;
  final Value<bool> isCorrect;
  final Value<DateTime> answeredAt;
  const UserAttemptsTableCompanion({
    this.id = const Value.absent(),
    this.remoteAttemptId = const Value.absent(),
    this.practiceItemId = const Value.absent(),
    this.userId = const Value.absent(),
    this.selectedIndex = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.answeredAt = const Value.absent(),
  });
  UserAttemptsTableCompanion.insert({
    this.id = const Value.absent(),
    this.remoteAttemptId = const Value.absent(),
    required String practiceItemId,
    this.userId = const Value.absent(),
    required int selectedIndex,
    required bool isCorrect,
    required DateTime answeredAt,
  })  : practiceItemId = Value(practiceItemId),
        selectedIndex = Value(selectedIndex),
        isCorrect = Value(isCorrect),
        answeredAt = Value(answeredAt);
  static Insertable<UserAttemptsTableData> custom({
    Expression<int>? id,
    Expression<int>? remoteAttemptId,
    Expression<String>? practiceItemId,
    Expression<String>? userId,
    Expression<int>? selectedIndex,
    Expression<bool>? isCorrect,
    Expression<DateTime>? answeredAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteAttemptId != null) 'remote_attempt_id': remoteAttemptId,
      if (practiceItemId != null) 'practice_item_id': practiceItemId,
      if (userId != null) 'user_id': userId,
      if (selectedIndex != null) 'selected_index': selectedIndex,
      if (isCorrect != null) 'is_correct': isCorrect,
      if (answeredAt != null) 'answered_at': answeredAt,
    });
  }

  UserAttemptsTableCompanion copyWith(
      {Value<int>? id,
      Value<int?>? remoteAttemptId,
      Value<String>? practiceItemId,
      Value<String?>? userId,
      Value<int>? selectedIndex,
      Value<bool>? isCorrect,
      Value<DateTime>? answeredAt}) {
    return UserAttemptsTableCompanion(
      id: id ?? this.id,
      remoteAttemptId: remoteAttemptId ?? this.remoteAttemptId,
      practiceItemId: practiceItemId ?? this.practiceItemId,
      userId: userId ?? this.userId,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isCorrect: isCorrect ?? this.isCorrect,
      answeredAt: answeredAt ?? this.answeredAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteAttemptId.present) {
      map['remote_attempt_id'] = Variable<int>(remoteAttemptId.value);
    }
    if (practiceItemId.present) {
      map['practice_item_id'] = Variable<String>(practiceItemId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (selectedIndex.present) {
      map['selected_index'] = Variable<int>(selectedIndex.value);
    }
    if (isCorrect.present) {
      map['is_correct'] = Variable<bool>(isCorrect.value);
    }
    if (answeredAt.present) {
      map['answered_at'] = Variable<DateTime>(answeredAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserAttemptsTableCompanion(')
          ..write('id: $id, ')
          ..write('remoteAttemptId: $remoteAttemptId, ')
          ..write('practiceItemId: $practiceItemId, ')
          ..write('userId: $userId, ')
          ..write('selectedIndex: $selectedIndex, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('answeredAt: $answeredAt')
          ..write(')'))
        .toString();
  }
}

class $FavoriteItemsTableTable extends FavoriteItemsTable
    with TableInfo<$FavoriteItemsTableTable, FavoriteItemsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteItemsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _practiceItemIdMeta =
      const VerificationMeta('practiceItemId');
  @override
  late final GeneratedColumn<String> practiceItemId = GeneratedColumn<String>(
      'practice_item_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES practice_items_table (id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [practiceItemId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_items_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<FavoriteItemsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('practice_item_id')) {
      context.handle(
          _practiceItemIdMeta,
          practiceItemId.isAcceptableOrUnknown(
              data['practice_item_id']!, _practiceItemIdMeta));
    } else if (isInserting) {
      context.missing(_practiceItemIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {practiceItemId};
  @override
  FavoriteItemsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteItemsTableData(
      practiceItemId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}practice_item_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $FavoriteItemsTableTable createAlias(String alias) {
    return $FavoriteItemsTableTable(attachedDatabase, alias);
  }
}

class FavoriteItemsTableData extends DataClass
    implements Insertable<FavoriteItemsTableData> {
  final String practiceItemId;
  final DateTime createdAt;
  const FavoriteItemsTableData(
      {required this.practiceItemId, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['practice_item_id'] = Variable<String>(practiceItemId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FavoriteItemsTableCompanion toCompanion(bool nullToAbsent) {
    return FavoriteItemsTableCompanion(
      practiceItemId: Value(practiceItemId),
      createdAt: Value(createdAt),
    );
  }

  factory FavoriteItemsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteItemsTableData(
      practiceItemId: serializer.fromJson<String>(json['practiceItemId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'practiceItemId': serializer.toJson<String>(practiceItemId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FavoriteItemsTableData copyWith(
          {String? practiceItemId, DateTime? createdAt}) =>
      FavoriteItemsTableData(
        practiceItemId: practiceItemId ?? this.practiceItemId,
        createdAt: createdAt ?? this.createdAt,
      );
  FavoriteItemsTableData copyWithCompanion(FavoriteItemsTableCompanion data) {
    return FavoriteItemsTableData(
      practiceItemId: data.practiceItemId.present
          ? data.practiceItemId.value
          : this.practiceItemId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteItemsTableData(')
          ..write('practiceItemId: $practiceItemId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(practiceItemId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteItemsTableData &&
          other.practiceItemId == this.practiceItemId &&
          other.createdAt == this.createdAt);
}

class FavoriteItemsTableCompanion
    extends UpdateCompanion<FavoriteItemsTableData> {
  final Value<String> practiceItemId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const FavoriteItemsTableCompanion({
    this.practiceItemId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoriteItemsTableCompanion.insert({
    required String practiceItemId,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : practiceItemId = Value(practiceItemId),
        createdAt = Value(createdAt);
  static Insertable<FavoriteItemsTableData> custom({
    Expression<String>? practiceItemId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (practiceItemId != null) 'practice_item_id': practiceItemId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoriteItemsTableCompanion copyWith(
      {Value<String>? practiceItemId,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return FavoriteItemsTableCompanion(
      practiceItemId: practiceItemId ?? this.practiceItemId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (practiceItemId.present) {
      map['practice_item_id'] = Variable<String>(practiceItemId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteItemsTableCompanion(')
          ..write('practiceItemId: $practiceItemId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MistakeItemsTableTable extends MistakeItemsTable
    with TableInfo<$MistakeItemsTableTable, MistakeItemsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MistakeItemsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _practiceItemIdMeta =
      const VerificationMeta('practiceItemId');
  @override
  late final GeneratedColumn<String> practiceItemId = GeneratedColumn<String>(
      'practice_item_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES practice_items_table (id)'));
  static const VerificationMeta _lastSelectedIndexMeta =
      const VerificationMeta('lastSelectedIndex');
  @override
  late final GeneratedColumn<int> lastSelectedIndex = GeneratedColumn<int>(
      'last_selected_index', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [practiceItemId, lastSelectedIndex, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mistake_items_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<MistakeItemsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('practice_item_id')) {
      context.handle(
          _practiceItemIdMeta,
          practiceItemId.isAcceptableOrUnknown(
              data['practice_item_id']!, _practiceItemIdMeta));
    } else if (isInserting) {
      context.missing(_practiceItemIdMeta);
    }
    if (data.containsKey('last_selected_index')) {
      context.handle(
          _lastSelectedIndexMeta,
          lastSelectedIndex.isAcceptableOrUnknown(
              data['last_selected_index']!, _lastSelectedIndexMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {practiceItemId};
  @override
  MistakeItemsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MistakeItemsTableData(
      practiceItemId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}practice_item_id'])!,
      lastSelectedIndex: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}last_selected_index']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $MistakeItemsTableTable createAlias(String alias) {
    return $MistakeItemsTableTable(attachedDatabase, alias);
  }
}

class MistakeItemsTableData extends DataClass
    implements Insertable<MistakeItemsTableData> {
  final String practiceItemId;
  final int? lastSelectedIndex;
  final DateTime updatedAt;
  const MistakeItemsTableData(
      {required this.practiceItemId,
      this.lastSelectedIndex,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['practice_item_id'] = Variable<String>(practiceItemId);
    if (!nullToAbsent || lastSelectedIndex != null) {
      map['last_selected_index'] = Variable<int>(lastSelectedIndex);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MistakeItemsTableCompanion toCompanion(bool nullToAbsent) {
    return MistakeItemsTableCompanion(
      practiceItemId: Value(practiceItemId),
      lastSelectedIndex: lastSelectedIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSelectedIndex),
      updatedAt: Value(updatedAt),
    );
  }

  factory MistakeItemsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MistakeItemsTableData(
      practiceItemId: serializer.fromJson<String>(json['practiceItemId']),
      lastSelectedIndex: serializer.fromJson<int?>(json['lastSelectedIndex']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'practiceItemId': serializer.toJson<String>(practiceItemId),
      'lastSelectedIndex': serializer.toJson<int?>(lastSelectedIndex),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MistakeItemsTableData copyWith(
          {String? practiceItemId,
          Value<int?> lastSelectedIndex = const Value.absent(),
          DateTime? updatedAt}) =>
      MistakeItemsTableData(
        practiceItemId: practiceItemId ?? this.practiceItemId,
        lastSelectedIndex: lastSelectedIndex.present
            ? lastSelectedIndex.value
            : this.lastSelectedIndex,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  MistakeItemsTableData copyWithCompanion(MistakeItemsTableCompanion data) {
    return MistakeItemsTableData(
      practiceItemId: data.practiceItemId.present
          ? data.practiceItemId.value
          : this.practiceItemId,
      lastSelectedIndex: data.lastSelectedIndex.present
          ? data.lastSelectedIndex.value
          : this.lastSelectedIndex,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MistakeItemsTableData(')
          ..write('practiceItemId: $practiceItemId, ')
          ..write('lastSelectedIndex: $lastSelectedIndex, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(practiceItemId, lastSelectedIndex, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MistakeItemsTableData &&
          other.practiceItemId == this.practiceItemId &&
          other.lastSelectedIndex == this.lastSelectedIndex &&
          other.updatedAt == this.updatedAt);
}

class MistakeItemsTableCompanion
    extends UpdateCompanion<MistakeItemsTableData> {
  final Value<String> practiceItemId;
  final Value<int?> lastSelectedIndex;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MistakeItemsTableCompanion({
    this.practiceItemId = const Value.absent(),
    this.lastSelectedIndex = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MistakeItemsTableCompanion.insert({
    required String practiceItemId,
    this.lastSelectedIndex = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : practiceItemId = Value(practiceItemId),
        updatedAt = Value(updatedAt);
  static Insertable<MistakeItemsTableData> custom({
    Expression<String>? practiceItemId,
    Expression<int>? lastSelectedIndex,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (practiceItemId != null) 'practice_item_id': practiceItemId,
      if (lastSelectedIndex != null) 'last_selected_index': lastSelectedIndex,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MistakeItemsTableCompanion copyWith(
      {Value<String>? practiceItemId,
      Value<int?>? lastSelectedIndex,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return MistakeItemsTableCompanion(
      practiceItemId: practiceItemId ?? this.practiceItemId,
      lastSelectedIndex: lastSelectedIndex ?? this.lastSelectedIndex,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (practiceItemId.present) {
      map['practice_item_id'] = Variable<String>(practiceItemId.value);
    }
    if (lastSelectedIndex.present) {
      map['last_selected_index'] = Variable<int>(lastSelectedIndex.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MistakeItemsTableCompanion(')
          ..write('practiceItemId: $practiceItemId, ')
          ..write('lastSelectedIndex: $lastSelectedIndex, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncStateTableTable extends SyncStateTable
    with TableInfo<$SyncStateTableTable, SyncStateTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncStateTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_state_table';
  @override
  VerificationContext validateIntegrity(Insertable<SyncStateTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SyncStateTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncStateTableData(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $SyncStateTableTable createAlias(String alias) {
    return $SyncStateTableTable(attachedDatabase, alias);
  }
}

class SyncStateTableData extends DataClass
    implements Insertable<SyncStateTableData> {
  final String key;
  final String value;
  const SyncStateTableData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SyncStateTableCompanion toCompanion(bool nullToAbsent) {
    return SyncStateTableCompanion(
      key: Value(key),
      value: Value(value),
    );
  }

  factory SyncStateTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncStateTableData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  SyncStateTableData copyWith({String? key, String? value}) =>
      SyncStateTableData(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  SyncStateTableData copyWithCompanion(SyncStateTableCompanion data) {
    return SyncStateTableData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncStateTableData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncStateTableData &&
          other.key == this.key &&
          other.value == this.value);
}

class SyncStateTableCompanion extends UpdateCompanion<SyncStateTableData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SyncStateTableCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncStateTableCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<SyncStateTableData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncStateTableCompanion copyWith(
      {Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return SyncStateTableCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncStateTableCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ContentPackagesTable contentPackages =
      $ContentPackagesTable(this);
  late final $TaskContentsTableTable taskContentsTable =
      $TaskContentsTableTable(this);
  late final $TaskTheorySectionsTableTable taskTheorySectionsTable =
      $TaskTheorySectionsTableTable(this);
  late final $TaskSourcesTableTable taskSourcesTable =
      $TaskSourcesTableTable(this);
  late final $PracticeItemsTableTable practiceItemsTable =
      $PracticeItemsTableTable(this);
  late final $UserProfilesTableTable userProfilesTable =
      $UserProfilesTableTable(this);
  late final $UserAttemptsTableTable userAttemptsTable =
      $UserAttemptsTableTable(this);
  late final $FavoriteItemsTableTable favoriteItemsTable =
      $FavoriteItemsTableTable(this);
  late final $MistakeItemsTableTable mistakeItemsTable =
      $MistakeItemsTableTable(this);
  late final $SyncStateTableTable syncStateTable = $SyncStateTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        contentPackages,
        taskContentsTable,
        taskTheorySectionsTable,
        taskSourcesTable,
        practiceItemsTable,
        userProfilesTable,
        userAttemptsTable,
        favoriteItemsTable,
        mistakeItemsTable,
        syncStateTable
      ];
}

typedef $$ContentPackagesTableCreateCompanionBuilder = ContentPackagesCompanion
    Function({
  required String id,
  required String version,
  required String generatedAt,
  required DateTime importedAt,
  Value<int> rowid,
});
typedef $$ContentPackagesTableUpdateCompanionBuilder = ContentPackagesCompanion
    Function({
  Value<String> id,
  Value<String> version,
  Value<String> generatedAt,
  Value<DateTime> importedAt,
  Value<int> rowid,
});

class $$ContentPackagesTableFilterComposer
    extends Composer<_$AppDatabase, $ContentPackagesTable> {
  $$ContentPackagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get generatedAt => $composableBuilder(
      column: $table.generatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get importedAt => $composableBuilder(
      column: $table.importedAt, builder: (column) => ColumnFilters(column));
}

class $$ContentPackagesTableOrderingComposer
    extends Composer<_$AppDatabase, $ContentPackagesTable> {
  $$ContentPackagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get generatedAt => $composableBuilder(
      column: $table.generatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get importedAt => $composableBuilder(
      column: $table.importedAt, builder: (column) => ColumnOrderings(column));
}

class $$ContentPackagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContentPackagesTable> {
  $$ContentPackagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get generatedAt => $composableBuilder(
      column: $table.generatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get importedAt => $composableBuilder(
      column: $table.importedAt, builder: (column) => column);
}

class $$ContentPackagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ContentPackagesTable,
    ContentPackage,
    $$ContentPackagesTableFilterComposer,
    $$ContentPackagesTableOrderingComposer,
    $$ContentPackagesTableAnnotationComposer,
    $$ContentPackagesTableCreateCompanionBuilder,
    $$ContentPackagesTableUpdateCompanionBuilder,
    (
      ContentPackage,
      BaseReferences<_$AppDatabase, $ContentPackagesTable, ContentPackage>
    ),
    ContentPackage,
    PrefetchHooks Function()> {
  $$ContentPackagesTableTableManager(
      _$AppDatabase db, $ContentPackagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContentPackagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContentPackagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContentPackagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> version = const Value.absent(),
            Value<String> generatedAt = const Value.absent(),
            Value<DateTime> importedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ContentPackagesCompanion(
            id: id,
            version: version,
            generatedAt: generatedAt,
            importedAt: importedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String version,
            required String generatedAt,
            required DateTime importedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              ContentPackagesCompanion.insert(
            id: id,
            version: version,
            generatedAt: generatedAt,
            importedAt: importedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ContentPackagesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ContentPackagesTable,
    ContentPackage,
    $$ContentPackagesTableFilterComposer,
    $$ContentPackagesTableOrderingComposer,
    $$ContentPackagesTableAnnotationComposer,
    $$ContentPackagesTableCreateCompanionBuilder,
    $$ContentPackagesTableUpdateCompanionBuilder,
    (
      ContentPackage,
      BaseReferences<_$AppDatabase, $ContentPackagesTable, ContentPackage>
    ),
    ContentPackage,
    PrefetchHooks Function()>;
typedef $$TaskContentsTableTableCreateCompanionBuilder
    = TaskContentsTableCompanion Function({
  required String id,
  required int number,
  required String title,
  required String skill,
  required String shortDescription,
  required String officialBasis,
  required bool isEssay,
  required String tagsJson,
  Value<int> rowid,
});
typedef $$TaskContentsTableTableUpdateCompanionBuilder
    = TaskContentsTableCompanion Function({
  Value<String> id,
  Value<int> number,
  Value<String> title,
  Value<String> skill,
  Value<String> shortDescription,
  Value<String> officialBasis,
  Value<bool> isEssay,
  Value<String> tagsJson,
  Value<int> rowid,
});

final class $$TaskContentsTableTableReferences extends BaseReferences<
    _$AppDatabase, $TaskContentsTableTable, TaskContentsTableData> {
  $$TaskContentsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TaskTheorySectionsTableTable,
      List<TaskTheorySectionsTableData>> _taskTheorySectionsTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.taskTheorySectionsTable,
          aliasName: $_aliasNameGenerator(
              db.taskContentsTable.id, db.taskTheorySectionsTable.taskId));

  $$TaskTheorySectionsTableTableProcessedTableManager
      get taskTheorySectionsTableRefs {
    final manager = $$TaskTheorySectionsTableTableTableManager(
            $_db, $_db.taskTheorySectionsTable)
        .filter((f) => f.taskId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_taskTheorySectionsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TaskSourcesTableTable, List<TaskSourcesTableData>>
      _taskSourcesTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.taskSourcesTable,
              aliasName: $_aliasNameGenerator(
                  db.taskContentsTable.id, db.taskSourcesTable.taskId));

  $$TaskSourcesTableTableProcessedTableManager get taskSourcesTableRefs {
    final manager =
        $$TaskSourcesTableTableTableManager($_db, $_db.taskSourcesTable)
            .filter((f) => f.taskId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_taskSourcesTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PracticeItemsTableTable,
      List<PracticeItemsTableData>> _practiceItemsTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.practiceItemsTable,
          aliasName: $_aliasNameGenerator(
              db.taskContentsTable.id, db.practiceItemsTable.taskId));

  $$PracticeItemsTableTableProcessedTableManager get practiceItemsTableRefs {
    final manager =
        $$PracticeItemsTableTableTableManager($_db, $_db.practiceItemsTable)
            .filter((f) => f.taskId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_practiceItemsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TaskContentsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TaskContentsTableTable> {
  $$TaskContentsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get number => $composableBuilder(
      column: $table.number, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get skill => $composableBuilder(
      column: $table.skill, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get shortDescription => $composableBuilder(
      column: $table.shortDescription,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get officialBasis => $composableBuilder(
      column: $table.officialBasis, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isEssay => $composableBuilder(
      column: $table.isEssay, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tagsJson => $composableBuilder(
      column: $table.tagsJson, builder: (column) => ColumnFilters(column));

  Expression<bool> taskTheorySectionsTableRefs(
      Expression<bool> Function($$TaskTheorySectionsTableTableFilterComposer f)
          f) {
    final $$TaskTheorySectionsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.taskTheorySectionsTable,
            getReferencedColumn: (t) => t.taskId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TaskTheorySectionsTableTableFilterComposer(
                  $db: $db,
                  $table: $db.taskTheorySectionsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> taskSourcesTableRefs(
      Expression<bool> Function($$TaskSourcesTableTableFilterComposer f) f) {
    final $$TaskSourcesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.taskSourcesTable,
        getReferencedColumn: (t) => t.taskId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskSourcesTableTableFilterComposer(
              $db: $db,
              $table: $db.taskSourcesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> practiceItemsTableRefs(
      Expression<bool> Function($$PracticeItemsTableTableFilterComposer f) f) {
    final $$PracticeItemsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.practiceItemsTable,
        getReferencedColumn: (t) => t.taskId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PracticeItemsTableTableFilterComposer(
              $db: $db,
              $table: $db.practiceItemsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TaskContentsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TaskContentsTableTable> {
  $$TaskContentsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get number => $composableBuilder(
      column: $table.number, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get skill => $composableBuilder(
      column: $table.skill, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get shortDescription => $composableBuilder(
      column: $table.shortDescription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get officialBasis => $composableBuilder(
      column: $table.officialBasis,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isEssay => $composableBuilder(
      column: $table.isEssay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tagsJson => $composableBuilder(
      column: $table.tagsJson, builder: (column) => ColumnOrderings(column));
}

class $$TaskContentsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TaskContentsTableTable> {
  $$TaskContentsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get skill =>
      $composableBuilder(column: $table.skill, builder: (column) => column);

  GeneratedColumn<String> get shortDescription => $composableBuilder(
      column: $table.shortDescription, builder: (column) => column);

  GeneratedColumn<String> get officialBasis => $composableBuilder(
      column: $table.officialBasis, builder: (column) => column);

  GeneratedColumn<bool> get isEssay =>
      $composableBuilder(column: $table.isEssay, builder: (column) => column);

  GeneratedColumn<String> get tagsJson =>
      $composableBuilder(column: $table.tagsJson, builder: (column) => column);

  Expression<T> taskTheorySectionsTableRefs<T extends Object>(
      Expression<T> Function($$TaskTheorySectionsTableTableAnnotationComposer a)
          f) {
    final $$TaskTheorySectionsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.taskTheorySectionsTable,
            getReferencedColumn: (t) => t.taskId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TaskTheorySectionsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.taskTheorySectionsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> taskSourcesTableRefs<T extends Object>(
      Expression<T> Function($$TaskSourcesTableTableAnnotationComposer a) f) {
    final $$TaskSourcesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.taskSourcesTable,
        getReferencedColumn: (t) => t.taskId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskSourcesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.taskSourcesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> practiceItemsTableRefs<T extends Object>(
      Expression<T> Function($$PracticeItemsTableTableAnnotationComposer a) f) {
    final $$PracticeItemsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.practiceItemsTable,
            getReferencedColumn: (t) => t.taskId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PracticeItemsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.practiceItemsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$TaskContentsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TaskContentsTableTable,
    TaskContentsTableData,
    $$TaskContentsTableTableFilterComposer,
    $$TaskContentsTableTableOrderingComposer,
    $$TaskContentsTableTableAnnotationComposer,
    $$TaskContentsTableTableCreateCompanionBuilder,
    $$TaskContentsTableTableUpdateCompanionBuilder,
    (TaskContentsTableData, $$TaskContentsTableTableReferences),
    TaskContentsTableData,
    PrefetchHooks Function(
        {bool taskTheorySectionsTableRefs,
        bool taskSourcesTableRefs,
        bool practiceItemsTableRefs})> {
  $$TaskContentsTableTableTableManager(
      _$AppDatabase db, $TaskContentsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaskContentsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaskContentsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaskContentsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> number = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> skill = const Value.absent(),
            Value<String> shortDescription = const Value.absent(),
            Value<String> officialBasis = const Value.absent(),
            Value<bool> isEssay = const Value.absent(),
            Value<String> tagsJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TaskContentsTableCompanion(
            id: id,
            number: number,
            title: title,
            skill: skill,
            shortDescription: shortDescription,
            officialBasis: officialBasis,
            isEssay: isEssay,
            tagsJson: tagsJson,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int number,
            required String title,
            required String skill,
            required String shortDescription,
            required String officialBasis,
            required bool isEssay,
            required String tagsJson,
            Value<int> rowid = const Value.absent(),
          }) =>
              TaskContentsTableCompanion.insert(
            id: id,
            number: number,
            title: title,
            skill: skill,
            shortDescription: shortDescription,
            officialBasis: officialBasis,
            isEssay: isEssay,
            tagsJson: tagsJson,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TaskContentsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {taskTheorySectionsTableRefs = false,
              taskSourcesTableRefs = false,
              practiceItemsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (taskTheorySectionsTableRefs) db.taskTheorySectionsTable,
                if (taskSourcesTableRefs) db.taskSourcesTable,
                if (practiceItemsTableRefs) db.practiceItemsTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (taskTheorySectionsTableRefs)
                    await $_getPrefetchedData<
                            TaskContentsTableData,
                            $TaskContentsTableTable,
                            TaskTheorySectionsTableData>(
                        currentTable: table,
                        referencedTable: $$TaskContentsTableTableReferences
                            ._taskTheorySectionsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TaskContentsTableTableReferences(db, table, p0)
                                .taskTheorySectionsTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.taskId == item.id),
                        typedResults: items),
                  if (taskSourcesTableRefs)
                    await $_getPrefetchedData<TaskContentsTableData,
                            $TaskContentsTableTable, TaskSourcesTableData>(
                        currentTable: table,
                        referencedTable: $$TaskContentsTableTableReferences
                            ._taskSourcesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TaskContentsTableTableReferences(db, table, p0)
                                .taskSourcesTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.taskId == item.id),
                        typedResults: items),
                  if (practiceItemsTableRefs)
                    await $_getPrefetchedData<TaskContentsTableData,
                            $TaskContentsTableTable, PracticeItemsTableData>(
                        currentTable: table,
                        referencedTable: $$TaskContentsTableTableReferences
                            ._practiceItemsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TaskContentsTableTableReferences(db, table, p0)
                                .practiceItemsTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.taskId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TaskContentsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TaskContentsTableTable,
    TaskContentsTableData,
    $$TaskContentsTableTableFilterComposer,
    $$TaskContentsTableTableOrderingComposer,
    $$TaskContentsTableTableAnnotationComposer,
    $$TaskContentsTableTableCreateCompanionBuilder,
    $$TaskContentsTableTableUpdateCompanionBuilder,
    (TaskContentsTableData, $$TaskContentsTableTableReferences),
    TaskContentsTableData,
    PrefetchHooks Function(
        {bool taskTheorySectionsTableRefs,
        bool taskSourcesTableRefs,
        bool practiceItemsTableRefs})>;
typedef $$TaskTheorySectionsTableTableCreateCompanionBuilder
    = TaskTheorySectionsTableCompanion Function({
  required String id,
  required String taskId,
  required String sectionType,
  required String title,
  required int orderIndex,
  required String pointsJson,
  Value<int> rowid,
});
typedef $$TaskTheorySectionsTableTableUpdateCompanionBuilder
    = TaskTheorySectionsTableCompanion Function({
  Value<String> id,
  Value<String> taskId,
  Value<String> sectionType,
  Value<String> title,
  Value<int> orderIndex,
  Value<String> pointsJson,
  Value<int> rowid,
});

final class $$TaskTheorySectionsTableTableReferences extends BaseReferences<
    _$AppDatabase, $TaskTheorySectionsTableTable, TaskTheorySectionsTableData> {
  $$TaskTheorySectionsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $TaskContentsTableTable _taskIdTable(_$AppDatabase db) =>
      db.taskContentsTable.createAlias($_aliasNameGenerator(
          db.taskTheorySectionsTable.taskId, db.taskContentsTable.id));

  $$TaskContentsTableTableProcessedTableManager get taskId {
    final $_column = $_itemColumn<String>('task_id')!;

    final manager =
        $$TaskContentsTableTableTableManager($_db, $_db.taskContentsTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TaskTheorySectionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TaskTheorySectionsTableTable> {
  $$TaskTheorySectionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sectionType => $composableBuilder(
      column: $table.sectionType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pointsJson => $composableBuilder(
      column: $table.pointsJson, builder: (column) => ColumnFilters(column));

  $$TaskContentsTableTableFilterComposer get taskId {
    final $$TaskContentsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.taskContentsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskContentsTableTableFilterComposer(
              $db: $db,
              $table: $db.taskContentsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TaskTheorySectionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TaskTheorySectionsTableTable> {
  $$TaskTheorySectionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sectionType => $composableBuilder(
      column: $table.sectionType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pointsJson => $composableBuilder(
      column: $table.pointsJson, builder: (column) => ColumnOrderings(column));

  $$TaskContentsTableTableOrderingComposer get taskId {
    final $$TaskContentsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.taskContentsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskContentsTableTableOrderingComposer(
              $db: $db,
              $table: $db.taskContentsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TaskTheorySectionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TaskTheorySectionsTableTable> {
  $$TaskTheorySectionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sectionType => $composableBuilder(
      column: $table.sectionType, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => column);

  GeneratedColumn<String> get pointsJson => $composableBuilder(
      column: $table.pointsJson, builder: (column) => column);

  $$TaskContentsTableTableAnnotationComposer get taskId {
    final $$TaskContentsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.taskId,
            referencedTable: $db.taskContentsTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TaskContentsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.taskContentsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$TaskTheorySectionsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TaskTheorySectionsTableTable,
    TaskTheorySectionsTableData,
    $$TaskTheorySectionsTableTableFilterComposer,
    $$TaskTheorySectionsTableTableOrderingComposer,
    $$TaskTheorySectionsTableTableAnnotationComposer,
    $$TaskTheorySectionsTableTableCreateCompanionBuilder,
    $$TaskTheorySectionsTableTableUpdateCompanionBuilder,
    (TaskTheorySectionsTableData, $$TaskTheorySectionsTableTableReferences),
    TaskTheorySectionsTableData,
    PrefetchHooks Function({bool taskId})> {
  $$TaskTheorySectionsTableTableTableManager(
      _$AppDatabase db, $TaskTheorySectionsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaskTheorySectionsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$TaskTheorySectionsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaskTheorySectionsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> taskId = const Value.absent(),
            Value<String> sectionType = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<String> pointsJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TaskTheorySectionsTableCompanion(
            id: id,
            taskId: taskId,
            sectionType: sectionType,
            title: title,
            orderIndex: orderIndex,
            pointsJson: pointsJson,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String taskId,
            required String sectionType,
            required String title,
            required int orderIndex,
            required String pointsJson,
            Value<int> rowid = const Value.absent(),
          }) =>
              TaskTheorySectionsTableCompanion.insert(
            id: id,
            taskId: taskId,
            sectionType: sectionType,
            title: title,
            orderIndex: orderIndex,
            pointsJson: pointsJson,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TaskTheorySectionsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({taskId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (taskId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.taskId,
                    referencedTable: $$TaskTheorySectionsTableTableReferences
                        ._taskIdTable(db),
                    referencedColumn: $$TaskTheorySectionsTableTableReferences
                        ._taskIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TaskTheorySectionsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $TaskTheorySectionsTableTable,
        TaskTheorySectionsTableData,
        $$TaskTheorySectionsTableTableFilterComposer,
        $$TaskTheorySectionsTableTableOrderingComposer,
        $$TaskTheorySectionsTableTableAnnotationComposer,
        $$TaskTheorySectionsTableTableCreateCompanionBuilder,
        $$TaskTheorySectionsTableTableUpdateCompanionBuilder,
        (TaskTheorySectionsTableData, $$TaskTheorySectionsTableTableReferences),
        TaskTheorySectionsTableData,
        PrefetchHooks Function({bool taskId})>;
typedef $$TaskSourcesTableTableCreateCompanionBuilder
    = TaskSourcesTableCompanion Function({
  required String id,
  required String taskId,
  required String label,
  required String url,
  required String kind,
  required int orderIndex,
  Value<int> rowid,
});
typedef $$TaskSourcesTableTableUpdateCompanionBuilder
    = TaskSourcesTableCompanion Function({
  Value<String> id,
  Value<String> taskId,
  Value<String> label,
  Value<String> url,
  Value<String> kind,
  Value<int> orderIndex,
  Value<int> rowid,
});

final class $$TaskSourcesTableTableReferences extends BaseReferences<
    _$AppDatabase, $TaskSourcesTableTable, TaskSourcesTableData> {
  $$TaskSourcesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $TaskContentsTableTable _taskIdTable(_$AppDatabase db) =>
      db.taskContentsTable.createAlias($_aliasNameGenerator(
          db.taskSourcesTable.taskId, db.taskContentsTable.id));

  $$TaskContentsTableTableProcessedTableManager get taskId {
    final $_column = $_itemColumn<String>('task_id')!;

    final manager =
        $$TaskContentsTableTableTableManager($_db, $_db.taskContentsTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TaskSourcesTableTableFilterComposer
    extends Composer<_$AppDatabase, $TaskSourcesTableTable> {
  $$TaskSourcesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get kind => $composableBuilder(
      column: $table.kind, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnFilters(column));

  $$TaskContentsTableTableFilterComposer get taskId {
    final $$TaskContentsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.taskContentsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskContentsTableTableFilterComposer(
              $db: $db,
              $table: $db.taskContentsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TaskSourcesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TaskSourcesTableTable> {
  $$TaskSourcesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get kind => $composableBuilder(
      column: $table.kind, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnOrderings(column));

  $$TaskContentsTableTableOrderingComposer get taskId {
    final $$TaskContentsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.taskContentsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskContentsTableTableOrderingComposer(
              $db: $db,
              $table: $db.taskContentsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TaskSourcesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TaskSourcesTableTable> {
  $$TaskSourcesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => column);

  $$TaskContentsTableTableAnnotationComposer get taskId {
    final $$TaskContentsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.taskId,
            referencedTable: $db.taskContentsTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TaskContentsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.taskContentsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$TaskSourcesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TaskSourcesTableTable,
    TaskSourcesTableData,
    $$TaskSourcesTableTableFilterComposer,
    $$TaskSourcesTableTableOrderingComposer,
    $$TaskSourcesTableTableAnnotationComposer,
    $$TaskSourcesTableTableCreateCompanionBuilder,
    $$TaskSourcesTableTableUpdateCompanionBuilder,
    (TaskSourcesTableData, $$TaskSourcesTableTableReferences),
    TaskSourcesTableData,
    PrefetchHooks Function({bool taskId})> {
  $$TaskSourcesTableTableTableManager(
      _$AppDatabase db, $TaskSourcesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaskSourcesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaskSourcesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaskSourcesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> taskId = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<String> url = const Value.absent(),
            Value<String> kind = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TaskSourcesTableCompanion(
            id: id,
            taskId: taskId,
            label: label,
            url: url,
            kind: kind,
            orderIndex: orderIndex,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String taskId,
            required String label,
            required String url,
            required String kind,
            required int orderIndex,
            Value<int> rowid = const Value.absent(),
          }) =>
              TaskSourcesTableCompanion.insert(
            id: id,
            taskId: taskId,
            label: label,
            url: url,
            kind: kind,
            orderIndex: orderIndex,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TaskSourcesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({taskId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (taskId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.taskId,
                    referencedTable:
                        $$TaskSourcesTableTableReferences._taskIdTable(db),
                    referencedColumn:
                        $$TaskSourcesTableTableReferences._taskIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TaskSourcesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TaskSourcesTableTable,
    TaskSourcesTableData,
    $$TaskSourcesTableTableFilterComposer,
    $$TaskSourcesTableTableOrderingComposer,
    $$TaskSourcesTableTableAnnotationComposer,
    $$TaskSourcesTableTableCreateCompanionBuilder,
    $$TaskSourcesTableTableUpdateCompanionBuilder,
    (TaskSourcesTableData, $$TaskSourcesTableTableReferences),
    TaskSourcesTableData,
    PrefetchHooks Function({bool taskId})>;
typedef $$PracticeItemsTableTableCreateCompanionBuilder
    = PracticeItemsTableCompanion Function({
  required String id,
  required String taskId,
  required int taskNumber,
  required String title,
  required String topic,
  required String question,
  required String optionsJson,
  required int correctIndex,
  required String explanation,
  required String ruleSummary,
  required String rulePointsJson,
  required String source,
  required String difficulty,
  required String tagsJson,
  Value<int> rowid,
});
typedef $$PracticeItemsTableTableUpdateCompanionBuilder
    = PracticeItemsTableCompanion Function({
  Value<String> id,
  Value<String> taskId,
  Value<int> taskNumber,
  Value<String> title,
  Value<String> topic,
  Value<String> question,
  Value<String> optionsJson,
  Value<int> correctIndex,
  Value<String> explanation,
  Value<String> ruleSummary,
  Value<String> rulePointsJson,
  Value<String> source,
  Value<String> difficulty,
  Value<String> tagsJson,
  Value<int> rowid,
});

final class $$PracticeItemsTableTableReferences extends BaseReferences<
    _$AppDatabase, $PracticeItemsTableTable, PracticeItemsTableData> {
  $$PracticeItemsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $TaskContentsTableTable _taskIdTable(_$AppDatabase db) =>
      db.taskContentsTable.createAlias($_aliasNameGenerator(
          db.practiceItemsTable.taskId, db.taskContentsTable.id));

  $$TaskContentsTableTableProcessedTableManager get taskId {
    final $_column = $_itemColumn<String>('task_id')!;

    final manager =
        $$TaskContentsTableTableTableManager($_db, $_db.taskContentsTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$UserAttemptsTableTable,
      List<UserAttemptsTableData>> _userAttemptsTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.userAttemptsTable,
          aliasName: $_aliasNameGenerator(
              db.practiceItemsTable.id, db.userAttemptsTable.practiceItemId));

  $$UserAttemptsTableTableProcessedTableManager get userAttemptsTableRefs {
    final manager = $$UserAttemptsTableTableTableManager(
            $_db, $_db.userAttemptsTable)
        .filter(
            (f) => f.practiceItemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_userAttemptsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$FavoriteItemsTableTable,
      List<FavoriteItemsTableData>> _favoriteItemsTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.favoriteItemsTable,
          aliasName: $_aliasNameGenerator(
              db.practiceItemsTable.id, db.favoriteItemsTable.practiceItemId));

  $$FavoriteItemsTableTableProcessedTableManager get favoriteItemsTableRefs {
    final manager = $$FavoriteItemsTableTableTableManager(
            $_db, $_db.favoriteItemsTable)
        .filter(
            (f) => f.practiceItemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_favoriteItemsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MistakeItemsTableTable,
      List<MistakeItemsTableData>> _mistakeItemsTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.mistakeItemsTable,
          aliasName: $_aliasNameGenerator(
              db.practiceItemsTable.id, db.mistakeItemsTable.practiceItemId));

  $$MistakeItemsTableTableProcessedTableManager get mistakeItemsTableRefs {
    final manager = $$MistakeItemsTableTableTableManager(
            $_db, $_db.mistakeItemsTable)
        .filter(
            (f) => f.practiceItemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_mistakeItemsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PracticeItemsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PracticeItemsTableTable> {
  $$PracticeItemsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get taskNumber => $composableBuilder(
      column: $table.taskNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get topic => $composableBuilder(
      column: $table.topic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get question => $composableBuilder(
      column: $table.question, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get optionsJson => $composableBuilder(
      column: $table.optionsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get correctIndex => $composableBuilder(
      column: $table.correctIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get explanation => $composableBuilder(
      column: $table.explanation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ruleSummary => $composableBuilder(
      column: $table.ruleSummary, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rulePointsJson => $composableBuilder(
      column: $table.rulePointsJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tagsJson => $composableBuilder(
      column: $table.tagsJson, builder: (column) => ColumnFilters(column));

  $$TaskContentsTableTableFilterComposer get taskId {
    final $$TaskContentsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.taskContentsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskContentsTableTableFilterComposer(
              $db: $db,
              $table: $db.taskContentsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> userAttemptsTableRefs(
      Expression<bool> Function($$UserAttemptsTableTableFilterComposer f) f) {
    final $$UserAttemptsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userAttemptsTable,
        getReferencedColumn: (t) => t.practiceItemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserAttemptsTableTableFilterComposer(
              $db: $db,
              $table: $db.userAttemptsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> favoriteItemsTableRefs(
      Expression<bool> Function($$FavoriteItemsTableTableFilterComposer f) f) {
    final $$FavoriteItemsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.favoriteItemsTable,
        getReferencedColumn: (t) => t.practiceItemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FavoriteItemsTableTableFilterComposer(
              $db: $db,
              $table: $db.favoriteItemsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> mistakeItemsTableRefs(
      Expression<bool> Function($$MistakeItemsTableTableFilterComposer f) f) {
    final $$MistakeItemsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.mistakeItemsTable,
        getReferencedColumn: (t) => t.practiceItemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MistakeItemsTableTableFilterComposer(
              $db: $db,
              $table: $db.mistakeItemsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PracticeItemsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PracticeItemsTableTable> {
  $$PracticeItemsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get taskNumber => $composableBuilder(
      column: $table.taskNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get topic => $composableBuilder(
      column: $table.topic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get question => $composableBuilder(
      column: $table.question, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get optionsJson => $composableBuilder(
      column: $table.optionsJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get correctIndex => $composableBuilder(
      column: $table.correctIndex,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get explanation => $composableBuilder(
      column: $table.explanation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ruleSummary => $composableBuilder(
      column: $table.ruleSummary, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rulePointsJson => $composableBuilder(
      column: $table.rulePointsJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tagsJson => $composableBuilder(
      column: $table.tagsJson, builder: (column) => ColumnOrderings(column));

  $$TaskContentsTableTableOrderingComposer get taskId {
    final $$TaskContentsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.taskContentsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskContentsTableTableOrderingComposer(
              $db: $db,
              $table: $db.taskContentsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PracticeItemsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PracticeItemsTableTable> {
  $$PracticeItemsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get taskNumber => $composableBuilder(
      column: $table.taskNumber, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get topic =>
      $composableBuilder(column: $table.topic, builder: (column) => column);

  GeneratedColumn<String> get question =>
      $composableBuilder(column: $table.question, builder: (column) => column);

  GeneratedColumn<String> get optionsJson => $composableBuilder(
      column: $table.optionsJson, builder: (column) => column);

  GeneratedColumn<int> get correctIndex => $composableBuilder(
      column: $table.correctIndex, builder: (column) => column);

  GeneratedColumn<String> get explanation => $composableBuilder(
      column: $table.explanation, builder: (column) => column);

  GeneratedColumn<String> get ruleSummary => $composableBuilder(
      column: $table.ruleSummary, builder: (column) => column);

  GeneratedColumn<String> get rulePointsJson => $composableBuilder(
      column: $table.rulePointsJson, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => column);

  GeneratedColumn<String> get tagsJson =>
      $composableBuilder(column: $table.tagsJson, builder: (column) => column);

  $$TaskContentsTableTableAnnotationComposer get taskId {
    final $$TaskContentsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.taskId,
            referencedTable: $db.taskContentsTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TaskContentsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.taskContentsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  Expression<T> userAttemptsTableRefs<T extends Object>(
      Expression<T> Function($$UserAttemptsTableTableAnnotationComposer a) f) {
    final $$UserAttemptsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.userAttemptsTable,
            getReferencedColumn: (t) => t.practiceItemId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$UserAttemptsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.userAttemptsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> favoriteItemsTableRefs<T extends Object>(
      Expression<T> Function($$FavoriteItemsTableTableAnnotationComposer a) f) {
    final $$FavoriteItemsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.favoriteItemsTable,
            getReferencedColumn: (t) => t.practiceItemId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$FavoriteItemsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.favoriteItemsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> mistakeItemsTableRefs<T extends Object>(
      Expression<T> Function($$MistakeItemsTableTableAnnotationComposer a) f) {
    final $$MistakeItemsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.mistakeItemsTable,
            getReferencedColumn: (t) => t.practiceItemId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$MistakeItemsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.mistakeItemsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$PracticeItemsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PracticeItemsTableTable,
    PracticeItemsTableData,
    $$PracticeItemsTableTableFilterComposer,
    $$PracticeItemsTableTableOrderingComposer,
    $$PracticeItemsTableTableAnnotationComposer,
    $$PracticeItemsTableTableCreateCompanionBuilder,
    $$PracticeItemsTableTableUpdateCompanionBuilder,
    (PracticeItemsTableData, $$PracticeItemsTableTableReferences),
    PracticeItemsTableData,
    PrefetchHooks Function(
        {bool taskId,
        bool userAttemptsTableRefs,
        bool favoriteItemsTableRefs,
        bool mistakeItemsTableRefs})> {
  $$PracticeItemsTableTableTableManager(
      _$AppDatabase db, $PracticeItemsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PracticeItemsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PracticeItemsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PracticeItemsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> taskId = const Value.absent(),
            Value<int> taskNumber = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> topic = const Value.absent(),
            Value<String> question = const Value.absent(),
            Value<String> optionsJson = const Value.absent(),
            Value<int> correctIndex = const Value.absent(),
            Value<String> explanation = const Value.absent(),
            Value<String> ruleSummary = const Value.absent(),
            Value<String> rulePointsJson = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String> difficulty = const Value.absent(),
            Value<String> tagsJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PracticeItemsTableCompanion(
            id: id,
            taskId: taskId,
            taskNumber: taskNumber,
            title: title,
            topic: topic,
            question: question,
            optionsJson: optionsJson,
            correctIndex: correctIndex,
            explanation: explanation,
            ruleSummary: ruleSummary,
            rulePointsJson: rulePointsJson,
            source: source,
            difficulty: difficulty,
            tagsJson: tagsJson,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String taskId,
            required int taskNumber,
            required String title,
            required String topic,
            required String question,
            required String optionsJson,
            required int correctIndex,
            required String explanation,
            required String ruleSummary,
            required String rulePointsJson,
            required String source,
            required String difficulty,
            required String tagsJson,
            Value<int> rowid = const Value.absent(),
          }) =>
              PracticeItemsTableCompanion.insert(
            id: id,
            taskId: taskId,
            taskNumber: taskNumber,
            title: title,
            topic: topic,
            question: question,
            optionsJson: optionsJson,
            correctIndex: correctIndex,
            explanation: explanation,
            ruleSummary: ruleSummary,
            rulePointsJson: rulePointsJson,
            source: source,
            difficulty: difficulty,
            tagsJson: tagsJson,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PracticeItemsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {taskId = false,
              userAttemptsTableRefs = false,
              favoriteItemsTableRefs = false,
              mistakeItemsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (userAttemptsTableRefs) db.userAttemptsTable,
                if (favoriteItemsTableRefs) db.favoriteItemsTable,
                if (mistakeItemsTableRefs) db.mistakeItemsTable
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (taskId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.taskId,
                    referencedTable:
                        $$PracticeItemsTableTableReferences._taskIdTable(db),
                    referencedColumn:
                        $$PracticeItemsTableTableReferences._taskIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userAttemptsTableRefs)
                    await $_getPrefetchedData<PracticeItemsTableData,
                            $PracticeItemsTableTable, UserAttemptsTableData>(
                        currentTable: table,
                        referencedTable: $$PracticeItemsTableTableReferences
                            ._userAttemptsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PracticeItemsTableTableReferences(db, table, p0)
                                .userAttemptsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.practiceItemId == item.id),
                        typedResults: items),
                  if (favoriteItemsTableRefs)
                    await $_getPrefetchedData<PracticeItemsTableData,
                            $PracticeItemsTableTable, FavoriteItemsTableData>(
                        currentTable: table,
                        referencedTable: $$PracticeItemsTableTableReferences
                            ._favoriteItemsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PracticeItemsTableTableReferences(db, table, p0)
                                .favoriteItemsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.practiceItemId == item.id),
                        typedResults: items),
                  if (mistakeItemsTableRefs)
                    await $_getPrefetchedData<PracticeItemsTableData,
                            $PracticeItemsTableTable, MistakeItemsTableData>(
                        currentTable: table,
                        referencedTable: $$PracticeItemsTableTableReferences
                            ._mistakeItemsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PracticeItemsTableTableReferences(db, table, p0)
                                .mistakeItemsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.practiceItemId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PracticeItemsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PracticeItemsTableTable,
    PracticeItemsTableData,
    $$PracticeItemsTableTableFilterComposer,
    $$PracticeItemsTableTableOrderingComposer,
    $$PracticeItemsTableTableAnnotationComposer,
    $$PracticeItemsTableTableCreateCompanionBuilder,
    $$PracticeItemsTableTableUpdateCompanionBuilder,
    (PracticeItemsTableData, $$PracticeItemsTableTableReferences),
    PracticeItemsTableData,
    PrefetchHooks Function(
        {bool taskId,
        bool userAttemptsTableRefs,
        bool favoriteItemsTableRefs,
        bool mistakeItemsTableRefs})>;
typedef $$UserProfilesTableTableCreateCompanionBuilder
    = UserProfilesTableCompanion Function({
  required String id,
  required String email,
  required String displayName,
  required String passwordHash,
  required DateTime createdAt,
  Value<DateTime?> lastLoginAt,
  Value<int> rowid,
});
typedef $$UserProfilesTableTableUpdateCompanionBuilder
    = UserProfilesTableCompanion Function({
  Value<String> id,
  Value<String> email,
  Value<String> displayName,
  Value<String> passwordHash,
  Value<DateTime> createdAt,
  Value<DateTime?> lastLoginAt,
  Value<int> rowid,
});

final class $$UserProfilesTableTableReferences extends BaseReferences<
    _$AppDatabase, $UserProfilesTableTable, UserProfilesTableData> {
  $$UserProfilesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserAttemptsTableTable,
      List<UserAttemptsTableData>> _userAttemptsTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.userAttemptsTable,
          aliasName: $_aliasNameGenerator(
              db.userProfilesTable.id, db.userAttemptsTable.userId));

  $$UserAttemptsTableTableProcessedTableManager get userAttemptsTableRefs {
    final manager =
        $$UserAttemptsTableTableTableManager($_db, $_db.userAttemptsTable)
            .filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_userAttemptsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UserProfilesTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTableTable> {
  $$UserProfilesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastLoginAt => $composableBuilder(
      column: $table.lastLoginAt, builder: (column) => ColumnFilters(column));

  Expression<bool> userAttemptsTableRefs(
      Expression<bool> Function($$UserAttemptsTableTableFilterComposer f) f) {
    final $$UserAttemptsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userAttemptsTable,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserAttemptsTableTableFilterComposer(
              $db: $db,
              $table: $db.userAttemptsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UserProfilesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTableTable> {
  $$UserProfilesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastLoginAt => $composableBuilder(
      column: $table.lastLoginAt, builder: (column) => ColumnOrderings(column));
}

class $$UserProfilesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTableTable> {
  $$UserProfilesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastLoginAt => $composableBuilder(
      column: $table.lastLoginAt, builder: (column) => column);

  Expression<T> userAttemptsTableRefs<T extends Object>(
      Expression<T> Function($$UserAttemptsTableTableAnnotationComposer a) f) {
    final $$UserAttemptsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.userAttemptsTable,
            getReferencedColumn: (t) => t.userId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$UserAttemptsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.userAttemptsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$UserProfilesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserProfilesTableTable,
    UserProfilesTableData,
    $$UserProfilesTableTableFilterComposer,
    $$UserProfilesTableTableOrderingComposer,
    $$UserProfilesTableTableAnnotationComposer,
    $$UserProfilesTableTableCreateCompanionBuilder,
    $$UserProfilesTableTableUpdateCompanionBuilder,
    (UserProfilesTableData, $$UserProfilesTableTableReferences),
    UserProfilesTableData,
    PrefetchHooks Function({bool userAttemptsTableRefs})> {
  $$UserProfilesTableTableTableManager(
      _$AppDatabase db, $UserProfilesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> displayName = const Value.absent(),
            Value<String> passwordHash = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> lastLoginAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserProfilesTableCompanion(
            id: id,
            email: email,
            displayName: displayName,
            passwordHash: passwordHash,
            createdAt: createdAt,
            lastLoginAt: lastLoginAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String email,
            required String displayName,
            required String passwordHash,
            required DateTime createdAt,
            Value<DateTime?> lastLoginAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserProfilesTableCompanion.insert(
            id: id,
            email: email,
            displayName: displayName,
            passwordHash: passwordHash,
            createdAt: createdAt,
            lastLoginAt: lastLoginAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$UserProfilesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userAttemptsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (userAttemptsTableRefs) db.userAttemptsTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userAttemptsTableRefs)
                    await $_getPrefetchedData<UserProfilesTableData,
                            $UserProfilesTableTable, UserAttemptsTableData>(
                        currentTable: table,
                        referencedTable: $$UserProfilesTableTableReferences
                            ._userAttemptsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UserProfilesTableTableReferences(db, table, p0)
                                .userAttemptsTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UserProfilesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserProfilesTableTable,
    UserProfilesTableData,
    $$UserProfilesTableTableFilterComposer,
    $$UserProfilesTableTableOrderingComposer,
    $$UserProfilesTableTableAnnotationComposer,
    $$UserProfilesTableTableCreateCompanionBuilder,
    $$UserProfilesTableTableUpdateCompanionBuilder,
    (UserProfilesTableData, $$UserProfilesTableTableReferences),
    UserProfilesTableData,
    PrefetchHooks Function({bool userAttemptsTableRefs})>;
typedef $$UserAttemptsTableTableCreateCompanionBuilder
    = UserAttemptsTableCompanion Function({
  Value<int> id,
  Value<int?> remoteAttemptId,
  required String practiceItemId,
  Value<String?> userId,
  required int selectedIndex,
  required bool isCorrect,
  required DateTime answeredAt,
});
typedef $$UserAttemptsTableTableUpdateCompanionBuilder
    = UserAttemptsTableCompanion Function({
  Value<int> id,
  Value<int?> remoteAttemptId,
  Value<String> practiceItemId,
  Value<String?> userId,
  Value<int> selectedIndex,
  Value<bool> isCorrect,
  Value<DateTime> answeredAt,
});

final class $$UserAttemptsTableTableReferences extends BaseReferences<
    _$AppDatabase, $UserAttemptsTableTable, UserAttemptsTableData> {
  $$UserAttemptsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PracticeItemsTableTable _practiceItemIdTable(_$AppDatabase db) =>
      db.practiceItemsTable.createAlias($_aliasNameGenerator(
          db.userAttemptsTable.practiceItemId, db.practiceItemsTable.id));

  $$PracticeItemsTableTableProcessedTableManager get practiceItemId {
    final $_column = $_itemColumn<String>('practice_item_id')!;

    final manager =
        $$PracticeItemsTableTableTableManager($_db, $_db.practiceItemsTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_practiceItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UserProfilesTableTable _userIdTable(_$AppDatabase db) =>
      db.userProfilesTable.createAlias($_aliasNameGenerator(
          db.userAttemptsTable.userId, db.userProfilesTable.id));

  $$UserProfilesTableTableProcessedTableManager? get userId {
    final $_column = $_itemColumn<String>('user_id');
    if ($_column == null) return null;
    final manager =
        $$UserProfilesTableTableTableManager($_db, $_db.userProfilesTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$UserAttemptsTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserAttemptsTableTable> {
  $$UserAttemptsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get remoteAttemptId => $composableBuilder(
      column: $table.remoteAttemptId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get selectedIndex => $composableBuilder(
      column: $table.selectedIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCorrect => $composableBuilder(
      column: $table.isCorrect, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get answeredAt => $composableBuilder(
      column: $table.answeredAt, builder: (column) => ColumnFilters(column));

  $$PracticeItemsTableTableFilterComposer get practiceItemId {
    final $$PracticeItemsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.practiceItemId,
        referencedTable: $db.practiceItemsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PracticeItemsTableTableFilterComposer(
              $db: $db,
              $table: $db.practiceItemsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserProfilesTableTableFilterComposer get userId {
    final $$UserProfilesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.userProfilesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserProfilesTableTableFilterComposer(
              $db: $db,
              $table: $db.userProfilesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserAttemptsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserAttemptsTableTable> {
  $$UserAttemptsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get remoteAttemptId => $composableBuilder(
      column: $table.remoteAttemptId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get selectedIndex => $composableBuilder(
      column: $table.selectedIndex,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCorrect => $composableBuilder(
      column: $table.isCorrect, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get answeredAt => $composableBuilder(
      column: $table.answeredAt, builder: (column) => ColumnOrderings(column));

  $$PracticeItemsTableTableOrderingComposer get practiceItemId {
    final $$PracticeItemsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.practiceItemId,
        referencedTable: $db.practiceItemsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PracticeItemsTableTableOrderingComposer(
              $db: $db,
              $table: $db.practiceItemsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserProfilesTableTableOrderingComposer get userId {
    final $$UserProfilesTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.userProfilesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserProfilesTableTableOrderingComposer(
              $db: $db,
              $table: $db.userProfilesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserAttemptsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserAttemptsTableTable> {
  $$UserAttemptsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get remoteAttemptId => $composableBuilder(
      column: $table.remoteAttemptId, builder: (column) => column);

  GeneratedColumn<int> get selectedIndex => $composableBuilder(
      column: $table.selectedIndex, builder: (column) => column);

  GeneratedColumn<bool> get isCorrect =>
      $composableBuilder(column: $table.isCorrect, builder: (column) => column);

  GeneratedColumn<DateTime> get answeredAt => $composableBuilder(
      column: $table.answeredAt, builder: (column) => column);

  $$PracticeItemsTableTableAnnotationComposer get practiceItemId {
    final $$PracticeItemsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.practiceItemId,
            referencedTable: $db.practiceItemsTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PracticeItemsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.practiceItemsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$UserProfilesTableTableAnnotationComposer get userId {
    final $$UserProfilesTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.userId,
            referencedTable: $db.userProfilesTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$UserProfilesTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.userProfilesTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$UserAttemptsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserAttemptsTableTable,
    UserAttemptsTableData,
    $$UserAttemptsTableTableFilterComposer,
    $$UserAttemptsTableTableOrderingComposer,
    $$UserAttemptsTableTableAnnotationComposer,
    $$UserAttemptsTableTableCreateCompanionBuilder,
    $$UserAttemptsTableTableUpdateCompanionBuilder,
    (UserAttemptsTableData, $$UserAttemptsTableTableReferences),
    UserAttemptsTableData,
    PrefetchHooks Function({bool practiceItemId, bool userId})> {
  $$UserAttemptsTableTableTableManager(
      _$AppDatabase db, $UserAttemptsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserAttemptsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserAttemptsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserAttemptsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> remoteAttemptId = const Value.absent(),
            Value<String> practiceItemId = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<int> selectedIndex = const Value.absent(),
            Value<bool> isCorrect = const Value.absent(),
            Value<DateTime> answeredAt = const Value.absent(),
          }) =>
              UserAttemptsTableCompanion(
            id: id,
            remoteAttemptId: remoteAttemptId,
            practiceItemId: practiceItemId,
            userId: userId,
            selectedIndex: selectedIndex,
            isCorrect: isCorrect,
            answeredAt: answeredAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> remoteAttemptId = const Value.absent(),
            required String practiceItemId,
            Value<String?> userId = const Value.absent(),
            required int selectedIndex,
            required bool isCorrect,
            required DateTime answeredAt,
          }) =>
              UserAttemptsTableCompanion.insert(
            id: id,
            remoteAttemptId: remoteAttemptId,
            practiceItemId: practiceItemId,
            userId: userId,
            selectedIndex: selectedIndex,
            isCorrect: isCorrect,
            answeredAt: answeredAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$UserAttemptsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({practiceItemId = false, userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (practiceItemId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.practiceItemId,
                    referencedTable: $$UserAttemptsTableTableReferences
                        ._practiceItemIdTable(db),
                    referencedColumn: $$UserAttemptsTableTableReferences
                        ._practiceItemIdTable(db)
                        .id,
                  ) as T;
                }
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$UserAttemptsTableTableReferences._userIdTable(db),
                    referencedColumn:
                        $$UserAttemptsTableTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$UserAttemptsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserAttemptsTableTable,
    UserAttemptsTableData,
    $$UserAttemptsTableTableFilterComposer,
    $$UserAttemptsTableTableOrderingComposer,
    $$UserAttemptsTableTableAnnotationComposer,
    $$UserAttemptsTableTableCreateCompanionBuilder,
    $$UserAttemptsTableTableUpdateCompanionBuilder,
    (UserAttemptsTableData, $$UserAttemptsTableTableReferences),
    UserAttemptsTableData,
    PrefetchHooks Function({bool practiceItemId, bool userId})>;
typedef $$FavoriteItemsTableTableCreateCompanionBuilder
    = FavoriteItemsTableCompanion Function({
  required String practiceItemId,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$FavoriteItemsTableTableUpdateCompanionBuilder
    = FavoriteItemsTableCompanion Function({
  Value<String> practiceItemId,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$FavoriteItemsTableTableReferences extends BaseReferences<
    _$AppDatabase, $FavoriteItemsTableTable, FavoriteItemsTableData> {
  $$FavoriteItemsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PracticeItemsTableTable _practiceItemIdTable(_$AppDatabase db) =>
      db.practiceItemsTable.createAlias($_aliasNameGenerator(
          db.favoriteItemsTable.practiceItemId, db.practiceItemsTable.id));

  $$PracticeItemsTableTableProcessedTableManager get practiceItemId {
    final $_column = $_itemColumn<String>('practice_item_id')!;

    final manager =
        $$PracticeItemsTableTableTableManager($_db, $_db.practiceItemsTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_practiceItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$FavoriteItemsTableTableFilterComposer
    extends Composer<_$AppDatabase, $FavoriteItemsTableTable> {
  $$FavoriteItemsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$PracticeItemsTableTableFilterComposer get practiceItemId {
    final $$PracticeItemsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.practiceItemId,
        referencedTable: $db.practiceItemsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PracticeItemsTableTableFilterComposer(
              $db: $db,
              $table: $db.practiceItemsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FavoriteItemsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoriteItemsTableTable> {
  $$FavoriteItemsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$PracticeItemsTableTableOrderingComposer get practiceItemId {
    final $$PracticeItemsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.practiceItemId,
        referencedTable: $db.practiceItemsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PracticeItemsTableTableOrderingComposer(
              $db: $db,
              $table: $db.practiceItemsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FavoriteItemsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoriteItemsTableTable> {
  $$FavoriteItemsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PracticeItemsTableTableAnnotationComposer get practiceItemId {
    final $$PracticeItemsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.practiceItemId,
            referencedTable: $db.practiceItemsTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PracticeItemsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.practiceItemsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$FavoriteItemsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FavoriteItemsTableTable,
    FavoriteItemsTableData,
    $$FavoriteItemsTableTableFilterComposer,
    $$FavoriteItemsTableTableOrderingComposer,
    $$FavoriteItemsTableTableAnnotationComposer,
    $$FavoriteItemsTableTableCreateCompanionBuilder,
    $$FavoriteItemsTableTableUpdateCompanionBuilder,
    (FavoriteItemsTableData, $$FavoriteItemsTableTableReferences),
    FavoriteItemsTableData,
    PrefetchHooks Function({bool practiceItemId})> {
  $$FavoriteItemsTableTableTableManager(
      _$AppDatabase db, $FavoriteItemsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteItemsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteItemsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoriteItemsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> practiceItemId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FavoriteItemsTableCompanion(
            practiceItemId: practiceItemId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String practiceItemId,
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              FavoriteItemsTableCompanion.insert(
            practiceItemId: practiceItemId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FavoriteItemsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({practiceItemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (practiceItemId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.practiceItemId,
                    referencedTable: $$FavoriteItemsTableTableReferences
                        ._practiceItemIdTable(db),
                    referencedColumn: $$FavoriteItemsTableTableReferences
                        ._practiceItemIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$FavoriteItemsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FavoriteItemsTableTable,
    FavoriteItemsTableData,
    $$FavoriteItemsTableTableFilterComposer,
    $$FavoriteItemsTableTableOrderingComposer,
    $$FavoriteItemsTableTableAnnotationComposer,
    $$FavoriteItemsTableTableCreateCompanionBuilder,
    $$FavoriteItemsTableTableUpdateCompanionBuilder,
    (FavoriteItemsTableData, $$FavoriteItemsTableTableReferences),
    FavoriteItemsTableData,
    PrefetchHooks Function({bool practiceItemId})>;
typedef $$MistakeItemsTableTableCreateCompanionBuilder
    = MistakeItemsTableCompanion Function({
  required String practiceItemId,
  Value<int?> lastSelectedIndex,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$MistakeItemsTableTableUpdateCompanionBuilder
    = MistakeItemsTableCompanion Function({
  Value<String> practiceItemId,
  Value<int?> lastSelectedIndex,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$MistakeItemsTableTableReferences extends BaseReferences<
    _$AppDatabase, $MistakeItemsTableTable, MistakeItemsTableData> {
  $$MistakeItemsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PracticeItemsTableTable _practiceItemIdTable(_$AppDatabase db) =>
      db.practiceItemsTable.createAlias($_aliasNameGenerator(
          db.mistakeItemsTable.practiceItemId, db.practiceItemsTable.id));

  $$PracticeItemsTableTableProcessedTableManager get practiceItemId {
    final $_column = $_itemColumn<String>('practice_item_id')!;

    final manager =
        $$PracticeItemsTableTableTableManager($_db, $_db.practiceItemsTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_practiceItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MistakeItemsTableTableFilterComposer
    extends Composer<_$AppDatabase, $MistakeItemsTableTable> {
  $$MistakeItemsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get lastSelectedIndex => $composableBuilder(
      column: $table.lastSelectedIndex,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$PracticeItemsTableTableFilterComposer get practiceItemId {
    final $$PracticeItemsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.practiceItemId,
        referencedTable: $db.practiceItemsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PracticeItemsTableTableFilterComposer(
              $db: $db,
              $table: $db.practiceItemsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MistakeItemsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MistakeItemsTableTable> {
  $$MistakeItemsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get lastSelectedIndex => $composableBuilder(
      column: $table.lastSelectedIndex,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$PracticeItemsTableTableOrderingComposer get practiceItemId {
    final $$PracticeItemsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.practiceItemId,
        referencedTable: $db.practiceItemsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PracticeItemsTableTableOrderingComposer(
              $db: $db,
              $table: $db.practiceItemsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MistakeItemsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MistakeItemsTableTable> {
  $$MistakeItemsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get lastSelectedIndex => $composableBuilder(
      column: $table.lastSelectedIndex, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$PracticeItemsTableTableAnnotationComposer get practiceItemId {
    final $$PracticeItemsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.practiceItemId,
            referencedTable: $db.practiceItemsTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PracticeItemsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.practiceItemsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$MistakeItemsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MistakeItemsTableTable,
    MistakeItemsTableData,
    $$MistakeItemsTableTableFilterComposer,
    $$MistakeItemsTableTableOrderingComposer,
    $$MistakeItemsTableTableAnnotationComposer,
    $$MistakeItemsTableTableCreateCompanionBuilder,
    $$MistakeItemsTableTableUpdateCompanionBuilder,
    (MistakeItemsTableData, $$MistakeItemsTableTableReferences),
    MistakeItemsTableData,
    PrefetchHooks Function({bool practiceItemId})> {
  $$MistakeItemsTableTableTableManager(
      _$AppDatabase db, $MistakeItemsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MistakeItemsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MistakeItemsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MistakeItemsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> practiceItemId = const Value.absent(),
            Value<int?> lastSelectedIndex = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MistakeItemsTableCompanion(
            practiceItemId: practiceItemId,
            lastSelectedIndex: lastSelectedIndex,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String practiceItemId,
            Value<int?> lastSelectedIndex = const Value.absent(),
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              MistakeItemsTableCompanion.insert(
            practiceItemId: practiceItemId,
            lastSelectedIndex: lastSelectedIndex,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MistakeItemsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({practiceItemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (practiceItemId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.practiceItemId,
                    referencedTable: $$MistakeItemsTableTableReferences
                        ._practiceItemIdTable(db),
                    referencedColumn: $$MistakeItemsTableTableReferences
                        ._practiceItemIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MistakeItemsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MistakeItemsTableTable,
    MistakeItemsTableData,
    $$MistakeItemsTableTableFilterComposer,
    $$MistakeItemsTableTableOrderingComposer,
    $$MistakeItemsTableTableAnnotationComposer,
    $$MistakeItemsTableTableCreateCompanionBuilder,
    $$MistakeItemsTableTableUpdateCompanionBuilder,
    (MistakeItemsTableData, $$MistakeItemsTableTableReferences),
    MistakeItemsTableData,
    PrefetchHooks Function({bool practiceItemId})>;
typedef $$SyncStateTableTableCreateCompanionBuilder = SyncStateTableCompanion
    Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$SyncStateTableTableUpdateCompanionBuilder = SyncStateTableCompanion
    Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$SyncStateTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncStateTableTable> {
  $$SyncStateTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));
}

class $$SyncStateTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncStateTableTable> {
  $$SyncStateTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));
}

class $$SyncStateTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncStateTableTable> {
  $$SyncStateTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SyncStateTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncStateTableTable,
    SyncStateTableData,
    $$SyncStateTableTableFilterComposer,
    $$SyncStateTableTableOrderingComposer,
    $$SyncStateTableTableAnnotationComposer,
    $$SyncStateTableTableCreateCompanionBuilder,
    $$SyncStateTableTableUpdateCompanionBuilder,
    (
      SyncStateTableData,
      BaseReferences<_$AppDatabase, $SyncStateTableTable, SyncStateTableData>
    ),
    SyncStateTableData,
    PrefetchHooks Function()> {
  $$SyncStateTableTableTableManager(
      _$AppDatabase db, $SyncStateTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncStateTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncStateTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncStateTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncStateTableCompanion(
            key: key,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncStateTableCompanion.insert(
            key: key,
            value: value,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncStateTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncStateTableTable,
    SyncStateTableData,
    $$SyncStateTableTableFilterComposer,
    $$SyncStateTableTableOrderingComposer,
    $$SyncStateTableTableAnnotationComposer,
    $$SyncStateTableTableCreateCompanionBuilder,
    $$SyncStateTableTableUpdateCompanionBuilder,
    (
      SyncStateTableData,
      BaseReferences<_$AppDatabase, $SyncStateTableTable, SyncStateTableData>
    ),
    SyncStateTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ContentPackagesTableTableManager get contentPackages =>
      $$ContentPackagesTableTableManager(_db, _db.contentPackages);
  $$TaskContentsTableTableTableManager get taskContentsTable =>
      $$TaskContentsTableTableTableManager(_db, _db.taskContentsTable);
  $$TaskTheorySectionsTableTableTableManager get taskTheorySectionsTable =>
      $$TaskTheorySectionsTableTableTableManager(
          _db, _db.taskTheorySectionsTable);
  $$TaskSourcesTableTableTableManager get taskSourcesTable =>
      $$TaskSourcesTableTableTableManager(_db, _db.taskSourcesTable);
  $$PracticeItemsTableTableTableManager get practiceItemsTable =>
      $$PracticeItemsTableTableTableManager(_db, _db.practiceItemsTable);
  $$UserProfilesTableTableTableManager get userProfilesTable =>
      $$UserProfilesTableTableTableManager(_db, _db.userProfilesTable);
  $$UserAttemptsTableTableTableManager get userAttemptsTable =>
      $$UserAttemptsTableTableTableManager(_db, _db.userAttemptsTable);
  $$FavoriteItemsTableTableTableManager get favoriteItemsTable =>
      $$FavoriteItemsTableTableTableManager(_db, _db.favoriteItemsTable);
  $$MistakeItemsTableTableTableManager get mistakeItemsTable =>
      $$MistakeItemsTableTableTableManager(_db, _db.mistakeItemsTable);
  $$SyncStateTableTableTableManager get syncStateTable =>
      $$SyncStateTableTableTableManager(_db, _db.syncStateTable);
}
