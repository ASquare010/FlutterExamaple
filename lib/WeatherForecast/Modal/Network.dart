//http://api.openweathermap.org/data/2.5/forecast?q=lahore&cnt=7&appid=d7ce83841d3908eb27a25017a80a0875 link
//d7ce83841d3908eb27a25017a80a0875 key

// To parse this JSON data, do
//
//     final weatherForecastApi = weatherForecastApiFromJson(jsonString);
import 'package:flutter_app/WeatherForecast/Utils.dart';
import 'package:http/http.dart'as http;
import 'Modal.dart';

class Network {

  // ignore: missing_return
  Future<ApiModal> getData(String cityName) async {
    final String url =
        'http://api.openweathermap.org/data/2.5/forecast?q=$cityName&cnt=30&units=metric&appid=${Utils.weatherApiKey}';

     final http.Response response = await http.get(Uri.parse(Uri.encodeFull(url)));
     print(response.statusCode);
     if (response.statusCode == 200) {
       return apiModalFromJson(response.body);
    }
    else {
      print('Error getting data in getData()');
    }

  }
}
