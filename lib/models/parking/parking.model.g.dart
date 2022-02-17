// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Parking _$ParkingFromJson(Map<String, dynamic> json) => Parking(
      json['name'] as String,
      json['latitude'] as String,
      json['longitude'] as String,
      json['spots'] as int,
    );

Map<String, dynamic> _$ParkingToJson(Parking instance) => <String, dynamic>{
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'spots': instance.spots,
    };
