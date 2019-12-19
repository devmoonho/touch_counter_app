// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'touch_counter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TouchCounterModel _$TouchCounterModelFromJson(Map<String, dynamic> json) {
  return TouchCounterModel(
    counter: json['counter'] as int,
    datetime: json['datetime'] == null
        ? null
        : DateTime.parse(json['datetime'] as String),
    diff: json['diff'] == null
        ? null
        : Duration(microseconds: json['diff'] as int),
    type: json['type'] as String,
    animatedValue: (json['animatedValue'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$TouchCounterModelToJson(TouchCounterModel instance) =>
    <String, dynamic>{
      'counter': instance.counter,
      'datetime': instance.datetime?.toIso8601String(),
      'diff': instance.diff?.inMicroseconds,
      'type': instance.type,
      'animatedValue': instance.animatedValue,
    };
