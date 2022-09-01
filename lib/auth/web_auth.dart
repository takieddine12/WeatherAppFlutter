import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/utils.dart';
import '../models/CurrentWeatherModel.dart';
import 'dart:io';

import '../models/five_days/FiveDaysWeatherModel.dart';

class WebService {
  Future<CurrentWeatherModel?> getCurrentWeather(double lat , double lon) async {
    var fullUrl = "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=${Utils.apiKey}";
    var response = await http.get(Uri.parse(fullUrl));
    if(response.statusCode == 200){
      var decodedJson = jsonDecode(response.body);
      return CurrentWeatherModel.fromJson(decodedJson);
    } else {
      return null;
    }
  }
  Future<FiveDaysWeatherModel?> getSevenDaysWeather(double lat , double lon) async {
    var fullUrl = "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&units=metric&appid=${Utils.apiKey}";
    var response = await http.get(Uri.parse(fullUrl));
    if(response.statusCode == 200){
      var decodedJson = jsonDecode(response.body);
      return FiveDaysWeatherModel.fromJson(decodedJson);
    } else {
      return null;
    }
  }
}