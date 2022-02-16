import 'dart:convert';

import 'package:flutter/services.dart';

const String _configPath = 'assets/config.json';

Future<Map<String, dynamic>> loadConfig() async {
  String json = await rootBundle.loadString(_configPath);

  return jsonDecode(json) as Map<String, dynamic>;
}
