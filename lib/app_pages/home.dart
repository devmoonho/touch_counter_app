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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    alignment: Alignment.topCenter,
                    height: counter.isCounterFill
                        ? MediaQuery.of(context).size.height + counter.counterFill.diffPos
                        : MediaQuery.of(context).size.height / 2 + counter.counterFill.diffPos,
                    child: CounterWidget(),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    alignment: Alignment.bottomCenter,
                    height: counter.isCounterFill
                        ? 0.0 - counter.counterFill.diffPos
                        : MediaQuery.of(context).size.height / 2 - counter.counterFill.diffPos,
                    child: ListWidget(),
                  )
                ],
              ),
              Padding(
                padding: counter.counterFill.padding,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
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
