class GarageDB {
  int id;
  String? garage_id;
  String phone;
  String? token;

  GarageDB({required this.id, this.garage_id, required this.phone, this.token});

  factory GarageDB.fromDatabaseJson(Map<String, dynamic> data) => GarageDB(
        id: data['id'],
        garage_id: data['garage_id'],
        phone: data['phone'],
        token: data['token'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "garage_id": this.garage_id,
        "phone": this.phone,
        "token": this.token
      };
}
