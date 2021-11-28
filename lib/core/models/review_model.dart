// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

import 'package:rodsiagarage/core/models/user_model.dart';

Review reviewFromJson(String str) => Review.fromJson(json.decode(str));

String reviewToJson(Review data) => json.encode(data.toJson());

class Review {
  Review({
    required this.text,
    required this.star,
  });

  String text;
  int star;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        text: json["text"],
        star: json["star"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "star": star,
      };
}
