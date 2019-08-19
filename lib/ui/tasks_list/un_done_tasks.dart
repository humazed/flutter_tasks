import 'package:flutter/material.dart';
import 'package:flutter_tasks/bloc/tasks_bloc.dart';
import 'package:flutter_tasks/database/database.dart';
import 'package:flutter_tasks/ui/tasks_list/tasks_provider.dart';
import 'package:flutter_tasks/utils/color.dart';
import 'package:flutter_toolbox/flutter_toolbox.dart';
import 'package:provider/provider.dart';

import '../add_edit_task.dart';

class UnDoneTasksScreen extends StatefulWidget {
  @override
  UnDoneTasksScreenState createState() => UnDoneTasksScreenState();
}

class UnDoneTasksScreenState extends State<UnDoneTasksScreen>
    with SingleTickerProviderStateMixin {
  bool _inSelectionMode = false;
  List<TaskEntry> _selectedTasks = List();

  TasksBloc tasksBloc;

  AnimationController _iconController;

  @override
  void initState() {
    super.initState();
    tasksBloc = Provider.of<TasksBloc>(context, listen: false);
    _iconController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  void addOrRemoveTask(TaskEntry task) {
    if (_selectedTasks.contains(task))
      _selectedTasks.remove(task);
    else
      _selectedTasks.add(task);
  }

  @override
  Widget build(BuildContext context) {
    final tasksBloc = Provider.of<TasksBloc>(context, listen: false);
    final tasksProvider = TasksProvider.of(context);
    bool isGrid = tasksProvider.isGrid;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Tasks'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          if (!_inSelectionMode) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Row(
                children: <Widget>[
                  Text(
                    'Sunday',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
            IconButton(
              icon: AnimatedIcon(
                  icon: AnimatedIcons.list_view, progress: _iconController),
              onPressed: () {
                isGrid ? _iconController.forward() : _iconController.reverse();
                setState(() => tasksProvider.setIsGrid(!isGrid));
              },
            ),
          ],
          if (_inSelectionMode)
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => setState(() {
                _inSelectionMode = !_inSelectionMode;
                _selectedTasks = List();
              }),
            ),
        ],
      ),
      body: StreamBuilder<List<TaskEntry>>(
        stream: tasksBloc.unDoneTasks,
        builder: (context, AsyncSnapshot<List<TaskEntry>> snapshot) {
          final tasks = snapshot.data ?? [];
          return Column(
            children: <Widget>[
              Flexible(
                child: isGrid
                    ? buildGridView(tasks, context)
                    : buildListView(tasks, context),
              ),
              buildBottomAction(context, tasksBloc),
            ],
          );
        },
      ),
    );
  }

  ListView buildListView(List<TaskEntry> tasks, BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 14),
      itemCount: tasks.length + 1,
      itemBuilder: (_, index) {
        if (index == tasks.length) {
          return buildAddButton(context);
        } else {
          return buildTaskTile(tasks[index], context);
        }
      },
    );
  }

  GridView buildGridView(List<TaskEntry> tasks, BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 14),
      itemCount: tasks.length + 1,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        if (index == tasks.length) {
          return buildAddButton(context);
        } else {
          return buildTaskTile(tasks[index], context);
        }
      },
    );
  }

  Widget buildTaskTile(TaskEntry task, BuildContext context) {
    final tasksProvider = TasksProvider.of(context);
    bool isGrid = tasksProvider.isGrid;

    return Dismissible(
      key: Key(task.id.toString()),
      onDismissed: (direction) {
        tasksBloc.markDone(task);
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Good jop")));
      },
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: 9, horizontal: isGrid ? 15 : 21),
        child: InkWell(
          onTap: () {
            if (_inSelectionMode)
              setState(() {
                addOrRemoveTask(task);
                _inSelectionMode = _selectedTasks.length > 0;
              });
          },
          onLongPress: () {
            setState(() {
              _inSelectionMode = true;
              addOrRemoveTask(task);
            });
          },
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
                        style: TextStyle(fontSize: 20),
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

  Padding buildAddButton(BuildContext context) {
    final tasksProvider = TasksProvider.of(context);
    bool isGrid = tasksProvider.isGrid;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 9, horizontal: isGrid ? 15 : 21),
      child: ButtonTheme(
        height: isGrid ? 113 : 70,
        child: OutlineButton(
          onPressed: () => push(context, AddTaskScreen.add()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Add New',
                style: TextStyle(fontSize: 23),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildBottomAction(BuildContext context, TasksBloc tasksBloc) {
    return SizedBox(
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
                      Icon(Icons.expand_less),
                      Text(
                        'Done',
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
          if (_inSelectionMode) ...[
            if (_selectedTasks.length == 1)
              Expanded(
                child: InkWell(
                  onTap: () {
                    push(context, AddTaskScreen.edit(_selectedTasks[0]));
                  },
                  child: Center(
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ),
            if (_selectedTasks.length >= 1)
              Expanded(
                child: InkWell(
                  onTap: () {
                    _selectedTasks.forEach(tasksBloc.deleteEntry);
                    setState(() {
                      _selectedTasks = List();
                    });
                  },
                  child: Center(
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
