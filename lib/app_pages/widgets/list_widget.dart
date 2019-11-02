import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_counter_app/models/touch_counter_model.dart';
import 'package:touch_counter_app/providers/home_provider.dart';

class ListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xFFF6F6F6),
        ),
        child: Consumer<Counter>(
          builder: (context, counter, child) => ListView.builder(
            reverse: true,
            itemCount: counter.touchCounters.length,
            itemBuilder: (BuildContext context, int index) {
              TouchCounter tCounter = counter.touchCounters[index];
              return Container(
                margin: EdgeInsets.fromLTRB(2.0, 5.0, 2.0, 5.0),
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(1.0, 1.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        tCounter.counter.toString(),
                        style: TextStyle(fontSize: 30.0),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                      height: 4,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          formatDate(
                            tCounter.datetime,
                            [HH, ':', nn, ':', ss],
                          ),
                          style: TextStyle(fontSize: 30.0),
                        ),
                        SizedBox(height: 5.0,),
                        Text(
                          formatDate(
                            tCounter.datetime,
                            [yyyy, '-', mm, '-', dd],
                          ),
                          style: TextStyle(fontSize: 20.0,color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          tCounter.diff.inSeconds.toString(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          'Seconds',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
