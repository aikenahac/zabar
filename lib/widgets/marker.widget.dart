import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:flutter/widgets.dart';

class Marker extends StatefulWidget {
  final Point _initialPosition;
  final LatLng _coordinates;
  final void Function(MarkerState) _addMarkerState;
  final Widget body;

  Marker(
    String key,
    this._coordinates,
    this._initialPosition,
    this._addMarkerState,
    this.body,
  ) : super(key: Key(key));

  @override
  State<StatefulWidget> createState() {
    final state = MarkerState(_initialPosition, body);
    _addMarkerState(state);
    return state;
  }
}

class MarkerState extends State with TickerProviderStateMixin {
  final _widgetSize = 30.0;

  Point _position;
  Widget body;

  late AnimationController _controller;

  MarkerState(this._position, this.body);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ratio = 1.0;

    ratio = Platform.isIOS ? 1.0 : MediaQuery.of(context).devicePixelRatio;

    return Positioned(
      left: _position.x / ratio - _widgetSize / 2,
      top: _position.y / ratio - _widgetSize / 2,
      child: SizedBox(
        width: _widgetSize,
        height: _widgetSize,
        child: body,
      ),
    );
  }

  void updatePosition(Point<num> point) {
    setState(() {
      _position = point;
    });
  }

  LatLng getCoordinate() {
    return (widget as Marker)._coordinates;
  }
}
