import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_counter_app/providers/home_provider.dart';
import 'package:vibration/vibration.dart';

class CounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50.0),
          bottomRight: Radius.circular(50.0)),
      child: Padding(
        padding: EdgeInsets.only(bottom: 5.0),
        child: Container(
          alignment: MediaQuery.of(context).orientation == Orientation.portrait
              ? Alignment.center
              : Alignment.topCenter,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 5.0),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: GestureDetector(
            onHorizontalDragStart: (DragStartDetails details) {
              print(details.globalPosition);
              Provider.of<Counter>(context, listen: false)
                  .setStartYPos(details.globalPosition.dy);
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              Provider.of<Counter>(context, listen: false)
                  .gestureMove(details.globalPosition.dy);
            },
            onHorizontalDragEnd: (DragEndDetails details) {
              if (Provider.of<Counter>(context, listen: false).StartYPos <
                  Provider.of<Counter>(context, listen: false).EndYPos)
                Provider.of<Counter>(context, listen: false).gestureDown();
              else
                Provider.of<Counter>(context, listen: false).gestureUp();
            },
            child: Material(
              color: Theme.of(context).primaryColor,
              child: InkWell(
                onTap: () {
                  Provider.of<Counter>(context, listen: false).increment();
                  if (Vibration.hasVibrator() != null) {
                    Vibration.vibrate();
                  }
                },
                child: Container(
                  alignment:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? Alignment.center
                          : Alignment.topCenter,
                  constraints: BoxConstraints.expand(),
                  child: Consumer<Counter>(
                    builder: (context, counter, child) => Text(
                      '${counter.value}',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Rubik',
                        fontSize: 150,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
