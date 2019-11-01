import 'package:flutter/material.dart';
import 'package:touch_counter_app/app_screens/home.dart';

void main() => runApp(new TouchCounterApp());

class TouchCounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Touch Counter App",
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}
