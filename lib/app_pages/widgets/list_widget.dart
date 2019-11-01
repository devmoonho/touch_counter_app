import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:touch_counter_app/models/touch_counter_model.dart';

class ListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
//                    color: Colors.red,
          ),
      child: ListView.builder(
        itemCount: counterTimers.length,
        itemBuilder: (BuildContext context, int index) {
          TouchCounter tCounter = counterTimers[index];
          return Container(
            child: Row(
              children: <Widget>[
                Text(tCounter.counter.toString()),
                SizedBox(
                  width: 10,
                ),
                Text(
                  formatDate(tCounter.datetime, [HH, ':', nn, ':', ss]),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(tCounter.diff.toString()),
              ],
            ),
          );
        },
      ),
    );
  }
}
