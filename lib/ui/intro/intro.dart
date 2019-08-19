import 'package:flutter/material.dart';

import 'color_changer.dart';

class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 23),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Tasks',
                    style: TextStyle(
                      fontSize: 23,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'My Tasks',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Flutter App',
                    style: TextStyle(
                      fontSize: 23,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  'Choose Your Color',
                  style: TextStyle(
                    fontSize: 23,
                  ),
                ),
                SizedBox(height: 10),
                RotatedBox(
                  quarterTurns: 1,
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
          SizedBox(height: 27),
          ColorChanger(),
        ],
      ),
    );
  }
}
