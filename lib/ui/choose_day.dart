import 'package:flutter/material.dart';
import 'package:flutter_tasks/utils/color.dart';

class ChooseDayScreen extends StatefulWidget {
  static Future<String> pickDay(BuildContext context) async {
    var results = await Navigator.of(context).push(
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return ChooseDayScreen();
        },
      ),
    );

    if (results != null && results.containsKey('pickedDay')) {
      return results['pickedDay'];
    } else {
      return null;
    }
  }

  @override
  ChooseDayScreenState createState() => ChooseDayScreenState();
}

class ChooseDayScreenState extends State<ChooseDayScreen> {
  final days = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday ',
    'Friday',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Day'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 21),
        children: days
            .map(
              (day) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 9),
                child: InkWell(
                  onTap: () => Navigator.of(context).pop({'pickedDay': day}),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: getFillColor(Theme.of(context)),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 21),
                        child: Text(
                          day,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
