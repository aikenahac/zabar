import 'package:json_annotation/json_annotation.dart';

part 'parking.model.g.dart';

@JsonSerializable()
class Parking {
  @JsonValue('Ime')
  final String name;

  @JsonValue('KoordinataY_wgs')
  final String latitude;

  @JsonValue('KoordinataX_wgs')
  final String longitude;

  @JsonValue('St_mest')
  final int spots;

  Parking(
    this.name,
    this.latitude,
    this.longitude,
    this.spots,
  );

  factory Parking.fromJson(Map<String, dynamic> json) => _$ParkingFromJson(json);
}
