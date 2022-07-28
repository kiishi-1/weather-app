import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class WeatherServices {
  final String apiHost = 'X-RapidAPI-Host';
  final String api = 'X-RapidAPI-Key';
  final String hostKey = 'community-open-weather-map.p.rapidapi.com';
  final String apiKey = 'd7c2464680msh8fdb7c37eb1dc36p1590c8jsn6e23f7f216c7';

  Future<Map<String, dynamic>> getCurrentWeather({required String? q}) async {
    //nullable cus we want to assign a value to q even without searching i.e any time we call the function
    http.Response response = await http.get(
      Uri.parse(
          'https://community-open-weather-map.p.rapidapi.com/weather?q=$q'),
      headers: {apiHost: hostKey, api: apiKey},
    );
    //print(response);
    final data = jsonDecode(response.body);
    //body is a property of Response
    //we  are using body cus body hold the data we want to use. check postman
    //Response holds many properties
    return data;
  }

  Future<List<Map<String, dynamic>>> getCurrentWeather2({required String? q}) async {
    http.Response response = await http.get(
      Uri.parse(
          'https://community-open-weather-map.p.rapidapi.com/forecast/daily?q=$q'),
      headers: {apiHost: hostKey, api: apiKey},
    );
    //print(response);
    final data = jsonDecode(response.body)["list"];
    print(data);
    final List<Map<String, dynamic>> forecastList =
        List<Map<String, dynamic>>.from(
      data.map((e) => e),
    );
    //print('liiiiiiiiii');
    return forecastList;
  }

  Future<List<Map<String, dynamic>>> getCurrentWeather3({required String? q}) async {
    http.Response response = await http.get(
      Uri.parse(
          'https://community-open-weather-map.p.rapidapi.com/forecast?q=$q'),
      headers: {apiHost: hostKey, api: apiKey},
    );
    //print(response);
    final data = jsonDecode(response.body)["list"];
    print(jsonDecode(response.body));
    //print(data);
    final List<Map<String, dynamic>> forecastList2 =
        List<Map<String, dynamic>>.from(
      data.map((e) => e),
      
    );
    //print(forecastList2);
    //print(data);
    //print('kishi');
    
    return forecastList2;
  }
}
