import 'package:flutter/material.dart';
import 'package:flutter_tasks/bloc/tasks_bloc.dart';
import 'package:flutter_tasks/database/database.dart';
import 'package:flutter_tasks/ui/tasks_list/tasks_provider.dart';
import 'package:flutter_tasks/utils/color.dart';
import 'package:provider/provider.dart';

class DoneTasksScreen extends StatefulWidget {
  @override
  DoneTasksScreenState createState() => DoneTasksScreenState();
}

class DoneTasksScreenState extends State<DoneTasksScreen> {
  bool _inSelectionMode = false;
  List<TaskEntry> _selectedTasks = List();

  TasksBloc tasksBloc;

  @override
  void initState() {
    super.initState();
    tasksBloc = Provider.of<TasksBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = TasksProvider.of(context);
    bool isGrid = tasksProvider.isGrid;

    return Scaffold(
      appBar: AppBar(
        title: Text('Done Tasks'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<List<TaskEntry>>(
        stream: tasksBloc.doneTasks,
        builder: (context, AsyncSnapshot<List<TaskEntry>> snapshot) {
          final tasks = snapshot.data ?? [];

          return Column(
            children: <Widget>[
              Flexible(
                child: isGrid
                    ? buildGridView(tasks, context)
                    : buildListView(tasks, context),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: <Widget>[
                    if (!_inSelectionMode)
                      Expanded(
                        child: InkWell(
//                        onTap: () {},
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.expand_more),
                                Text(
                                  'Undone',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  ListView buildListView(List<TaskEntry> tasks, BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 14),
      itemCount: tasks.length,
      itemBuilder: (_, index) {
        return buildTaskTile(tasks[index], context);
      },
    );
  }

  GridView buildGridView(List<TaskEntry> tasks, BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 14),
      itemCount: tasks.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return buildTaskTile(tasks[index], context);
      },
    );
  }

  Widget buildTaskTile(TaskEntry task, BuildContext context) {
    final tasksProvider = TasksProvider.of(context);
    bool isGrid = tasksProvider.isGrid;

    return Dismissible(
      key: Key(task.id.toString()),
      onDismissed: (direction) {
        tasksBloc.markUnDone(task);
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("Moved back to undone")));
      },
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: 9, horizontal: isGrid ? 15 : 21),
        child: InkWell(
          onTap: () {},
          child: Container(
            height: isGrid ? 113 : 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: getFillColor(Theme.of(context)),
            ),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 21),
                      child: Text(
                        task.name,
                        style: TextStyle(
                          fontSize: 20,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  ),
                ),
                if (_inSelectionMode)
                  Align(
                    alignment: isGrid
                        ? AlignmentDirectional.topEnd
                        : AlignmentDirectional.centerEnd,
                    child: Padding(
                      padding: isGrid
                          ? const EdgeInsets.all(21)
                          : const EdgeInsets.symmetric(horizontal: 31),
                      child: Icon(_selectedTasks.contains(task)
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
