import 'dart:math';

import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:zabar/models/bicikelj/bicikelj.model.dart';
import 'package:zabar/widgets/markers/bicikelj_marker.widget.dart';

void createBicikeljMarkers(
  List<BicikeLJ> terminals,
  MapboxMapController controller,
  Function addMarkers,
) {
  var param = <LatLng>[];

  for (BicikeLJ terminal in terminals) {
    param.add(LatLng(double.parse(terminal.lat), double.parse(terminal.lng)));
  }

  controller.toScreenLocationBatch(param).then((value) {
    for (int i = 0; i < terminals.length; i++) {
      final point = Point<double>(value[i].x as double, value[i].y as double);
      addMarkers(point, param[i], BicikeLJMarker(terminal: terminals[i]));
    }
  });
}
