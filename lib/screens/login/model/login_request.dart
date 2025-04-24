class LoginRequest {
  final String? token;
  final String? phone;
  final String? tokenfcm;
  final String? latitude;
  final String? longitude;

  LoginRequest({
    this.token,
    this.tokenfcm,
    this.phone,
    this.latitude,
    this.longitude,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        token: json["token"],
        tokenfcm: json["tokenfcm"],
        phone: json["phone"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "phone": phone,
        "tokenfcm": tokenfcm,
        "latitude": latitude,
        "longitude": longitude,
      };
}
