import 'dart:convert';
import 'package:http/http.dart' as http;

class API {
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final url = Uri.parse(endpoint);

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.get(
      url,
      headers: headers,
    );

    final Map<String, dynamic> responseBody = jsonDecode(response.body);

    return responseBody;
  }
}
