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

    final counterProvider =
        Provider.of<CounterProvider>(context, listen: false);
    counterProvider.initPreference();
  }

  @override
  void dispose() {
    super.dispose();
    admobCounter.admobBannerHide();
  }

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context, listen: true);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                height: counterProvider.isCounterFill
                    ? (MediaQuery.of(context).size.height  - 50)  +
                        counterProvider.counterFill.diffPos
                    : MediaQuery.of(context).size.height / 2 +
                        counterProvider.counterFill.diffPos,
                child: CounterWidget(),
              ),
              AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 300),
                alignment: Alignment.bottomCenter,
                height: counterProvider.isCounterFill
                    ? 0.0 - counterProvider.counterFill.diffPos
                    : (MediaQuery.of(context).size.height  - 100) / 2 -
                        counterProvider.counterFill.diffPos,
                child: ListWidget(),
              )
            ],
          ),
          Padding(
            padding: counterProvider.counterFill.padding,
            child: AnimatedContainer(
              curve: Curves.fastOutSlowIn,
              duration: Duration(milliseconds: 300),
              alignment: counterProvider.counterFill.alignment,
              child: ButtonWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
