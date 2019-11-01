class TouchCounter {
  int counter;
  DateTime datetime;
  DateTime diff;

  TouchCounter({this.counter, this.datetime, this.diff});
}

final List<TouchCounter> counterTimers = [
  TouchCounter(counter: 11, datetime: DateTime(1989, 02, 1, 15, 40, 10).subtract(new Duration(hours: 8)), diff: null),
  TouchCounter(counter: 10, datetime: DateTime(1989, 02, 1, 15, 40, 10).subtract(new Duration(hours: 7)), diff: null),
  TouchCounter(counter: 9, datetime: DateTime(1989, 02, 1, 15, 40, 10).subtract(new Duration(hours: 6)), diff: null),
  TouchCounter(counter: 8, datetime: DateTime(1989, 02, 1, 15, 40, 10).subtract(new Duration(hours: 5)), diff: null),
  TouchCounter(counter: 7, datetime: DateTime(1989, 02, 1, 15, 40, 10).subtract(new Duration(hours: 4)), diff: null),
  TouchCounter(counter: 6, datetime: DateTime(1989, 02, 1, 15, 40, 10).subtract(new Duration(hours: 3)), diff: null),
  TouchCounter(counter: 5, datetime: DateTime(1989, 02, 1, 15, 40, 10).subtract(new Duration(hours: 2)), diff: null),
  TouchCounter(counter: 4, datetime: DateTime(1989, 02, 1, 15, 40, 10).subtract(new Duration(hours: 1)), diff: null),
  TouchCounter(counter: 3, datetime: DateTime(1989, 02, 1, 15, 40, 10).subtract(new Duration(minutes: 30)), diff: null),
  TouchCounter(counter: 2, datetime: DateTime(1989, 02, 1, 15, 40, 10).subtract(new Duration(seconds: 30)), diff: null),
  TouchCounter(counter: 1, datetime: DateTime(1989, 02, 1, 15, 40, 10).subtract(new Duration(seconds: 1)), diff: null),
];
