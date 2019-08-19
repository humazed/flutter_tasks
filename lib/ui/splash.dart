import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toolbox/flutter_toolbox.dart';

import 'intro/intro.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  var twenty;
  Timer t2;

  @override
  void initState() {
    super.initState();
    twenty = const Duration(seconds: 0);
    t2 = Timer(twenty, () {
      init();
    });
  }

  void init() async {
    push(context, IntroScreen());
  }

  @override
  void dispose() {
    super.dispose();
    t2?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
//          image: DecorationImage(
//            image: ExactAssetImage(R.icLauncher),
//          ),
            ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black38),
            ),
          ),
        ),
      ),
    );
  }
}
