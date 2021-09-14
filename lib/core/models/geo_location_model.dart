// To parse this JSON data, do
//
//     final geoLocation = geoLocationFromJson(jsonString);

import 'dart:convert';

GeoLocation geoLocationFromJson(String str) =>
    GeoLocation.fromJson(json.decode(str));

String geoLocationToJson(GeoLocation data) => json.encode(data.toJson());

class GeoLocation {
  GeoLocation({
    this.lat,
    this.long,
  });

  String? lat;
  String? long;

  factory GeoLocation.fromJson(Map<String, dynamic> json) => GeoLocation(
        lat: json["lat"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "long": long,
      };
}
