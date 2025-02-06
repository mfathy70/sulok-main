class LoginRequest {
  final String? token;
  final String? phone;
  final String? tokenfcm;
  final double? long;
  final double? lat;

  LoginRequest({
    this.token,
    this.tokenfcm,
    this.phone,
    this.long,
    this.lat,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        token: json["token"],
        tokenfcm: json["tokenfcm"],
        phone: json["phone"],
        lat: json["latitude"],
        long: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "phone": phone,
        "tokenfcm": tokenfcm,
        "latitude": lat,
        "longitude": long,
      };
}
