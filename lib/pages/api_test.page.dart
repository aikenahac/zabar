import 'package:flutter/material.dart';
import 'package:zabar/api/bicikelj_api/api.bicikelj.dart';
import 'package:zabar/models/bicikelj/bicikelj.model.dart';

class ApiTest extends StatelessWidget {
  const ApiTest({Key? key}) : super(key: key);

  void _getBicikeLJTerminals() async {
    List<BicikeLJ> terminals = await getAllTerminals();

    for (BicikeLJ terminal in terminals) {
      print('Name: ${terminal.name}');
      print('Station: ${terminal.station}');
      print('Coordinates:');
      print('    Lat: ${terminal.lat}');
      print('    Lng: ${terminal.lng}');
      print('----------');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('API Testing'),
      ),
      body: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FloatingActionButton.extended(
              onPressed: _getBicikeLJTerminals,
              label: const Text('BicikeLJ'),
              icon: const Icon(Icons.pedal_bike),
            ),
          ],
        ),
      ),
    );
  }
}
