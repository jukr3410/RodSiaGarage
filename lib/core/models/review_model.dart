// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

import 'package:rodsiagarage/core/models/user_model.dart';

ReviewAdd reviewFromJson(String str) => ReviewAdd.fromJson(json.decode(str));

String reviewToJson(ReviewAdd data) => json.encode(data.toJson());

class ReviewAdd {
  ReviewAdd({
    required this.id,
    required this.text,
    required this.star,
    required this.user,
  });

  String id;
  String text;
  int star;
  User user;

  factory ReviewAdd.fromJson(Map<String, dynamic> json) => ReviewAdd(
        id: json["_id"],
        text: json["text"],
        star: json["star"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "text": text,
        "star": star,
        "user": user.toJson(),
      };
}
