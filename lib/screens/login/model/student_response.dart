// To parse this JSON data, do
//
//     final studentResponse = studentResponseFromJson(jsonString);

import 'dart:convert';

StudentResponse studentResponseFromJson(String str) =>
    StudentResponse.fromJson(json.decode(str));

String studentResponseToJson(StudentResponse data) =>
    json.encode(data.toJson());

class StudentResponse {
  List<Task>? tasks;
  Chart? chart;
  List<Map<String, List<int>>>? points;
  Message? message;
  List<NotificationModel>? notification;
  Profile? profile;
  int? msgNum;
  String? msg;
  List<Program>? programs;

  StudentResponse({
    this.tasks,
    this.chart,
    this.points,
    this.message,
    this.notification,
    this.profile,
    this.msgNum,
    this.msg,
    this.programs,
  });

  factory StudentResponse.fromJson(Map<String, dynamic> json) =>
      StudentResponse(
        tasks: json["tasks"] == null
            ? []
            : List<Task>.from(json["tasks"]!.map((x) => Task.fromJson(x))),
        chart: json["chart"] == null ? null : Chart.fromJson(json["chart"]),
        points: json["points"] == null
            ? []
            : List<Map<String, List<int>>>.from(json["points"]!.map((x) =>
                Map.from(x).map((k, v) => MapEntry<String, List<int>>(
                    k, List<int>.from(v.map((x) => x)))))),
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
        notification: json["notification"] == null
            ? []
            : List<NotificationModel>.from(json["notification"]!
                .map((x) => NotificationModel.fromJson(x))),
        profile:
            json["profile"] == null ? null : Profile.fromJson(json["profile"]),
        msgNum: json["msgNum"],
        msg: json["msg"],
        programs: json["programs"] == null
            ? []
            : List<Program>.from(
                json["programs"]!.map((x) => Program.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tasks": tasks == null
            ? []
            : List<dynamic>.from(tasks!.map((x) => x.toJson())),
        "chart": chart?.toJson(),
        "points": points == null
            ? []
            : List<dynamic>.from(points!.map((x) => Map.from(x).map((k, v) =>
                MapEntry<String, dynamic>(
                    k, List<dynamic>.from(v.map((x) => x)))))),
        "message": message?.toJson(),
        "notification": notification == null
            ? []
            : List<dynamic>.from(notification!.map((x) => x.toJson())),
        "profile": profile?.toJson(),
        "msgNum": msgNum,
        "msg": msg,
        "programs": programs == null
            ? []
            : List<dynamic>.from(programs!.map((x) => x.toJson())),
      };
}

class Chart {
  List<Map>? items;
  String? total;

  Chart({
    this.items,
    this.total,
  });

  factory Chart.fromJson(Map<String, dynamic> json) {
    List<Map> items = [];
    json.forEach((key, value) {
      if (key != 'total') {
        items.add(value);
      }
    });
    return Chart(
      items: items,
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, Map> mapItems = {};
    var count = 0;
    items?.forEach((element) {
      mapItems[count.toString()] = element;
      count++;
    });
    return {
      for (var i in mapItems.entries) i.key: i.value,
      "total": total,
    };
  }
}

class The0 {
  String? program;
  int? progress;

  The0({
    this.program,
    this.progress,
  });

  factory The0.fromJson(Map<String, dynamic> json) => The0(
        program: json["program"],
        progress: json["progress"],
      );

  Map<String, dynamic> toJson() => {
        "program": program,
        "progress": progress,
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
                json["read"]!.map((x) => MessageData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "new": messageNew == null
            ? []
            : List<dynamic>.from(messageNew!.map((x) => x.toJson())),
        "read": read == null
            ? []
            : List<dynamic>.from(read!.map((x) => x.toJson())),
      };
}

class MessageData {
  String? name;
  String? msg;
  DateTime? createdAt;
  int? id;
  String? from;

  MessageData({
    this.name,
    this.msg,
    this.createdAt,
    this.id,
    this.from,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) => MessageData(
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

class Profile {
  int? id;
  String? name;
  dynamic reson;
  dynamic file;
  dynamic universityNumber;
  String? course;
  String? phone;
  dynamic dateBirth;
  String? sex;
  String? residence;
  String? marital;
  String? numberChildren;
  String? forensicStudies;
  String? educational;
  String? sheikhEducation;
  String? sheikhName;
  String? email;
  String? points;
  String? progress;
  String? token;
  String? tokenfcm;
  String? cityhallId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? shi5Id;

  Profile({
    this.id,
    this.name,
    this.reson,
    this.file,
    this.universityNumber,
    this.course,
    this.progress,
    this.points,
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
    this.shi5Id,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        name: json["name"],
        points: json["points"].toString(),
        progress: json["progress"].toString(),
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
        shi5Id: json["shi5_id"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "reson": reson,
        "file": file,
        "universityNumber": universityNumber,
        "course": course,
        "phone": phone,
        "dateBirth": dateBirth,
        "sex": sex,
        "residence": residence,
        "progress": progress,
        "points": points,
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
        "shi5_id": shi5Id,
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
  String? info;
  String? url;
  String? relatedCount;
  String? iscount;
  String? relatedTime;
  String? mustContinuous;
  String? weight;
  String? point;
  String? status;
  bool isOpen = false;
  int? remainingCount;

  Task(
      {this.id,
      this.name,
      this.info,
      this.url,
      this.relatedCount,
      this.iscount,
      this.relatedTime,
      this.mustContinuous,
      this.weight,
      this.point,
      this.status,
      this.remainingCount});

  factory Task.fromJson(Map<String, dynamic> json) => Task(
      id: json["id"],
      iscount: json["iscount"],
      name: json["name"],
      info: json["info"],
      url: json["url"],
      relatedCount: json["relatedCount"],
      relatedTime: json["relatedTime"],
      mustContinuous: json["mustContinuous"],
      weight: json["weight"],
      point: json["point"],
      status: json["status"],
      remainingCount: json["remaining_count"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "info": info,
        "iscount": iscount,
        "url": url,
        "relatedCount": relatedCount,
        "relatedTime": relatedTime,
        "mustContinuous": mustContinuous,
        "weight": weight,
        "point": point,
        "status": status,
        "remaining_count": remainingCount,
      };
}

class CompletedTask {
  int? id;
  String? name;
  String? sync;
  DateTime? startfrom;
  String? reminder;
  String? days;
  String? count;
  String? idTask;
  String? idSalik;
  int? cityhallId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? iscount;
  DateTime? updatedIn;

  CompletedTask({
    this.id,
    this.name,
    this.sync,
    this.startfrom,
    this.reminder,
    this.days,
    this.count,
    this.idTask,
    this.idSalik,
    this.cityhallId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.iscount,
    this.updatedIn,
  });

  factory CompletedTask.fromJson(Map<String, dynamic> json) => CompletedTask(
        id: json["id"],
        name: json["name"],
        sync: json["sync"],
        startfrom: json["startfrom"] == null
            ? null
            : DateTime.parse(json["startfrom"]),
        reminder: json["reminder"],
        days: json["days"],
        count: json["count"],
        idTask: json["id_task"],
        idSalik: json["id_salik"],
        cityhallId: json["cityhall_id"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        iscount: json["iscount"],
        updatedIn: json["updated_in"] == null
            ? null
            : DateTime.parse(json["updated_in"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sync": sync,
        "startfrom":
            "${startfrom!.year.toString().padLeft(4, '0')}-${startfrom!.month.toString().padLeft(2, '0')}-${startfrom!.day.toString().padLeft(2, '0')}",
        "reminder": reminder,
        "days": days,
        "count": count,
        "id_task": idTask,
        "id_salik": idSalik,
        "cityhall_id": cityhallId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "iscount": iscount,
        "updated_in": updatedIn?.toIso8601String(),
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
