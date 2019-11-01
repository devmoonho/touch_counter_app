import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_counter_app/app_pages/widgets/button_widget.dart';
import 'package:touch_counter_app/app_pages/widgets/counter_widget.dart';
import 'package:touch_counter_app/app_pages/widgets/list_widget.dart';
import 'package:touch_counter_app/providers/home_provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => Counter(),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
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
      ),
    );
  }
}
