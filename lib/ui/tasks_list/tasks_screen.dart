import 'package:flutter/material.dart';
import 'package:flutter_tasks/ui/tasks_list/done_tasks.dart';
import 'package:flutter_tasks/ui/tasks_list/tasks_provider.dart';
import 'package:flutter_tasks/ui/tasks_list/un_done_tasks.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatefulWidget {
  @override
  TasksScreenState createState() => TasksScreenState();
}

class TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => TasksProvider()),
      ],
      child: Scaffold(
        body: PageView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            UnDoneTasksScreen(),
            DoneTasksScreen(),
          ],
        ),
      ),
    );
  }
}
