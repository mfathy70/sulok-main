import 'dart:convert';

class LoginRequest {
  final String? token;
  final String? phone;
  final String? tokenfcm;

  LoginRequest({
    this.token,
    this.tokenfcm,
    this.phone,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
    token: json["token"],
    tokenfcm: json["tokenfcm"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "phone": phone,
    "tokenfcm": tokenfcm,
  };
}
