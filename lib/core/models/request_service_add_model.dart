// To parse this JSON data, do
//
//     final requestAdd = requestAddFromJson(jsonString);

import 'dart:convert';

import 'package:rodsiagarage/core/models/geo_location_model.dart';

import 'car_model.dart';
import 'geo_location_model.dart';

RequestServiceAdd requestAddFromJson(String str) =>
    RequestServiceAdd.fromJson(json.decode(str));

String requestAddToJson(RequestServiceAdd data) => json.encode(data.toJson());

class RequestServiceAdd {
  RequestServiceAdd({
    this.id,
    required this.user,
    required this.service,
    //required this.garage,
    required this.addressUser,
    required this.geoLocationUser,
    required this.geoLocationGarage,
    required this.problemDesc,
    required this.confirmRequest,
    required this.status,
    required this.car,
    //this.createdAt
  });

  String? id;
  String user;
  //String garage;
  String service;
  String addressUser;
  GeoLocation geoLocationUser;
  GeoLocation geoLocationGarage;
  String problemDesc;
  bool confirmRequest;
  String status;
  Car car;
  //DateTime? createdAt;

  factory RequestServiceAdd.fromJson(Map<String, dynamic> json) =>
      RequestServiceAdd(
        id: json["_id"],
        user: json["user"],
        service: json["service"],
        //garage: json['garage'],
        addressUser: json['addressUser'],
        geoLocationUser: GeoLocation.fromJson(json["geoLocationUser"]),
        geoLocationGarage: GeoLocation.fromJson(json["geoLocationGarage"]),
        problemDesc: json["problemDesc"],
        confirmRequest: json["confirmRequest"],
        status: json["status"],
        car: Car.fromJson(json["car"]),
        // createdAt: DateTime.parse(json["createdAt"])
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "service": service,
        //"garage": garage,
        "addressUser": addressUser,
        "geoLocationUser": geoLocationUser.toJson(),
        "geoLocationGarage": geoLocationGarage.toJson(),
        "problemDesc": problemDesc,
        "confirmRequest": confirmRequest,
        "status": status,
        "car": car.toJson(),
        //"createdAt": createdAt
      };
}
