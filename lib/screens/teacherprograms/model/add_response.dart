// To parse this JSON data, do
//
//     final addResponse = addResponseFromJson(jsonString);

import 'dart:convert';

AddResponse addResponseFromJson(String str) => AddResponse.fromJson(json.decode(str));

String addResponseToJson(AddResponse data) => json.encode(data.toJson());

class AddResponse {
  int? msgNum;
  String? msg;

  AddResponse({
    this.msgNum,
    this.msg,
  });

  factory AddResponse.fromJson(Map<String, dynamic> json) => AddResponse(
    msgNum: json["msgNum"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "msgNum": msgNum,
    "msg": msg,
  };
}
