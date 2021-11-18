class GarageLogin {
  String phone;
  String password;

  GarageLogin({required this.phone, required this.password});

  Map<String, dynamic> toJson() =>
      {"phone": this.phone, "password": this.password};
}

class Token {
  String garage_id;
  String token;

  Token({required this.token, required this.garage_id});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(token: json['token'], garage_id: json['garage_id']);
  }
}
