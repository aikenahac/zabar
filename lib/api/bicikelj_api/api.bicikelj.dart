import 'package:zabar/api/api.client.dart';
import 'package:zabar/models/bicikelj/bicikelj.model.dart';

Future<List> getAllTerminals() async {
  final Map<String, dynamic> terminals = await API.get('http://opendata.si/promet/bicikelj/list/');

  List terminalList = Map<String, dynamic>.from(terminals['markers'])
      .values
      .map(
        (e) => BicikeLJ.fromJson(e),
      )
      .toList();

  return terminalList;
}
