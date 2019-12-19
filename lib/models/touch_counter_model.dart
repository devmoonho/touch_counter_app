import 'package:json_annotation/json_annotation.dart';

part 'touch_counter_model.g.dart';

@JsonSerializable()
// flutter pub run build_runner build
class TouchCounterModel {
  int counter;
  DateTime datetime;
  Duration diff;
  String type;
  double animatedValue;

  TouchCounterModel({
    this.counter,
    this.datetime,
    this.diff,
    this.type,
    this.animatedValue,
  });

  factory TouchCounterModel.fromMap(Map<String, dynamic> map) => _$TouchCounterModelFromJson(map);

  Map<String, dynamic> toMap() => _$TouchCounterModelToJson(this);
}



