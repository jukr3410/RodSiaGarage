class Car {
  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.type,
    required this.year,
    required this.fuelType,
  });

  String id;
  String brand;
  String model;
  String type;
  String year;
  String fuelType;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["_id"],
        brand: json["brand"],
        model: json["model"],
        type: json["type"],
        year: json["year"],
        fuelType: json["fuelType"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "brand": brand,
        "model": model,
        "type": type,
        "year": year,
        "fuelType": fuelType,
      };
}
