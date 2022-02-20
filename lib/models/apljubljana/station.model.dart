import 'package:json_annotation/json_annotation.dart';

part 'station.model.g.dart';

@JsonSerializable()
class BusStation {
  final String name;

  BusStation(
    this.name,
  );

  factory BusStation.fromJson(Map<String, dynamic> json) => _$BusStationFromJson(json);
}
