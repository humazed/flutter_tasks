import 'package:flutter/material.dart';
import 'package:flutter_tasks/provider/theme_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

main() {
  group('ThemeProvider test', () {
    final defaultTheme = ThemeData(
      primarySwatch: Colors.grey,
      brightness: Brightness.dark,
      fontFamily: 'tomica',
    );

    testWidgets('make sure the dark theme is the default',
        (WidgetTester tester) async {
      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider(builder: (_) => ThemeProvider()),
        ],
        child: Builder(builder: (context) {
          final themeProvider = ThemeProvider.of(context);
          expect(
            themeProvider.theme,
            ThemeData(
              primarySwatch: Colors.grey,
              brightness: Brightness.dark,
              fontFamily: 'tomica',
            ),
          );
          return Center();
        }),
      ));
    });

    testWidgets('make sure the theme changes correctly',
        (WidgetTester tester) async {
      Key buttonKey = GlobalKey();

      final greenTheme = ThemeData(primarySwatch: Colors.green);

      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(builder: (_) => ThemeProvider()),
            ],
            child: Column(
              children: [
                Builder(builder: (context) {
                  final themeProvider = ThemeProvider.of(context);
                  expect(themeProvider.theme, defaultTheme);
                  return FlatButton(
                      child: Text('change'),
                      key: buttonKey,
                      onPressed: () async {
                        final themeProvider = ThemeProvider.of(context);
                        themeProvider.setTheme(greenTheme);
                        expect(themeProvider.theme, greenTheme);
                      });
                }),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(buttonKey));
    });
  });
}
