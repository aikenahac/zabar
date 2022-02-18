import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:zabar/api/bicikelj_api/api.bicikelj.dart';
import 'package:zabar/models/bicikelj/bicikelj.model.dart';
import 'package:zabar/utils/config.helper.dart';
import 'package:zabar/utils/location.helper.dart';
import 'package:zabar/utils/marker_utils/bicikelj_markers.util.dart';
import 'package:zabar/widgets/marker.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Random _rnd = Random();

  late MapboxMapController _controller;

  final List<Marker> _markers = [];
  final List<MarkerState> _markerStates = [];

  @override
  void initState() {
    super.initState();
  }

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

  void _addMarker(Point<double> point, LatLng coordinates, Widget body) {
    setState(() {
      _markers.add(Marker(_rnd.nextInt(100000).toString(), coordinates, point, _addMarkerStates, body));
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
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    child: const Icon(Icons.pedal_bike),
                    onPressed: () async {
                      final List<BicikeLJ> terminals = await getAllTerminals();
                      createBicikeljMarkers(terminals, _controller, _addMarker);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
