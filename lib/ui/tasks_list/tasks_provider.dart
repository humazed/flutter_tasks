import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksProvider with ChangeNotifier {
  static TasksProvider of(BuildContext context) =>
      Provider.of<TasksProvider>(context);

  bool _isGrid = false;

  bool get isGrid => _isGrid;

  setIsGrid(bool isGrid) {
    _isGrid = isGrid;
    notifyListeners();
  }
}
