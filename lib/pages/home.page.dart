import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:zabar/api/bicikelj_api/api.bicikelj.dart';
import 'package:zabar/models/bicikelj/bicikelj.model.dart';
import 'package:zabar/utils/config.helper.dart';
import 'package:zabar/utils/location.helper.dart';
import 'package:zabar/widgets/marker.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Random _rnd = Random();

  late MapboxMapController _controller;

  List<Marker> _markers = [];

  List<MarkerState> _markerStates = [];

  _onMapCreated(MapboxMapController controller) async {
    _controller = controller;
    final location = await acquireCurrentLocation();
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            location.latitude,
            location.longitude,
          ),
          zoom: 15,
        ),
      ),
    );
    _controller.addListener(() {
      if (_controller.onCameraIdle != null) {
        _updateMarkerPosition();
      }
    });
  }

  void _addMarkerStates(MarkerState markerState) {
    _markerStates.add(markerState);
  }

  void _addMarker(Point<double> point, LatLng coordinates) {
    setState(() {
      _markers.add(Marker(_rnd.nextInt(100000).toString(), coordinates, point, _addMarkerStates));
    });
  }

  void _setBicikeljMarkers(List terminals) {
    var param = <LatLng>[];

    for (BicikeLJ terminal in terminals) {
      param.add(LatLng(double.parse(terminal.lat), double.parse(terminal.lng)));
    }

    _controller.toScreenLocationBatch(param).then((value) {
      for (int i = 0; i < terminals.length; i++) {
        final point = Point<double>(value[i].x as double, value[i].y as double);
        _addMarker(point, param[i]);
      }
    });
  }

  void _onCameraIdleCallback() {
    _updateMarkerPosition();
  }

  void _updateMarkerPosition() {
    final coordinates = <LatLng>[];

    for (final markerState in _markerStates) {
      coordinates.add(markerState.getCoordinate());
    }

    _controller.toScreenLocationBatch(coordinates).then((points) {
      _markerStates.asMap().forEach((i, value) {
        _markerStates[i].updatePosition(points[i]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          FutureBuilder(
            future: loadConfig(),
            builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  children: [
                    MapboxMap(
                      accessToken: snapshot.data!['mapbox_token'],
                      myLocationEnabled: true,
                      onCameraIdle: _onCameraIdleCallback,
                      trackCameraPosition: true,
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(
                          45.45,
                          45.45,
                        ),
                      ),
                      onMapCreated: _onMapCreated,
                    ),
                    IgnorePointer(
                      ignoring: false,
                      child: Stack(
                        children: _markers,
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () async {
                  final List<BicikeLJ> terminals = await getAllTerminals();
                  _setBicikeljMarkers(terminals);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
