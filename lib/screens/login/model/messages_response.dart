// To parse this JSON data, do
//
//     final msgResponse = msgResponseFromJson(jsonString);

import 'dart:convert';

MsgResponse msgResponseFromJson(String str) =>
    MsgResponse.fromJson(json.decode(str));

String msgResponseToJson(MsgResponse data) => json.encode(data.toJson());

class MsgResponse {
  int? id;
  String? name;
  String? from;
  String? to;
  dynamic replay;
  String? msg;
  String? salikId;
  int? cityhallId;
  String? msgtype;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic updateIn;

  MsgResponse({
    this.id,
    this.name,
    this.from,
    this.to,
    this.replay,
    this.msg,
    this.salikId,
    this.cityhallId,
    this.msgtype,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.updateIn,
  });

  factory MsgResponse.fromJson(Map<String, dynamic> json) => MsgResponse(
        id: json["id"],
        name: json["name"],
        from: json["from"],
        to: json["to"],
        replay: json["replay"],
        msg: json["msg"],
        salikId: json["salik_id"],
        cityhallId: json["cityhall_id"],
        msgtype: json["msgtype"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        updateIn: json["update_in"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "from": from,
        "to": to,
        "replay": replay,
        "msg": msg,
        "salik_id": salikId,
        "cityhall_id": cityhallId,
        "msgtype": msgtype,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "update_in": updateIn,
      };
}
