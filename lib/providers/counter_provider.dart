import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touch_counter_app/models/touch_counter_model.dart';

const String CURRENT_KEY = 'currentlottokey!@#%^&*()_';
const String DEFAULT_KEY = 'Touch Counter';

class CounterProvider with ChangeNotifier {
  int value = 0;
  List<TouchCounterModel> touchCounters = [];
  ScrollController scrollController = new ScrollController();

  CounterFill counterFill = new CounterFill();
  bool isCounterFill = false;
  bool vibration = false;

  String diffType = 'seconds';
  String currentKey = '';

  AnimationController _animationController;

  void refresh() => notifyListeners();

  Future<List<TouchCounterModel>> initPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    if (prefs.getStringList(await getCurrentKey())?.isEmpty ?? true) {
      setCurrentKey(DEFAULT_KEY);
      return new List<TouchCounterModel>();
    } else {
      List<TouchCounterModel> ret = new List<TouchCounterModel>();
      ret = prefs
          .getStringList(await getCurrentKey())
          .map((x) => TouchCounterModel.fromMap(json.decode(x)))
          .toList();

      value = ret.length;
      touchCounters = ret;
      currentKey = await getCurrentKey();

      initListPosition();
      refresh();
      return ret;
    }
  }

  Future<void> getPreference(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var jsonList = prefs.getStringList(key);
    touchCounters =
        jsonList.map((x) => TouchCounterModel.fromMap(json.decode(x))).toList();

    await setCurrentKey(key);
    value = touchCounters.length;

    initListPosition();
    refresh();
    return touchCounters;
  }

  Future<void> setPreference(String key, List<TouchCounterModel> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonList = list.map((x) => json.encode(x.toMap())).toList();
    await prefs.setStringList(key, jsonList);
    setCurrentKey(key);
  }

  Future<void> setCurrentKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(CURRENT_KEY, key);
    currentKey = key;
  }

  Future<String> getCurrentKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(CURRENT_KEY);
  }

  Future<List<String>> getPreferenceKeys() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getKeys().toList().reversed.toList();
    // without CURRENT_KEY
    list.remove(CURRENT_KEY);
    return list;
  }

  Future<void> removePreference(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  double get StartYPos {
    return counterFill.startYPos;
  }

  double get EndYPos {
    return counterFill.endYPos;
  }

  void setStartYPos(double startYPos) {
    counterFill.startYPos = startYPos;
    refresh();
  }

  void gestureMove(double end) {
    counterFill.endYPos = end;
    counterFill.diffPos = (counterFill.endYPos - counterFill.startYPos) / 2;
    counterFill.diffPos = (counterFill.endYPos - counterFill.startYPos) / 2;
    if ((isCounterFill && counterFill.diffPos > 0) ||
        (!isCounterFill && counterFill.diffPos < 0)) counterFill.diffPos = 0;

    refresh();
  }

  void gestureUp() {
    if (counterFill.diffPos.abs() > 30 &&
        isCounterFill &&
        counterFill.diffPos < 0) {
      isCounterFill = false;
      counterFill.padding = EdgeInsets.only(top: 10.0);
      counterFill.alignment = Alignment.center;
    }
    counterFill.diffPos = 0.0;
    refresh();
  }

  void gestureDown() {
    if (counterFill.diffPos.abs() > 30 &&
        !isCounterFill &&
        counterFill.diffPos > 0) {
      isCounterFill = true;
      counterFill.padding = EdgeInsets.only(bottom: 100.0);
      counterFill.alignment = Alignment.bottomCenter;
    }
    counterFill.diffPos = 0.0;
    refresh();
  }

  void increment() {
    setCounter(value);
    value += 1;
    notifyListeners();
  }

  void decrement() async {
    if (value > 0) {
      value -= 1;
      touchCounters.removeAt(value);
    } else {
      value = 0;
    }
    setPreference(await getCurrentKey(), touchCounters);
    notifyListeners();
  }

  void reset() async {
    value = 0;
    touchCounters = [];
    setPreference(await getCurrentKey(), touchCounters);
    notifyListeners();
  }

  void setCounter(int value) async {
    touchCounters.add(TouchCounterModel(
      counter: value,
      datetime: DateTime.now(),
      diff: getDiff(value),
      type: 'seconds',
      animatedValue: 0.0,
    ));
    setPreference(await getCurrentKey(), touchCounters);
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
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 110,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  void initListPosition() {
    scrollController.animateTo(
      110 * touchCounters.length.toDouble(),
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void setController(AnimationController animationController) {
    _animationController = animationController;
  }

  void doAnimation() => _animationController.forward();
}

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
