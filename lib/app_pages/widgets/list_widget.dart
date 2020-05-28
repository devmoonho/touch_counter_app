import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:touch_counter_app/config/theme_config.dart';
import 'package:touch_counter_app/models/touch_counter_model.dart';
import 'package:touch_counter_app/providers/counter_provider.dart';

class ListWidget extends StatefulWidget {
  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    final counterProvider =
        Provider.of<CounterProvider>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      counterProvider.listAnimation();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final counterProvider =
        Provider.of<CounterProvider>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.transparent),
        child: ListView.builder(
          controller: counterProvider.scrollController,
          reverse: true,
          shrinkWrap: true,
          itemCount: counterProvider.touchCounters.length,
          itemBuilder: (BuildContext context, int index) {
            TouchCounterModel tCounter = counterProvider.touchCounters[index];
            return InkWell(
              onTap: () {
                _changeType(counterProvider, index);
                tCounter.animatedValue = 20.0;
                Timer(Duration(milliseconds: 200), () {
                  tCounter.animatedValue = 0.0;
                  setState(() {});
                });
                setState(() {});
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
                      width: 60.0,
                      padding: EdgeInsets.only(left: 10.0),
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        tCounter.counter.toString(),
                        style: TextStyle(
                            fontSize: 26.0,
                            color: Theme.of(context).primaryColorDark),
                        maxLines: 1,
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
                          formatDate(tCounter.datetime, [HH, ':', nn, ':', ss]),
                          style: TextStyle(
                              fontSize: 24.0,
                              color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          formatDate(
                              tCounter.datetime, [yyyy, '-', mm, '-', dd]),
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).indicatorColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                      width: 10,
                    ),
                    AnimatedContainer(
                      padding: EdgeInsets.only(left: tCounter.animatedValue),
                      duration: Duration(milliseconds: 100),
                      curve: Curves.fastOutSlowIn,
                      width: 120.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildChild(counterProvider, index),
                          Text(
                            '${counterProvider.touchCounters[index].type}',
                            style: TextStyle(
                                color: _getTypeColor(
                                    counterProvider.touchCounters[index].type),
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600),
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

  Color _getTypeColor(String type) {
    switch (type) {
      case 'seconds':
        return Theme.of(context).primaryColor;
      case 'minutes':
        return Colors.lightGreen;
      case 'hours':
        return Colors.lightBlue;
      default:
        return Theme.of(context).primaryColor;
    }
  }

  Widget _buildChild(CounterProvider counter, int index) {
    final f = new NumberFormat("0.0#");
    String txt = '';
    switch (counter.touchCounters[index].type) {
      case 'seconds':
        txt =
            '${f.format(counter.touchCounters[index].diff.inMilliseconds / 1000)}';
        break;
      case 'minutes':
        txt = '${f.format(counter.touchCounters[index].diff.inSeconds / 60)}';
        break;
      case 'hours':
        txt = '${f.format(counter.touchCounters[index].diff.inMinutes / 60)}';
        break;
      default:
        txt =
            '${f.format(counter.touchCounters[index].diff.inMilliseconds / 1000)}';
        break;
    }
    return Text(
      '$txt',
      style: TextStyle(fontSize: 26.0, color: Theme.of(context).highlightColor),
      overflow: TextOverflow.ellipsis,
    );
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

class AnimatedListItem extends AnimatedWidget {
  final Tween<double> _opacityTween = Tween(begin: 1, end: 0);

  final GestureTapCallback onTap;
  final bool selected;

  AnimatedListItem(
      {Key key,
      @required Animation<double> animation,
      this.onTap,
      this.selected})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Opacity(
      opacity: selected ? 1.0 : _opacityTween.evaluate(animation),
      child: ListTile(title: Text("Item"), onTap: onTap),
    );
  }
}
