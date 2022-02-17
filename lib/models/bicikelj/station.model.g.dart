// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Station _$StationFromJson(Map<String, dynamic> json) => Station(
      json['available'] as String,
      json['free'] as String,
    );

Map<String, dynamic> _$StationToJson(Station instance) => <String, dynamic>{
      'available': instance.available,
      'free': instance.free,
    };
