import 'package:flutter/material.dart';
import 'package:touch_counter_app/models/touch_counter_model.dart';

class CounterFill {
  int flex;
  bool offStage;
  EdgeInsetsGeometry padding;
  AlignmentGeometry alignment;

  CounterFill() {
    this.offStage = false;
    this.padding = EdgeInsets.only(top: 10.0);
    this.alignment = Alignment.center;
  }
}

class Counter with ChangeNotifier {
  int value = 0;
  List<TouchCounter> touchCounters = [];
  ScrollController scrollController = new ScrollController();

  CounterFill counterFill = new CounterFill();
  bool isCounterFill = false;

  void gestureMove(double start, double end) {
    print('start : $start / end : $end / upDown : ${end - start}');
  }

  void gestureUp() {
    if (isCounterFill == false) return;

    isCounterFill = false;
    counterFill.offStage = false;
    counterFill.padding = EdgeInsets.only(top: 10.0);
    counterFill.alignment = Alignment.center;

    print('isCounterFill $isCounterFill');
    notifyListeners();
  }

  void gestureDown() {
    if (isCounterFill == true) return;

    isCounterFill = true;
    counterFill.offStage = true;
    counterFill.padding = EdgeInsets.only(bottom: 100.0);
    counterFill.alignment = Alignment.bottomCenter;

    print('isCounterFill $isCounterFill');
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
