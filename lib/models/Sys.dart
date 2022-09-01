class Sys {
  Sys({
      this.country, 
      this.sunrise, 
      this.sunset,});

  Sys.fromJson(dynamic json) {
    country = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }
  String? country;
  int? sunrise;
  int? sunset;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['country'] = country;
    map['sunrise'] = sunrise;
    map['sunset'] = sunset;
    return map;
  }

}