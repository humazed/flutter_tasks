import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider with ChangeNotifier {
  static ThemeProvider of(BuildContext context) =>
      Provider.of<ThemeProvider>(context);

  ThemeData _theme = ThemeData(
    primarySwatch: Colors.grey,
    brightness: Brightness.dark,
    fontFamily: 'tomica',
  );

  ThemeData get theme => _theme;

  setTheme(ThemeData theme) {
    _theme = theme;
    notifyListeners();
  }
}
