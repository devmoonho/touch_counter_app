import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_counter_app/providers/home_provider.dart';

class CounterWidget extends StatelessWidget {
  double startYPos = 0.0;
  double endYPos = 0.0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          BorderRadius.only(bottomLeft: Radius.circular(50.0), bottomRight: Radius.circular(50.0)),
      child: Padding(
        padding: EdgeInsets.only(bottom: 5.0),
        child: Container(
          alignment: Alignment.center,
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
              print('Start ${details.globalPosition}');
              startYPos = details.globalPosition.dy;
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              endYPos = details.globalPosition.dy;
              Provider.of<Counter>(context, listen: false).gestureMove(startYPos, endYPos);
            },
            onHorizontalDragEnd: (DragEndDetails details) {
              print('End ${details.primaryVelocity}');
              if (details.primaryVelocity != 0.0) {
                if (startYPos < endYPos)
                  Provider.of<Counter>(context, listen: false).gestureDown();
                else
                  Provider.of<Counter>(context, listen: false).gestureUp();
              }
            },
            child: Material(
              color: Theme.of(context).primaryColor,
              child: InkWell(
                onTap: () => Provider.of<Counter>(context, listen: false).increment(),
                child: Container(
                  constraints: BoxConstraints.expand(),
                  alignment: Alignment.center,
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
