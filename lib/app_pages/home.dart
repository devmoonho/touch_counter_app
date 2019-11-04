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
        body: Consumer<Counter>(
          builder: (context, counter, child) => Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Flexible(
                    flex: 100,
                    child: Stack(
                      children: <Widget>[
                        CounterWidget(),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: counter.counterFill.flex,
                    child: Offstage(
                      offstage: counter.counterFill.offStage,
                      child: ListWidget(),
                    ),
                  )
                ],
              ),
              Padding(
                padding: counter.counterFill.padding,
                child: Container(
                  alignment: counter.counterFill.alignment,
                  child: ButtonWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
