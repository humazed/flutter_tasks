import 'package:flutter/foundation.dart';
import 'package:flutter_tasks/database/database.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:rxdart/rxdart.dart';

class TasksBloc {
  final Database db;

  @visibleForTesting
  final BehaviorSubject<List<TaskEntry>> doneTasksSubject =
      BehaviorSubject.seeded([]);

  Stream<List<TaskEntry>> get doneTasks => doneTasksSubject.stream;

  @visibleForTesting
  final BehaviorSubject<List<TaskEntry>> unDoneTasksSubject =
      BehaviorSubject.seeded([]);

  Stream<List<TaskEntry>> get unDoneTasks => unDoneTasksSubject.stream;

  TasksBloc() : db = Database() {
    db.watchDoneTasks().listen(doneTasksSubject.add);
    db.watchUnDoneTasks().listen(unDoneTasksSubject.add);
  }

  Future<void> createEntry(
    String name,
    String description,
    String day,
    String qrCode,
  ) =>
      db.createEntry(TasksCompanion(
        name: Value(name),
        description: Value(description),
        day: Value(day),
        qrCode: Value(qrCode),
      ));

  Future<void> updateEntry(TaskEntry entry) => db.updateEntry(entry);

  Future<void> markDone(TaskEntry entry) =>
      updateEntry(entry.copyWith(done: true));

  Future<void> markUnDone(TaskEntry entry) =>
      updateEntry(entry.copyWith(done: false));

  Future<void> deleteEntry(TaskEntry entry) => db.deleteEntry(entry);

  void close() {
    doneTasksSubject.close();
    unDoneTasksSubject.close();
  }
}
