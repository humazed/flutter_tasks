import 'dart:async';

import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

@DataClassName('TaskEntry')
class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get description => text()();

  TextColumn get day => text()();

  TextColumn get qrCode => text()();

  BoolColumn get done => boolean().withDefault(Constant(false))();
}

@UseMoor(tables: [Tasks])
class Database extends _$Database {
  Database()
      : super(FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          logStatements: true,
        ));

  @override
  int get schemaVersion => 1;

  Stream<List<TaskEntry>> watchDoneTasks() =>
      (select(tasks)..where((t) => t.done.equals(true))).watch();

  Stream<List<TaskEntry>> watchUnDoneTasks() =>
      (select(tasks)..where((t) => t.done.equals(false))).watch();

  Future createEntry(TasksCompanion entry) => into(tasks).insert(entry);

  Future updateEntry(TaskEntry entry) => update(tasks).replace(entry);

  Future deleteEntry(TaskEntry entry) => delete(tasks).delete(entry);
}
