import 'package:flutter/material.dart';
import 'package:flutter_tasks/bloc/tasks_bloc.dart';
import 'package:flutter_tasks/database/database.dart';
import 'package:flutter_tasks/provider/theme_provider.dart';
import 'package:flutter_tasks/ui/tasks_list/tasks_screen.dart';
import 'package:flutter_toolbox/flutter_toolbox.dart';
import 'package:provider/provider.dart';

import '../add_edit_task.dart';

class ColorChanger extends StatefulWidget {
  @override
  _ColorChangerState createState() => _ColorChangerState();
}

class _ColorChangerState extends State<ColorChanger> {
  List<ThemeData> themes = [
    ThemeData(primarySwatch: Colors.deepOrange, fontFamily: 'tomica'),
    ThemeData(primarySwatch: Colors.yellow, fontFamily: 'tomica'),
    ThemeData(primarySwatch: Colors.blue, fontFamily: 'tomica'),
    ThemeData(primarySwatch: Colors.indigo, fontFamily: 'tomica'),
    ThemeData(primarySwatch: Colors.green, fontFamily: 'tomica'),
    ThemeData(
      primarySwatch: Colors.grey,
      brightness: Brightness.dark,
      fontFamily: 'tomica',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);
    final tasksBloc = Provider.of<TasksBloc>(context, listen: false);

    return StreamBuilder<List<TaskEntry>>(
        stream: tasksBloc.unDoneTasks,
        builder: (context, AsyncSnapshot<List<TaskEntry>> snapshot) {
          final tasks = snapshot.data ?? [];
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 72,
            color: themeProvider.theme.primaryColorDark,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: themes
                  .map(
                    (theme) => InkWell(
                      onTap: () {
                        if (themeProvider.theme == theme) {
                          if (tasks.isEmpty)
                            push(context, AddTaskScreen.add());
                          else
                            push(context, TasksScreen());
                        } else {
                          themeProvider.setTheme(theme);
                        }
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: 34,
                        height: 34,
                        margin: EdgeInsets.symmetric(vertical: 19),
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(100),
                          border: themeProvider.theme == theme
                              ? Border.all(color: Colors.white)
                              : null,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        });
  }
}
