import 'package:flutter/material.dart';

import 'app_pages/home.dart';

void main() => runApp(TouchCounterApp());

class TouchCounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Touch Counter App',
      theme: ThemeData(
        primaryColor: Color(0xFFFFB339),
        accentColor: Color(0xFFFFCC66),
      ),
      home: Home(),
    );
  }
}
