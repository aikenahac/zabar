// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bicikelj.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BicikeLJ _$BicikeLJFromJson(Map<String, dynamic> json) => BicikeLJ(
      json['name'] as String,
      json['lat'] as String,
      json['lng'] as String,
      Station.fromJson(json['station'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BicikeLJToJson(BicikeLJ instance) => <String, dynamic>{
      'name': instance.name,
      'lat': instance.lat,
      'lng': instance.lng,
      'station': instance.station,
    };
