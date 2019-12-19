import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_counter_app/models/admob_model.dart';
import 'package:touch_counter_app/providers/counter_provider.dart';

import 'app_pages/home.dart';

void main() => runApp(TouchCounterApp());

AdmobCounter admobCounter = new AdmobCounter();

class TouchCounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance.initialize(appId: admobCounter.appId);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Touch Counter',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFFFFB339),
        accentColor: Color(0xFFFFCC66),
        textTheme: TextTheme(
          body1: TextStyle(
              fontSize: 24.0,
              color: Colors.black54,
              fontWeight: FontWeight.w500),
          body2: TextStyle(
              fontSize: 22.0,
              color: Colors.black54,
              fontWeight: FontWeight.w500),
          display1: TextStyle(
              fontSize: 20.0,
              color: Colors.black45,
              fontWeight: FontWeight.w500),
          display2: TextStyle(
            fontSize: 18,
            color: Colors.black45,
            fontWeight: FontWeight.w500,
          ),
          display3: TextStyle(
            fontSize: 16,
            color: Colors.black45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<CounterProvider>.value(
            value: CounterProvider(),
          ),
        ],
        child: Home(),
      ),
    );
  }
}
