import 'package:flutter/material.dart';
import 'package:zabar/pages/api_test.page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Žabar',
      home: ApiTest(),
    );
  }
}
