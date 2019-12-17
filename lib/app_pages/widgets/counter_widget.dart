import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_counter_app/providers/counter_provider.dart';
import 'package:vibration/vibration.dart';

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final counterProvider =
        Provider.of<CounterProvider>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50.0),
          bottomRight: Radius.circular(50.0)),
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
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onHorizontalDragStart: (DragStartDetails details) {
                counterProvider.setStartYPos(details.globalPosition.dy);
                setState(() => {});
              },
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                counterProvider.gestureMove(details.globalPosition.dy);
                counterProvider.refresh();
                setState(() => {});
              },
              onHorizontalDragEnd: (DragEndDetails details) {
                if (counterProvider.StartYPos < counterProvider.EndYPos)
                  counterProvider.gestureDown();
                else
                  counterProvider.gestureUp();

                counterProvider.refresh();
                setState(() => {});
              },
              child: Material(
                color: Theme.of(context).primaryColor,
                child: InkWell(
                  onTap: () {
                    counterProvider.increment();
                    if (counterProvider.vibration) {
                      Vibration.vibrate();
                    }
                    setState(() {
                      counterProvider.doAnimation();
                    });
                  },
                  child: Container(
                    alignment: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? Alignment.center
                        : Alignment.topCenter,
                    constraints: BoxConstraints.expand(),
                    child: TextAnimation(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          '${counterProvider.value}',
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
          ],
        ),
      ),
    );
  }
}

class TextAnimation extends StatefulWidget {
  final Widget child;

  TextAnimation({this.child});

  @override
  _TextAnimationState createState() => _TextAnimationState();
}

class _TextAnimationState extends State<TextAnimation>
    with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _animationController;
  Timer timer;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    _animation =
        Tween<double>(begin: 1.0, end: 1.2).animate(_animationController);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.stop(canceled: false);
      }
    });
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context, listen: true);
    counterProvider.setController(_animationController);
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (BuildContext context, Widget child) {
        return Transform.scale(
          scale: _animation.value,
          child: child,
        );
      },
    );
  }
}
