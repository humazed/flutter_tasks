import 'package:flutter/material.dart';
import 'package:flutter_tasks/provider/theme_provider.dart';
import 'package:flutter_tasks/ui/splash.dart';
import 'package:provider/provider.dart';

import 'bloc/tasks_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => ThemeProvider()),
        Provider<TasksBloc>(
          builder: (_) => TasksBloc(),
          dispose: (BuildContext context, TasksBloc bloc) => bloc.close(),
        )
      ],

      child: Consumer<ThemeProvider>(
        builder: (BuildContext context, ThemeProvider value, Widget child) {
          return MaterialApp(
            title: 'Flutter Task',
            theme: value.theme,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
