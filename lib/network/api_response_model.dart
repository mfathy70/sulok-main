// To parse this JSON data, do
//
//     final apiResponseModel = apiResponseModelFromJson(jsonString);

import 'dart:convert';

ApiResponseModel apiResponseModelFromJson(String str) => ApiResponseModel.fromJson(json.decode(str));

String apiResponseModelToJson(ApiResponseModel data) => json.encode(data.toJson());

class ApiResponseModel {
  int? msgNum;
  String? msg;

  ApiResponseModel({
    this.msgNum,
    this.msg,
  });

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) => ApiResponseModel(
    msgNum: json["msgNum"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "msgNum": msgNum,
    "msg": msg,
  };
}
