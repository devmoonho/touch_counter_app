import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_counter_app/app_pages/widgets/button_widget.dart';
import 'package:touch_counter_app/app_pages/widgets/counter_widget.dart';
import 'package:touch_counter_app/app_pages/widgets/list_widget.dart';
import 'package:touch_counter_app/models/admob_model.dart';
import 'package:touch_counter_app/providers/home_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AdmobCounter admobCounter = new AdmobCounter();

  @override
  void initState() {
    super.initState();
    admobCounter.admobCounterInit();
    admobCounter.admobBannerShow();
 }

  @override
  void dispose() {
    super.dispose();
    admobCounter.myBanner.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => Counter(),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Stack(
                    children: <Widget>[
                      CounterWidget(),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: ListWidget(),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Container(
                alignment: Alignment.center,
                child: ButtonWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
