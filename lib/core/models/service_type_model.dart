// To parse this JSON data, do
//
//     final serviceType = serviceTypeFromJson(jsonString);

import 'dart:convert';

ServiceType serviceTypeFromJson(String str) =>
    ServiceType.fromJson(json.decode(str));

String serviceTypeToJson(ServiceType data) => json.encode(data.toJson());

class ServiceType {
  ServiceType({
    required this.id,
    required this.name,
    required this.description,
  });

  String id;
  String name;
  String description;

  factory ServiceType.fromJson(Map<String, dynamic> json) => ServiceType(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
      };
}
