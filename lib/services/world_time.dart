import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location
  String flag; //url to an asset image
  String url; // path of api url
  String time = '';
  bool isDaytime = false;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      var url = Uri.https(
          'worldtimeapi.org', '/api/timezone/${this.url}', {'q': '{http}'});

      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        //get properties
        String datetime = jsonResponse['datetime'];
        String offset = jsonResponse['utc_offset'].substring(1, 3);

        //create DateTime object
        DateTime now = DateTime.parse(datetime);

        now = now.add(Duration(hours: int.parse(offset)));

        isDaytime = now.hour > 6 && now.hour < 20;

        time = DateFormat.jm().format(now);
      }
    } catch (e) {
      time = "Could not get time data";
    }
  }
}
