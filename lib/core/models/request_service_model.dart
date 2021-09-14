// To parse this JSON data, do
//
//     final requestService = requestServiceFromJson(jsonString);

import 'dart:convert';

import 'package:rodsiagarage/core/models/geo_location_model.dart';
import 'package:rodsiagarage/core/models/service_model.dart';
import 'package:rodsiagarage/core/models/user_model.dart';

RequestService requestServiceFromJson(String str) =>
    RequestService.fromJson(json.decode(str));

String requestServiceToJson(RequestService data) => json.encode(data.toJson());

class RequestService {
  RequestService({
    this.id,
    this.problemDesc,
    this.user,
    this.service,
    this.car,
    this.confirmRequest,
    this.status,
    this.geoLocationUser,
    this.geoLocationGarage,
    this.image,
  });

  String? id;
  String? problemDesc;
  User? user;
  Service? service;
  Car? car;
  bool? confirmRequest;
  String? status;
  GeoLocation? geoLocationUser;
  GeoLocation? geoLocationGarage;
  String? image;

  factory RequestService.fromJson(Map<String, dynamic> json) => RequestService(
        id: json["_id"],
        problemDesc: json["problemDesc"],
        user: User.fromJson(json["user"]),
        service: Service.fromJson(json["service"]),
        car: Car.fromJson(json["car"]),
        confirmRequest: json["confirmRequest"],
        status: json["status"],
        geoLocationUser: GeoLocation.fromJson(json["geoLocationUser"]),
        geoLocationGarage: GeoLocation.fromJson(json["geoLocationGarage"]),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "problemDesc": problemDesc,
        "user": user!.toJson(),
        "service": service!.toJson(),
        "car": car!.toJson(),
        "confirmRequest": confirmRequest,
        "status": status,
        "geoLocationUser": geoLocationUser!.toJson(),
        "geoLocationGarage": geoLocationGarage!.toJson(),
        "image": image,
      };
}

class Car {
  Car({
    this.brand,
    this.model,
    this.type,
    this.year,
    this.fuelType,
  });

  String? brand;
  String? model;
  String? type;
  String? year;
  String? fuelType;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        brand: json["brand"],
        model: json["model"],
        type: json["type"],
        year: json["year"],
        fuelType: json["fuelType"],
      );

  Map<String, dynamic> toJson() => {
        "brand": brand,
        "model": model,
        "type": type,
        "year": year,
        "fuelType": fuelType,
      };
}
