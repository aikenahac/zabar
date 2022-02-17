import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:flutter/widgets.dart';

class Marker extends StatefulWidget {
  final Point _initialPosition;
  final LatLng _coordinates;
  final void Function(MarkerState) _addMarkerState;

  Marker(
    String key,
    this._coordinates,
    this._initialPosition,
    this._addMarkerState,
  ) : super(key: Key(key));

  @override
  State<StatefulWidget> createState() {
    final state = MarkerState(_initialPosition);
    _addMarkerState(state);
    return state;
  }
}

class MarkerState extends State with TickerProviderStateMixin {
  final _widgetSize = 20.0;

  Point _position;

  late AnimationController _controller;
  late Animation<double> _animation;

  MarkerState(this._position);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
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
      child: RotationTransition(
        turns: _animation,
        child: Container(
          width: _widgetSize,
          height: _widgetSize,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
          ),
        ),
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
