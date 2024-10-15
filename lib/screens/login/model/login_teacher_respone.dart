// To parse this JSON data, do
//
//     final loginTeacherResponse = loginTeacherResponseFromJson(jsonString);

import 'dart:convert';

import 'package:sulok/screens/login/model/student_response.dart';

LoginTeacherResponse loginTeacherResponseFromJson(String str) =>
    LoginTeacherResponse.fromJson(json.decode(str));

String loginTeacherResponseToJson(LoginTeacherResponse data) =>
    json.encode(data.toJson());

class LoginTeacherResponse {
  Salik? salik;
  Info? info;
  int? msgNum;
  String? msg;
  Report? report;
  List<Program>? programs;
  Message? message;
  List<NotificationModel>? notification;

  LoginTeacherResponse({
    this.salik,
    this.info,
    this.report,
    this.msgNum,
    this.msg,
    this.programs,
    this.message,
    this.notification,
  });

  factory LoginTeacherResponse.fromJson(Map<String, dynamic> json) =>
      LoginTeacherResponse(
        salik: json["salik"] == null ? null : Salik.fromJson(json["salik"]),
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
        msgNum: json["msgNum"],
        report: json["report"] == null ? null : Report.fromJson(json["report"]),
        msg: json["msg"],
        programs: json["programs"] == null
            ? []
            : List<Program>.from(
                json["programs"]!.map((x) => Program.fromJson(x))),
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
        notification: json["notification"] == null
            ? []
            : List<NotificationModel>.from(json["notification"]!
                .map((x) => NotificationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "salik": salik?.toJson(),
        "info": info?.toJson(),
        "msgNum": msgNum,
        "report": report?.toJson(),
        "msg": msg,
        "programs": programs == null
            ? []
            : List<dynamic>.from(programs!.map((x) => x.toJson())),
        "message": message?.toJson(),
        "notification": notification == null
            ? []
            : List<dynamic>.from(notification!.map((x) => x.toJson())),
      };
}

class Report {
  Map<String, dynamic>? reportData;

  Report({this.reportData});

  factory Report.fromJson(Map<String, dynamic> json) =>
      Report(reportData: json);

  Map<String, dynamic> toJson() => reportData ?? {};
}

class Info {
  int? id;
  String? name;
  String? description;
  String? token;
  String? phone;
  String? code;

  Info({
    this.id,
    this.name,
    this.description,
    this.token,
    this.phone,
    this.code,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        token: json["token"],
        phone: json["phone"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "token": token,
        "phone": phone,
        "code": code,
      };
}

class Message {
  List<MessageData>? messageNew;
  List<MessageData>? read;

  Message({
    this.messageNew,
    this.read,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      messageNew: json["new"] == null
          ? []
          : List<MessageData>.from(
              json["new"]!.map((x) => MessageData.fromJson(x))),
      read: json["read"] == null
          ? []
          : List<MessageData>.from(
              json["read"]!.map((x) => MessageData.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "new": messageNew == null
            ? []
            : List<dynamic>.from(messageNew!.map((x) => x.toJson())),
        "read": read == null
            ? []
            : List<dynamic>.from(read!.map((x) => x.toJson())),
      };
}

class Program {
  int? id;
  String? name;
  String? info;
  List<Program>? level;
  List<Program>? stage;
  List<Task>? task;

  Program({
    this.id,
    this.name,
    this.info,
    this.level,
    this.stage,
    this.task,
  });

  factory Program.fromJson(Map<String, dynamic> json) => Program(
        id: json["id"],
        name: json["name"],
        info: json["info"],
        level: json["level"] == null
            ? []
            : List<Program>.from(
                json["level"]!.map((x) => Program.fromJson(x))),
        stage: json["stage"] == null
            ? []
            : List<Program>.from(
                json["stage"]!.map((x) => Program.fromJson(x))),
        task: json["task"] == null
            ? []
            : List<Task>.from(json["task"]!.map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "info": info,
        "level": level == null
            ? []
            : List<dynamic>.from(level!.map((x) => x.toJson())),
        "stage": stage == null
            ? []
            : List<dynamic>.from(stage!.map((x) => x.toJson())),
        "task": task == null
            ? []
            : List<dynamic>.from(task!.map((x) => x.toJson())),
      };
}

class Task {
  int? id;
  String? name;
  dynamic reson;
  String? info;
  String? url;
  String? startCondition;
  String? startCompletion;
  String? endCondition;
  String? endCompletion;
  dynamic duration;
  String? relatedCount;
  String? relatedTime;
  String? mustContinuous;
  String? reminder;
  String? prayer;
  String? weight;
  String? point;
  int? cityhallId;
  int? stageId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Task({
    this.id,
    this.name,
    this.reson,
    this.info,
    this.url,
    this.startCondition,
    this.startCompletion,
    this.endCondition,
    this.endCompletion,
    this.duration,
    this.relatedCount,
    this.relatedTime,
    this.mustContinuous,
    this.reminder,
    this.prayer,
    this.weight,
    this.point,
    this.cityhallId,
    this.stageId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        name: json["name"],
        reson: json["reson"],
        info: json["info"],
        url: json["url"],
        startCondition: json["startCondition"],
        startCompletion: json["startCompletion"],
        endCondition: json["endCondition"],
        endCompletion: json["endCompletion"],
        duration: json["duration"],
        relatedCount: json["relatedCount"],
        relatedTime: json["relatedTime"],
        mustContinuous: json["mustContinuous"],
        reminder: json["reminder"],
        prayer: json["prayer"],
        weight: json["weight"],
        point: json["point"],
        cityhallId: json["cityhall_id"],
        stageId: json["stage_id"],
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
        "info": info,
        "url": url,
        "startCondition": startCondition,
        "startCompletion": startCompletion,
        "endCondition": endCondition,
        "endCompletion": endCompletion,
        "duration": duration,
        "relatedCount": relatedCount,
        "relatedTime": relatedTime,
        "mustContinuous": mustContinuous,
        "reminder": reminder,
        "prayer": prayer,
        "weight": weight,
        "point": point,
        "cityhall_id": cityhallId,
        "stage_id": stageId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Salik {
  List<Student>? active;
  List<Student>? pinding;

  Salik({
    this.active,
    this.pinding,
  });

  factory Salik.fromJson(Map<String, dynamic> json) => Salik(
        active: json["active"] == null
            ? []
            : List<Student>.from(
                json["active"]!.map((x) => Student.fromJson(x))),
        pinding: json["pinding"] == null
            ? []
            : List<Student>.from(
                json["pinding"]!.map((x) => Student.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "active": active == null
            ? []
            : List<dynamic>.from(active!.map((x) => x.toJson())),
        "pinding": pinding == null
            ? []
            : List<dynamic>.from(pinding!.map((x) => x.toJson())),
      };
}

class Student {
  int? id;
  String? name;
  dynamic reson;
  dynamic file;
  String? universityNumber;
  String? course;
  String? phone;
  String? points;
  String? progress;
  String? dateBirth;
  String? sex;
  String? residence;
  String? marital;
  String? numberChildren;
  String? forensicStudies;
  String? educational;
  String? sheikhEducation;
  String? sheikhName;
  String? email;
  String? token;
  String? tokenfcm;
  int? cityhallId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Student({
    this.id,
    this.name,
    this.progress,
    this.points,
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
    this.token,
    this.tokenfcm,
    this.cityhallId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        name: json["name"],
        progress: json["progress"].toString(),
        points: json["points"].toString(),
        reson: json["reson"],
        file: json["file"],
        universityNumber: json["universityNumber"],
        course: json["course"],
        phone: json["phone"],
        dateBirth: json["dateBirth"],
        sex: json["sex"],
        residence: json["residence"],
        marital: json["marital"],
        numberChildren: json["numberChildren"],
        forensicStudies: json["forensicStudies"],
        educational: json["educational"],
        sheikhEducation: json["sheikhEducation"],
        sheikhName: json["sheikhName"],
        email: json["email"],
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
        "points": points,
        "progress": progress,
        "file": file,
        "universityNumber": universityNumber,
        "course": course,
        "phone": phone,
        "dateBirth": dateBirth,
        "sex": sex,
        "residence": residence,
        "marital": marital,
        "numberChildren": numberChildren,
        "forensicStudies": forensicStudies,
        "educational": educational,
        "sheikhEducation": sheikhEducation,
        "sheikhName": sheikhName,
        "email": email,
        "token": token,
        "tokenfcm": tokenfcm,
        "cityhall_id": cityhallId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class NotificationModel {
  String? name;
  String? msg;
  DateTime? createdAt;
  int? id;
  String? from;
  bool? isOpen = false;

  NotificationModel({
    this.name,
    this.msg,
    this.createdAt,
    this.id,
    this.from,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        name: json["name"],
        msg: json["msg"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
        from: json["from"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "msg": msg,
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "from": from,
      };
}
