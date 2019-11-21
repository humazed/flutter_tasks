// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class   TaskEntry extends DataClass implements Insertable<TaskEntry> {
  final int id;
  final String name;
  final String description;
  final String day;
  final String qrCode;
  final bool done;
  TaskEntry(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.day,
      @required this.qrCode,
      @required this.done});
  factory TaskEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return TaskEntry(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      day: stringType.mapFromDatabaseResponse(data['${effectivePrefix}day']),
      qrCode:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}qr_code']),
      done: boolType.mapFromDatabaseResponse(data['${effectivePrefix}done']),
    );
  }
  factory TaskEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return TaskEntry(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      day: serializer.fromJson<String>(json['day']),
      qrCode: serializer.fromJson<String>(json['qrCode']),
      done: serializer.fromJson<bool>(json['done']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'day': serializer.toJson<String>(day),
      'qrCode': serializer.toJson<String>(qrCode),
      'done': serializer.toJson<bool>(done),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<TaskEntry>>(bool nullToAbsent) {
    return TasksCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      day: day == null && nullToAbsent ? const Value.absent() : Value(day),
      qrCode:
          qrCode == null && nullToAbsent ? const Value.absent() : Value(qrCode),
      done: done == null && nullToAbsent ? const Value.absent() : Value(done),
    ) as T;
  }

  TaskEntry copyWith(
          {int id,
          String name,
          String description,
          String day,
          String qrCode,
          bool done}) =>
      TaskEntry(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        day: day ?? this.day,
        qrCode: qrCode ?? this.qrCode,
        done: done ?? this.done,
      );
  @override
  String toString() {
    return (StringBuffer('TaskEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('day: $day, ')
          ..write('qrCode: $qrCode, ')
          ..write('done: $done')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      $mrjc(
          $mrjc(
              $mrjc($mrjc($mrjc(0, id.hashCode), name.hashCode),
                  description.hashCode),
              day.hashCode),
          qrCode.hashCode),
      done.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is TaskEntry &&
          other.id == id &&
          other.name == name &&
          other.description == description &&
          other.day == day &&
          other.qrCode == qrCode &&
          other.done == done);
}

class TasksCompanion extends UpdateCompanion<TaskEntry> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> day;
  final Value<String> qrCode;
  final Value<bool> done;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.day = const Value.absent(),
    this.qrCode = const Value.absent(),
    this.done = const Value.absent(),
  });
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, TaskEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $TasksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false, hasAutoIncrement: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dayMeta = const VerificationMeta('day');
  GeneratedTextColumn _day;
  @override
  GeneratedTextColumn get day => _day ??= _constructDay();
  GeneratedTextColumn _constructDay() {
    return GeneratedTextColumn(
      'day',
      $tableName,
      false,
    );
  }

  final VerificationMeta _qrCodeMeta = const VerificationMeta('qrCode');
  GeneratedTextColumn _qrCode;
  @override
  GeneratedTextColumn get qrCode => _qrCode ??= _constructQrCode();
  GeneratedTextColumn _constructQrCode() {
    return GeneratedTextColumn(
      'qr_code',
      $tableName,
      false,
    );
  }

  final VerificationMeta _doneMeta = const VerificationMeta('done');
  GeneratedBoolColumn _done;
  @override
  GeneratedBoolColumn get done => _done ??= _constructDone();
  GeneratedBoolColumn _constructDone() {
    return GeneratedBoolColumn('done', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, day, qrCode, done];
  @override
  $TasksTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tasks';
  @override
  final String actualTableName = 'tasks';
  @override
  VerificationContext validateIntegrity(TasksCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.description.present) {
      context.handle(_descriptionMeta,
          description.isAcceptableValue(d.description.value, _descriptionMeta));
    } else if (description.isRequired && isInserting) {
      context.missing(_descriptionMeta);
    }
    if (d.day.present) {
      context.handle(_dayMeta, day.isAcceptableValue(d.day.value, _dayMeta));
    } else if (day.isRequired && isInserting) {
      context.missing(_dayMeta);
    }
    if (d.qrCode.present) {
      context.handle(
          _qrCodeMeta, qrCode.isAcceptableValue(d.qrCode.value, _qrCodeMeta));
    } else if (qrCode.isRequired && isInserting) {
      context.missing(_qrCodeMeta);
    }
    if (d.done.present) {
      context.handle(
          _doneMeta, done.isAcceptableValue(d.done.value, _doneMeta));
    } else if (done.isRequired && isInserting) {
      context.missing(_doneMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TaskEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TasksCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.description.present) {
      map['description'] = Variable<String, StringType>(d.description.value);
    }
    if (d.day.present) {
      map['day'] = Variable<String, StringType>(d.day.value);
    }
    if (d.qrCode.present) {
      map['qr_code'] = Variable<String, StringType>(d.qrCode.value);
    }
    if (d.done.present) {
      map['done'] = Variable<bool, BoolType>(d.done.value);
    }
    return map;
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(const SqlTypeSystem.withDefaults(), e);
  $TasksTable _tasks;
  $TasksTable get tasks => _tasks ??= $TasksTable(this);
  @override
  List<TableInfo> get allTables => [tasks];
}
