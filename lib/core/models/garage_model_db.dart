class GarageDB {
  int id;
  String phone;
  String? token;

  GarageDB({required this.id, required this.phone, this.token});

  factory GarageDB.fromDatabaseJson(Map<String, dynamic> data) => GarageDB(
        id: data['id'],
        phone: data['phone'],
        token: data['token'],
      );

  Map<String, dynamic> toDatabaseJson() =>
      {"id": this.id, "phone": this.phone, "token": this.token};
}
