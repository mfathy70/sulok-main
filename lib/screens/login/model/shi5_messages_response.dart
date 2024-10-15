// To parse this JSON data, do
//
//     final shi5MsgResponse = shi5MsgResponseFromJson(jsonString);

import 'dart:convert';

Shi5MsgResponse shi5MsgResponseFromJson(String str) =>
    Shi5MsgResponse.fromJson(json.decode(str));

String shi5MsgResponseToJson(Shi5MsgResponse data) =>
    json.encode(data.toJson());

class Shi5MsgResponse {
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
  Salik? salik;

  Shi5MsgResponse({
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
    this.salik,
  });

  factory Shi5MsgResponse.fromJson(Map<String, dynamic> json) =>
      Shi5MsgResponse(
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
        salik: json["salik"] == null ? null : Salik.fromJson(json["salik"]),
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
        "salik": salik?.toJson(),
      };
}

class Salik {
  int? id;
  String? name;
  dynamic reson;
  dynamic file;
  dynamic universityNumber;
  dynamic course;
  String? phone;
  DateTime? dateBirth;
  String? sex;
  String? residence;
  String? marital;
  dynamic numberChildren;
  String? forensicStudies;
  String? educational;
  String? sheikhEducation;
  dynamic sheikhName;
  String? email;
  int? points;
  int? progress;
  String? token;
  String? tokenfcm;
  int? cityhallId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Salik({
    this.id,
    this.name,
    this.reson,
    this.file,
    this.universityNumber,
    this.course,
    this.phone,
    this.dateBirth,
    this.sex,
    this.residence,
    this.marital,
    this.numberChildren,
    this.forensicStudies,
    this.educational,
    this.sheikhEducation,
    this.sheikhName,
    this.email,
    this.points,
    this.progress,
    this.token,
    this.tokenfcm,
    this.cityhallId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Salik.fromJson(Map<String, dynamic> json) => Salik(
        id: json["id"],
        name: json["name"],
        reson: json["reson"],
        file: json["file"],
        universityNumber: json["universityNumber"],
        course: json["course"],
        phone: json["phone"],
        dateBirth: json["dateBirth"] == null
            ? null
            : DateTime.parse(json["dateBirth"]),
        sex: json["sex"],
        residence: json["residence"],
        marital: json["marital"],
        numberChildren: json["numberChildren"],
        forensicStudies: json["forensicStudies"],
        educational: json["educational"],
        sheikhEducation: json["sheikhEducation"],
        sheikhName: json["sheikhName"],
        email: json["email"],
        points: json["points"],
        progress: json["progress"],
        token: json["token"],
        tokenfcm: json["tokenfcm"],
        cityhallId: json["cityhall_id"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "reson": reson,
        "file": file,
        "universityNumber": universityNumber,
        "course": course,
        "phone": phone,
        "dateBirth":
            "${dateBirth!.year.toString().padLeft(4, '0')}-${dateBirth!.month.toString().padLeft(2, '0')}-${dateBirth!.day.toString().padLeft(2, '0')}",
        "sex": sex,
        "residence": residence,
        "marital": marital,
        "numberChildren": numberChildren,
        "forensicStudies": forensicStudies,
        "educational": educational,
        "sheikhEducation": sheikhEducation,
        "sheikhName": sheikhName,
        "email": email,
        "points": points,
        "progress": progress,
        "token": token,
        "tokenfcm": tokenfcm,
        "cityhall_id": cityhallId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
