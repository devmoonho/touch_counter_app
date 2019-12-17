import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:touch_counter_app/models/touch_counter_model.dart';
import 'package:touch_counter_app/providers/counter_provider.dart';

class ListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterProvider>(context, listen: true);
    return Padding(
      padding: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xFFF6F6F6),
        ),
        child: ListView.builder(
          controller: counter.scrollController,
          reverse: true,
          shrinkWrap: true,
          itemCount: counter.touchCounters.length,
          itemBuilder: (BuildContext context, int index) {
            TouchCounter tCounter = counter.touchCounters[index];
            return GestureDetector(
              onTap: () {
                _changeType(counter, index);
              },
              child: Container(
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          formatDate(
                            tCounter.datetime,
                            [HH, ':', nn, ':', ss],
                          ),
                          style: TextStyle(fontSize: 30.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          formatDate(
                            tCounter.datetime,
                            [yyyy, '-', mm, '-', dd],
                          ),
                          style: TextStyle(fontSize: 20.0, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                      width: 10,
                    ),
                    Container(
                      width: 100.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildChild(counter, index),
                          Text(
                            '${counter.touchCounters[index].type}',
                            style: TextStyle(color: Colors.orange),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildChild(CounterProvider counter, int index) {
    final f = new NumberFormat("0.0#");
    switch (counter.touchCounters[index].type) {
      case 'seconds':
        return Text(
          '${f.format(counter.touchCounters[index].diff.inMilliseconds / 1000)}',
          style: TextStyle(fontSize: 26.0),
          overflow: TextOverflow.ellipsis,
        );
      case 'minutes':
        return Text(
          '${f.format(counter.touchCounters[index].diff.inSeconds / 60)}',
          style: TextStyle(fontSize: 26.0),
          overflow: TextOverflow.ellipsis,
        );
      case 'hours':
        return Text(
          '${f.format(counter.touchCounters[index].diff.inMinutes / 60)}',
          style: TextStyle(fontSize: 26.0),
          overflow: TextOverflow.ellipsis,
        );
      default:
        return Text(
          '${f.format(counter.touchCounters[index].diff.inMilliseconds / 1000)}',
          style: TextStyle(fontSize: 26.0),
          overflow: TextOverflow.ellipsis,
        );
    }
  }

  _changeType(CounterProvider counter, int index) {
    switch (counter.touchCounters[index].type) {
      case 'seconds':
        counter.touchCounters[index].type = 'minutes';
        break;
      case 'minutes':
        counter.touchCounters[index].type = 'hours';
        break;
      case 'hours':
        counter.touchCounters[index].type = 'seconds';
        break;
      default:
        counter.touchCounters[index].type = 'minutes';
        break;
    }
    counter.refresh();
  }
}
