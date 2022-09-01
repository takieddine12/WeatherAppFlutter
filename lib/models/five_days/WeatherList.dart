import 'Main.dart';
import 'Weather.dart';
import 'Clouds.dart';
import 'Wind.dart';
import 'Sys.dart';

class WeatherList {
  WeatherList({
      this.dt, 
      this.main, 
      this.weather, 
      this.clouds, 
      this.wind, 
      this.visibility, 
      this.pop, 
      this.sys, 
      this.dtTxt,});

  WeatherList.fromJson(dynamic json) {
    dt = json['dt'];
    main = json['main'] != null ? Main.fromJson(json['main']) : null;
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather?.add(Weather.fromJson(v));
      });
    }
    clouds = json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null;
    wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;
    visibility = json['visibility'];
    pop = json['pop'];
    sys = json['sys'] != null ? Sys.fromJson(json['sys']) : null;
    dtTxt = json['dt_txt'];
  }
  int? dt;
  Main? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind;
  int? visibility;
  num? pop;
  Sys? sys;
  String? dtTxt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dt'] = dt;
    final main = this.main;
    if (main != null) {
      map['main'] = main.toJson();
    }
    final weather = this.weather;
    if (weather != null) {
      map['weather'] = weather.map((v) => v.toJson()).toList();
    }
    final clouds = this.clouds;
    if (clouds != null) {
      map['clouds'] = clouds.toJson();
    }
    final wind = this.wind;
    if (wind != null) {
      map['wind'] = wind.toJson();
    }
    map['visibility'] = visibility;
    map['pop'] = pop;
    final sys = this.sys;
    if (sys != null) {
      map['sys'] = sys.toJson();
    }
    map['dt_txt'] = dtTxt;
    return map;
  }

}