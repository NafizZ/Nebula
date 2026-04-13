// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PdfFilesTable extends PdfFiles with TableInfo<$PdfFilesTable, PdfFile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PdfFilesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
    'path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastOpenedMeta = const VerificationMeta(
    'lastOpened',
  );
  @override
  late final GeneratedColumn<DateTime> lastOpened = GeneratedColumn<DateTime>(
    'last_opened',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastPageMeta = const VerificationMeta(
    'lastPage',
  );
  @override
  late final GeneratedColumn<int> lastPage = GeneratedColumn<int>(
    'last_page',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, path, lastOpened, lastPage];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pdf_files';
  @override
  VerificationContext validateIntegrity(
    Insertable<PdfFile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
        _pathMeta,
        path.isAcceptableOrUnknown(data['path']!, _pathMeta),
      );
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('last_opened')) {
      context.handle(
        _lastOpenedMeta,
        lastOpened.isAcceptableOrUnknown(data['last_opened']!, _lastOpenedMeta),
      );
    }
    if (data.containsKey('last_page')) {
      context.handle(
        _lastPageMeta,
        lastPage.isAcceptableOrUnknown(data['last_page']!, _lastPageMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PdfFile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PdfFile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      path: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}path'],
      )!,
      lastOpened: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_opened'],
      ),
      lastPage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_page'],
      )!,
    );
  }

  @override
  $PdfFilesTable createAlias(String alias) {
    return $PdfFilesTable(attachedDatabase, alias);
  }
}

class PdfFile extends DataClass implements Insertable<PdfFile> {
  final int id;
  final String name;
  final String path;
  final DateTime? lastOpened;
  final int lastPage;
  const PdfFile({
    required this.id,
    required this.name,
    required this.path,
    this.lastOpened,
    required this.lastPage,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['path'] = Variable<String>(path);
    if (!nullToAbsent || lastOpened != null) {
      map['last_opened'] = Variable<DateTime>(lastOpened);
    }
    map['last_page'] = Variable<int>(lastPage);
    return map;
  }

  PdfFilesCompanion toCompanion(bool nullToAbsent) {
    return PdfFilesCompanion(
      id: Value(id),
      name: Value(name),
      path: Value(path),
      lastOpened: lastOpened == null && nullToAbsent
          ? const Value.absent()
          : Value(lastOpened),
      lastPage: Value(lastPage),
    );
  }

  factory PdfFile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PdfFile(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      path: serializer.fromJson<String>(json['path']),
      lastOpened: serializer.fromJson<DateTime?>(json['lastOpened']),
      lastPage: serializer.fromJson<int>(json['lastPage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'path': serializer.toJson<String>(path),
      'lastOpened': serializer.toJson<DateTime?>(lastOpened),
      'lastPage': serializer.toJson<int>(lastPage),
    };
  }

  PdfFile copyWith({
    int? id,
    String? name,
    String? path,
    Value<DateTime?> lastOpened = const Value.absent(),
    int? lastPage,
  }) => PdfFile(
    id: id ?? this.id,
    name: name ?? this.name,
    path: path ?? this.path,
    lastOpened: lastOpened.present ? lastOpened.value : this.lastOpened,
    lastPage: lastPage ?? this.lastPage,
  );
  PdfFile copyWithCompanion(PdfFilesCompanion data) {
    return PdfFile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      path: data.path.present ? data.path.value : this.path,
      lastOpened: data.lastOpened.present
          ? data.lastOpened.value
          : this.lastOpened,
      lastPage: data.lastPage.present ? data.lastPage.value : this.lastPage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PdfFile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('path: $path, ')
          ..write('lastOpened: $lastOpened, ')
          ..write('lastPage: $lastPage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, path, lastOpened, lastPage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdfFile &&
          other.id == this.id &&
          other.name == this.name &&
          other.path == this.path &&
          other.lastOpened == this.lastOpened &&
          other.lastPage == this.lastPage);
}

class PdfFilesCompanion extends UpdateCompanion<PdfFile> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> path;
  final Value<DateTime?> lastOpened;
  final Value<int> lastPage;
  const PdfFilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.path = const Value.absent(),
    this.lastOpened = const Value.absent(),
    this.lastPage = const Value.absent(),
  });
  PdfFilesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String path,
    this.lastOpened = const Value.absent(),
    this.lastPage = const Value.absent(),
  }) : name = Value(name),
       path = Value(path);
  static Insertable<PdfFile> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? path,
    Expression<DateTime>? lastOpened,
    Expression<int>? lastPage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (path != null) 'path': path,
      if (lastOpened != null) 'last_opened': lastOpened,
      if (lastPage != null) 'last_page': lastPage,
    });
  }

  PdfFilesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? path,
    Value<DateTime?>? lastOpened,
    Value<int>? lastPage,
  }) {
    return PdfFilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      lastOpened: lastOpened ?? this.lastOpened,
      lastPage: lastPage ?? this.lastPage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (lastOpened.present) {
      map['last_opened'] = Variable<DateTime>(lastOpened.value);
    }
    if (lastPage.present) {
      map['last_page'] = Variable<int>(lastPage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdfFilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('path: $path, ')
          ..write('lastOpened: $lastOpened, ')
          ..write('lastPage: $lastPage')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PdfFilesTable pdfFiles = $PdfFilesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [pdfFiles];
}

typedef $$PdfFilesTableCreateCompanionBuilder =
    PdfFilesCompanion Function({
      Value<int> id,
      required String name,
      required String path,
      Value<DateTime?> lastOpened,
      Value<int> lastPage,
    });
typedef $$PdfFilesTableUpdateCompanionBuilder =
    PdfFilesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> path,
      Value<DateTime?> lastOpened,
      Value<int> lastPage,
    });

