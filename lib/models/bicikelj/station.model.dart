import 'package:json_annotation/json_annotation.dart';

part 'station.model.g.dart';

@JsonSerializable()
class Station {
  final String available;
  final String free;

  Station(
    this.available,
    this.free,
  );

  factory Station.fromJson(Map<String, dynamic> json) => _$StationFromJson(json);
}
