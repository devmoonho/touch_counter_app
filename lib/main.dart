import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_counter_app/ads/admob_service.dart';
import 'package:touch_counter_app/providers/init_provider.dart';
import 'package:touch_counter_app/providers/theme_provider.dart';

import 'app_pages/home.dart';

void main() {
  runApp(
    MultiProvider(
      providers: providers,
      child: TouchCounterApp(),
    ),
  );
  FirebaseAdMob.instance.initialize(appId: AdmobService.instance.appId);
}

class TouchCounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Touch Counter',
      theme: themeProvider.getThemeData(),
      home: Home(),
      builder: (BuildContext context, Widget widget) {
        return Column(
          children: [
            Expanded(
              child: widget,
            ),
          ],
        );
      },
    );
  }
}
