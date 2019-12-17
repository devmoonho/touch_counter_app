import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_counter_app/models/admob_model.dart';
import 'package:touch_counter_app/providers/counter_provider.dart';

import 'app_pages/home.dart';

void main() => runApp(TouchCounterApp());

class TouchCounterApp extends StatelessWidget {
  AdmobCounter ac = new AdmobCounter();

  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance.initialize(appId: ac.appId);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Touch Counter',
      theme: ThemeData(
        primaryColor: Color(0xFFFFB339),
        accentColor: Color(0xFFFFCC66),
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
