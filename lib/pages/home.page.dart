import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:zabar/utils/config.helper.dart';
import 'package:zabar/utils/location.helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: loadConfig(),
            builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.hasData) {
                return MapboxMap(
                  accessToken: snapshot.data!['mapbox_token'],
                  myLocationEnabled: true,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(
                      45.45,
                      45.45,
                    ),
                  ),
                  onMapCreated: (MapboxMapController controller) async {
                    final location = await acquireCurrentLocation();
                    controller.animateCamera(
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
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}