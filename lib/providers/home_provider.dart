import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int value = 0;

  void increment() {
    value += 1;
    notifyListeners();
  }

  void decrement() {
    value > 0 ? value -= 1 : value = 0;
    notifyListeners();
  }
  void reset() {
    value = 0;
    notifyListeners();
  }
}
