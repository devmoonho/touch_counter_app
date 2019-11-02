import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:touch_counter_app/models/admob_model.dart';

import 'app_pages/home.dart';

void main() => runApp(TouchCounterApp());

class TouchCounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance.initialize(appId: AdmobCounter.appId);
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
