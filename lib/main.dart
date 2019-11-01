import 'package:flutter/material.dart';

import 'app_pages/home.dart';

void main() => runApp(TouchCounterApp());

class TouchCounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Touch Counter App',
      home: Home(),
    );
  }
}
