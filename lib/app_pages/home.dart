import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_counter_app/app_pages/widgets/button_widget.dart';
import 'package:touch_counter_app/app_pages/widgets/counter_widget.dart';
import 'package:touch_counter_app/app_pages/widgets/list_widget.dart';
import 'package:touch_counter_app/main.dart';
import 'package:touch_counter_app/providers/counter_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
    admobCounter.admobCounterInit();
    admobCounter.admobBannerShow();
  }

  @override
  void dispose() {
    super.dispose();
    admobCounter.admobBannerHide();
  }

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterProvider>(context, listen: true);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 300),
                alignment: Alignment.topCenter,
                height: counter.isCounterFill
                    ? MediaQuery.of(context).size.height +
                        counter.counterFill.diffPos
                    : MediaQuery.of(context).size.height / 2 +
                        counter.counterFill.diffPos,
                child: CounterWidget(),
              ),
              AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 300),
                alignment: Alignment.bottomCenter,
                height: counter.isCounterFill
                    ? 0.0 - counter.counterFill.diffPos
                    : MediaQuery.of(context).size.height / 2 -
                        counter.counterFill.diffPos,
                child: ListWidget(),
              )
            ],
          ),
          Padding(
            padding: counter.counterFill.padding,
            child: AnimatedContainer(
              curve: Curves.fastOutSlowIn,
              duration: Duration(milliseconds: 300),
              alignment: counter.counterFill.alignment,
              child: ButtonWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
