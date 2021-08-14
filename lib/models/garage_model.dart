import 'package:json_annotation/json_annotation.dart';

part 'garage_model.g.dart';

@JsonSerializable()
class Garage {
  String name;
  String phone;
  String email;

  Garage({required this.name, required this.phone, required this.email});

  factory Garage.fromJson(Map<String, dynamic> json) => _$GarageFromJson(json);

  Map<String, dynamic> toJson() => _$GarageToJson(this);
}
