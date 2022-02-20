import 'package:zabar/models/apljubljana/station.model.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

// Future<List<BusStation>>
Future<List<dynamic>> getAllBusStations() async {
  final response = await http.Client().get(Uri.parse('https://www.ap-ljubljana.si/'));

  if (response.statusCode == 200) {
    var document = parse(response.body);
    var stationsString = document.getElementsByTagName("timetable-form")[0].attributes["postajalisca"];
    var stations = stationsString?.split(",");

    var newstations = [];
    stations?.forEach((element) {
      if (element.contains("[")) {
        element = element.replaceAll("[", "");
      }
      if (element.contains("]")) {
        element = element.replaceAll("]", "");
      }
      element = element.replaceAll("'", "");
      newstations.add(BusStation(element));
    });

    return newstations;
  } else {
    throw Exception();
  }
}