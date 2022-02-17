import 'package:json_annotation/json_annotation.dart';
import 'package:zabar/models/bicikelj/station.model.dart';

part 'bicikelj.model.g.dart';

@JsonSerializable()
class BicikeLJ {
  final String name;
  final String lat;
  final String lng;
  final Station station;

  BicikeLJ(
    this.name,
    this.lat,
    this.lng,
    this.station,
  );

  factory BicikeLJ.fromJson(Map<String, dynamic> json) => _$BicikeLJFromJson(json);
}
