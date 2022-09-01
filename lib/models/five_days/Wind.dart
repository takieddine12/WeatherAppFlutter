class Wind {
  Wind({
       this.speed,
       this.deg,
       this.gust,});

  Wind.fromJson(dynamic json) {
    speed = json['speed'];
    deg = json['deg'];
    gust = json['gust'];
  }
  num? speed;
  int? deg;
  num? gust;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['speed'] = speed;
    map['deg'] = deg;
    map['gust'] = gust;
    return map;
  }

}