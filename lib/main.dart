import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_counter_app/models/admob_model.dart';
import 'package:touch_counter_app/providers/counter_provider.dart';
import 'package:touch_counter_app/providers/theme_provider.dart';

import 'app_pages/home.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CounterProvider>.value(
          value: CounterProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>.value(
          value: ThemeProvider(),
        ),
      ],
      child: TouchCounterApp(),
    ),
  );
}

AdmobCounter admobCounter = new AdmobCounter();

class TouchCounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance.initialize(appId: admobCounter.appId);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Touch Counter',
      theme: themeProvider.getThemeData(),
      home: Home(),
      builder: (BuildContext context, Widget widget) {
        final mediaQuery = MediaQuery.of(context);
        return Column(
          children: [
            Expanded(
              child: widget,
            ),
            SizedBox(
              height: getSmartBannerHeight(mediaQuery),
              child: Container(color: Colors.white),
            )
          ],
        );
      },
    );
  }

  double getSmartBannerHeight(MediaQueryData mediaQuery) {
    if (Platform.isAndroid) {
      if (mediaQuery.size.height > 400) return 50.0;
      return 35.0;
    }
    if (Platform.isIOS) {
      if (mediaQuery.orientation == Orientation.portrait) return 50.0;
      return 35.0;
    }
    return 50.0;
  }
}
