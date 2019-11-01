import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:touch_counter_app/models/touch_counter_model.dart';

class ListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(),
        child: ListView.builder(
          itemCount: counterTimers.length,
          itemBuilder: (BuildContext context, int index) {
            TouchCounter tCounter = counterTimers[index];
            return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    tCounter.counter.toString(),
                    style: TextStyle(fontSize: 30.0),
                  ),
                  SizedBox(
                    width: 10,
                    height: 4,
                  ),
                  Text(
                    formatDate(
                      tCounter.datetime,
                      [HH, ':', nn, ':', ss],
                    ),
                    style: TextStyle(fontSize: 30.0),
                  ),
                  SizedBox(
                    height: 4,
                    width: 10,
                  ),
                  Text(
                    tCounter.diff.toString(),
                    style: TextStyle(fontSize: 30.0),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
