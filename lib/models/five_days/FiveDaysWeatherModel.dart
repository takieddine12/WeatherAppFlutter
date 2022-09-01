import 'City.dart';
import 'WeatherList.dart';

class FiveDaysWeatherModel {
  FiveDaysWeatherModel({
      this.message, 
      this.cnt, 
      this.list, 
      this.city,});

  FiveDaysWeatherModel.fromJson(dynamic json) {
    message = json['message'];
    cnt = json['cnt'];
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list?.add(WeatherList.fromJson(v));
      });
    }
    city = json['city'] != null ? City.fromJson(json['city']) : null;
  }
  int? message;
  int? cnt;
  List<WeatherList>? list;
  City? city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['cnt'] = cnt;
    final list = this.list;
    if (list != null) {
      map['list'] = list.map((v) => v.toJson()).toList();
    }
    final city = this.city;
    if (city != null) {
      map['city'] = city.toJson();
    }
    return map;
  }

}