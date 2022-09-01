class Coord {
  Coord({
      this.lat, 
      this.lon,});

  Coord.fromJson(dynamic json) {
    lat = json['lat'];
    lon = json['lon'];
  }
  double? lat;
  double? lon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['lon'] = lon;
    return map;
  }

}