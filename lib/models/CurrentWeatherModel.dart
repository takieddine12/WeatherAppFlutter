import 'Coord.dart';
import 'Weather.dart';
import 'Main.dart';
import 'Wind.dart';
import 'Clouds.dart';
import 'Sys.dart';

class CurrentWeatherModel {
  CurrentWeatherModel({
      this.coord, 
      this.weather, 
      this.base, 
      this.main, 
      this.visibility, 
      this.wind, 
      this.clouds, 
      this.dt, 
      this.sys, 
      this.timezone, 
      this.id, 
      this.name, 
      this.cod,});

  CurrentWeatherModel.fromJson(dynamic json) {
    coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather?.add(Weather.fromJson(v));
      });
    }
    base = json['base'];
    main = json['main'] != null ? Main.fromJson(json['main']) : null;
    visibility = json['visibility'];
    wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;
    clouds = json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null;
    dt = json['dt'];
    sys = json['sys'] != null ? Sys.fromJson(json['sys']) : null;
    timezone = json['timezone'];
    id = json['id'];
    name = json['name'];
    cod = json['cod'];
  }
  Coord? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    final coord = this.coord;
    if (coord != null) {
      map['coord'] = coord.toJson();
    }
    final weather = this.weather;
    if (weather != null) {
      map['weather'] = weather.map((v) => v.toJson()).toList();
    }
    map['base'] = base;
    final main = this.main;
    if (main != null) {
      map['main'] = main.toJson();
    }
    map['visibility'] = visibility;
    final wind = this.wind;
    if (wind != null) {
      map['wind'] = wind.toJson();
    }
    final clouds = this.clouds;
    if (clouds != null) {
      map['clouds'] = clouds.toJson();
    }
    map['dt'] = dt;
    final sys = this.sys;
    if (sys != null) {
      map['sys'] = sys.toJson();
    }
    map['timezone'] = timezone;
    map['id'] = id;
    map['name'] = name;
    map['cod'] = cod;
    return map;
  }

}