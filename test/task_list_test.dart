import 'package:flutter/material.dart';
import 'package:flutter_tasks/bloc/tasks_bloc.dart';
import 'package:flutter_tasks/database/database.dart';
import 'package:flutter_tasks/provider/theme_provider.dart';
import 'package:flutter_tasks/ui/tasks_list/done_tasks.dart';
import 'package:flutter_tasks/ui/tasks_list/tasks_provider.dart';
import 'package:flutter_tasks/ui/tasks_list/un_done_tasks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

main() {
  group('task list test', () {
    testWidgets('Done taskes test with doneTasksSubject',
        (WidgetTester tester) async {

      var tasks = [
        TaskEntry(
          id: 1,
          name: 'first task',
          day: 'sunday',
          description: 'dec',
          qrCode: '123456',
          done: true,
        )
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(builder: (_) => ThemeProvider()),
              ChangeNotifierProvider(builder: (_) => TasksProvider()),
              Provider<TasksBloc>(
                builder: (_) => TasksBloc()..doneTasksSubject.add(tasks),
                dispose: (BuildContext context, TasksBloc bloc) => bloc.close(),
              ),
            ],
            child: DoneTasksScreen(),
          ),
        ),
      );
      await tester.pump(Duration.zero);

      expectLater(find.text(tasks[0].name), findsOneWidget);
    });

    testWidgets('Done taskes test with unDoneTasksSubject',
        (WidgetTester tester) async {

      var tasks = [
        TaskEntry(
          id: 1,
          name: 'first task',
          day: 'sunday',
          description: 'dec',
          qrCode: '123456',
          done: true,
        )
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(builder: (_) => ThemeProvider()),
              ChangeNotifierProvider(builder: (_) => TasksProvider()),
              Provider<TasksBloc>(
                builder: (_) => TasksBloc()..unDoneTasksSubject.add(tasks),
                dispose: (BuildContext context, TasksBloc bloc) => bloc.close(),
              ),
            ],
            child: DoneTasksScreen(),
          ),
        ),
      );
      await tester.pump(Duration.zero);

      expectLater(find.text(tasks[0].name), findsNothing);
    });

    testWidgets('unDone taskes test with unDoneTasksSubject',
        (WidgetTester tester) async {

      var tasks = [
        TaskEntry(
          id: 1,
          name: 'first task',
          day: 'sunday',
          description: 'dec',
          qrCode: '123456',
          done: true,
        )
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(builder: (_) => ThemeProvider()),
              ChangeNotifierProvider(builder: (_) => TasksProvider()),
              Provider<TasksBloc>(
                builder: (_) => TasksBloc()..unDoneTasksSubject.add(tasks),
                dispose: (BuildContext context, TasksBloc bloc) => bloc.close(),
              ),
            ],
            child: UnDoneTasksScreen(),
          ),
        ),
      );
      await tester.pump(Duration.zero);

      expectLater(find.text(tasks[0].name), findsOneWidget);
    });

    testWidgets('unDone taskes test with DoneTasksSubject',
        (WidgetTester tester) async {

      var tasks = [
        TaskEntry(
          id: 1,
          name: 'first task',
          day: 'sunday',
          description: 'dec',
          qrCode: '123456',
          done: true,
        )
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(builder: (_) => ThemeProvider()),
              ChangeNotifierProvider(builder: (_) => TasksProvider()),
              Provider<TasksBloc>(
                builder: (_) => TasksBloc()..doneTasksSubject.add(tasks),
                dispose: (BuildContext context, TasksBloc bloc) => bloc.close(),
              ),
            ],
            child: UnDoneTasksScreen(),
          ),
        ),
      );
      await tester.pump(Duration.zero);

      expectLater(find.text(tasks[0].name), findsNothing);
    });

  });
}
