// To parse this JSON data, do
//
//     final requestAdd = requestAddFromJson(jsonString);

import 'dart:convert';

import 'package:rodsiagarage/core/services/geo_location_model.dart';

import 'car_model.dart';

RequestServiceAdd requestAddFromJson(String str) =>
    RequestServiceAdd.fromJson(json.decode(str));

String requestAddToJson(RequestServiceAdd data) => json.encode(data.toJson());

class RequestServiceAdd {
  RequestServiceAdd({
    this.id,
    required this.user,
    required this.service,
    required this.geoLocationUser,
    required this.geoLocationGarage,
    required this.problemDesc,
    required this.confirmRequest,
    required this.status,
    required this.car,
  });

  String? id;
  String user;
  String service;
  GeoLocation geoLocationUser;
  GeoLocation geoLocationGarage;
  String problemDesc;
  bool confirmRequest;
  String status;
  Car car;

  factory RequestServiceAdd.fromJson(Map<String, dynamic> json) =>
      RequestServiceAdd(
        id: json["_id"],
        user: json["user"],
        service: json["service"],
        geoLocationUser: GeoLocation.fromJson(json["geoLocationUser"]),
        geoLocationGarage: GeoLocation.fromJson(json["geoLocationGarage"]),
        problemDesc: json["problemDesc"],
        confirmRequest: json["confirmRequest"],
        status: json["status"],
        car: Car.fromJson(json["car"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "service": service,
        "geoLocationUser": geoLocationUser.toJson(),
        "geoLocationGarage": geoLocationGarage.toJson(),
        "problemDesc": problemDesc,
        "confirmRequest": confirmRequest,
        "status": status,
        "car": car.toJson(),
      };
}
