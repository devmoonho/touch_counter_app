import 'package:flutter/material.dart';
import 'package:touch_counter_app/models/touch_counter_model.dart';

class Counter with ChangeNotifier {
  int value = 0;
  List<TouchCounter> touchCounters = [];
  ScrollController scrollController = new ScrollController();

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
    print(scrollController.position.maxScrollExtent);
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 110,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }
}
