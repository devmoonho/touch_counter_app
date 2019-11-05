import 'package:flutter/material.dart';
import 'package:touch_counter_app/models/touch_counter_model.dart';

class CounterFill {
  int flex;
  double diffPos;
  EdgeInsetsGeometry padding;
  AlignmentGeometry alignment;

  double startYPos;
  double endYPos;

  CounterFill() {
    this.padding = EdgeInsets.only(top: 10.0);
    this.alignment = Alignment.center;
    this.diffPos = 0.0;
    this.startYPos = 0.0;
    this.endYPos = 0.0;
  }
}

class Counter with ChangeNotifier {
  int value = 0;
  List<TouchCounter> touchCounters = [];
  ScrollController scrollController = new ScrollController();

  CounterFill counterFill = new CounterFill();
  bool isCounterFill = false;

  double get StartYPos {
    return counterFill.startYPos;
  }

  double get EndYPos {
    return counterFill.endYPos;
  }

  void setStartYPos(double startYPos) {
    counterFill.startYPos = startYPos;
  }

  void gestureMove(double end) {
    counterFill.endYPos = end;
    counterFill.diffPos = (counterFill.endYPos - counterFill.startYPos) / 2;
    counterFill.diffPos = (counterFill.endYPos - counterFill.startYPos) / 2;
    print('isCounterFill : $isCounterFill / start : ${counterFill
        .startYPos} / end : $end / upDown : ${counterFill.diffPos}');
    if ((isCounterFill && counterFill.diffPos > 0) || (!isCounterFill && counterFill.diffPos < 0))
      counterFill.diffPos = 0;

   notifyListeners();
  }

  void gestureUp() {
    if (counterFill.diffPos.abs() > 30 && isCounterFill && counterFill.diffPos < 0) {
      isCounterFill = false;
      counterFill.padding = EdgeInsets.only(top: 10.0);
      counterFill.alignment = Alignment.center;
    }
    counterFill.diffPos = 0.0;
    notifyListeners();
  }

  void gestureDown() {
    if (counterFill.diffPos.abs() > 30 && !isCounterFill && counterFill.diffPos > 0) {
      isCounterFill = true;
      counterFill.padding = EdgeInsets.only(bottom: 100.0);
      counterFill.alignment = Alignment.bottomCenter;
    }
    counterFill.diffPos = 0.0;
    notifyListeners();
  }

  void increment() {
    setCounter(value);
    value += 1;
    notifyListeners();
  }

  void decrement() {
    if (value > 0) {
      value -= 1;
      touchCounters.removeAt(value);
    } else {
      value = 0;
    }
    notifyListeners();
  }

  void reset() {
    value = 0;
    touchCounters = [];
    notifyListeners();
  }

  void setCounter(int value) {
    touchCounters.add(TouchCounter(counter: value, datetime: DateTime.now(), diff: getDiff(value)));
    listAnimation();
  }

  Duration getDiff(value) {
    if (touchCounters.length == 0) {
      return Duration(seconds: 0);
    } else {
      return DateTime.now().difference(touchCounters[value - 1].datetime);
    }
  }

  void listAnimation() {
    if (scrollController.position.maxScrollExtent > 0.0) {
      print(scrollController.position.maxScrollExtent);

      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 110,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }
}
