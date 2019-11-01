import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_counter_app/app_pages/widgets/counter_widget.dart';
import 'package:touch_counter_app/app_pages/widgets/list_widget.dart';
import 'package:touch_counter_app/providers/home_provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/TouchCounter_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 3,
                child: ChangeNotifierProvider(
                  builder: (context) => Counter(),
                  child: CounterWidget(),
                ),
              ),
              Flexible(
                flex: 1,
                child: ListWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
