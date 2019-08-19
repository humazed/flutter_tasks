import 'package:flutter/material.dart';

Color getFillColor(ThemeData themeData) {
  // dark theme: 10% white (enabled), 5% white (disabled)
  // light theme: 4% black (enabled), 2% black (disabled)
  const Color darkEnabled = Color(0x1AFFFFFF);
  const Color lightEnabled = Color(0x0A000000);

  switch (themeData.brightness) {
    case Brightness.dark:
      return darkEnabled;
    case Brightness.light:
      return lightEnabled;
  }
  return lightEnabled;
}
