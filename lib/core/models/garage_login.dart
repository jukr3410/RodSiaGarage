class GarageLogin {
  String phone;
  String password;

  GarageLogin({required this.phone, required this.password});

  Map<String, dynamic> toJson() =>
      {"phone": this.phone, "password": this.password};
}

class Token {
  String token;

  Token({required this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(token: json['token']);
  }
}
