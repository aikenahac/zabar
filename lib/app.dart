import 'package:flutter/material.dart';
import 'package:zabar/pages/home.page.dart';
import 'api/apljubljana_api/api.apljubljana.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllBusStations().then((value) => print(value));
    return const MaterialApp(
      title: 'Žabar',
      home: HomePage(),
    );
  }
}