class $$PdfFilesTableFilterComposer
    extends Composer<_$AppDatabase, $PdfFilesTable> {
  $$PdfFilesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastOpened => $composableBuilder(
    column: $table.lastOpened,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastPage => $composableBuilder(
    column: $table.lastPage,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PdfFilesTableOrderingComposer
    extends Composer<_$AppDatabase, $PdfFilesTable> {
  $$PdfFilesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastOpened => $composableBuilder(
    column: $table.lastOpened,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastPage => $composableBuilder(
    column: $table.lastPage,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PdfFilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PdfFilesTable> {
  $$PdfFilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<DateTime> get lastOpened => $composableBuilder(
    column: $table.lastOpened,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastPage =>
      $composableBuilder(column: $table.lastPage, builder: (column) => column);
}

class $$PdfFilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PdfFilesTable,
          PdfFile,
          $$PdfFilesTableFilterComposer,
          $$PdfFilesTableOrderingComposer,
          $$PdfFilesTableAnnotationComposer,
          $$PdfFilesTableCreateCompanionBuilder,
          $$PdfFilesTableUpdateCompanionBuilder,
          (PdfFile, BaseReferences<_$AppDatabase, $PdfFilesTable, PdfFile>),
          PdfFile,
          PrefetchHooks Function()
        > {
  $$PdfFilesTableTableManager(_$AppDatabase db, $PdfFilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PdfFilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PdfFilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PdfFilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> path = const Value.absent(),
                Value<DateTime?> lastOpened = const Value.absent(),
                Value<int> lastPage = const Value.absent(),
              }) => PdfFilesCompanion(
                id: id,
                name: name,
                path: path,
                lastOpened: lastOpened,
                lastPage: lastPage,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String path,
                Value<DateTime?> lastOpened = const Value.absent(),
                Value<int> lastPage = const Value.absent(),
              }) => PdfFilesCompanion.insert(
                id: id,
                name: name,
                path: path,
                lastOpened: lastOpened,
                lastPage: lastPage,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PdfFilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PdfFilesTable,
      PdfFile,
      $$PdfFilesTableFilterComposer,
      $$PdfFilesTableOrderingComposer,
      $$PdfFilesTableAnnotationComposer,
      $$PdfFilesTableCreateCompanionBuilder,
      $$PdfFilesTableUpdateCompanionBuilder,
      (PdfFile, BaseReferences<_$AppDatabase, $PdfFilesTable, PdfFile>),
      PdfFile,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PdfFilesTableTableManager get pdfFiles =>
      $$PdfFilesTableTableManager(_db, _db.pdfFiles);
}
