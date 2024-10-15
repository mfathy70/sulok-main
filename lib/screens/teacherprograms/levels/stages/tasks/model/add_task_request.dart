// To parse this JSON data, do
//
//     final addTaskRequest = addTaskRequestFromJson(jsonString);

import 'dart:convert';

AddTaskRequest addTaskRequestFromJson(String str) =>
    AddTaskRequest.fromJson(json.decode(str));

String addTaskRequestToJson(AddTaskRequest data) => json.encode(data.toJson());

class AddTaskRequest {
  String? name;
  String? info;
  String? url;
  String? startCondition;
  String? startCompletion;
  String? endCondition;
  String? endCompletion;
  // String? duration;
  String? relatedCount;
  String? relatedTime;
  String? mustContinuous;
  String? reminder;
  String? prayer;
  String? weight;
  String? point;
  String? stageId;
  String? token;

  AddTaskRequest({
    this.name,
    this.info,
    this.url,
    this.startCondition,
    this.startCompletion,
    this.endCondition,
    this.endCompletion,
    // this.duration,
    this.relatedCount,
    this.relatedTime,
    this.mustContinuous,
    this.reminder,
    this.prayer,
    this.weight,
    this.point,
    this.stageId,
    this.token,
  });

  factory AddTaskRequest.fromJson(Map<String, dynamic> json) => AddTaskRequest(
        name: json["name"],
        info: json["info"],
        url: json["url"],
        startCondition: json["startCondition"],
        startCompletion: json["startCompletion"],
        endCondition: json["endCondition"],
        endCompletion: json["endCompletion"],
        // duration: json["duration"],
        relatedCount: json["relatedCount"],
        relatedTime: json["relatedTime"],
        mustContinuous: json["mustContinuous"],
        reminder: json["reminder"],
        prayer: json["prayer"],
        weight: json["weight"],
        point: json["point"],
        stageId: json["stage_id"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "info": info,
        "url": url,
        "startCondition": startCondition,
        "startCompletion": startCompletion,
        "endCondition": endCondition,
        "endCompletion": endCompletion,
        // "duration": duration,
        "relatedCount": relatedCount,
        "relatedTime": relatedTime,
        "mustContinuous": mustContinuous,
        "reminder": reminder,
        "prayer": prayer,
        "weight": weight,
        "point": point,
        "stage_id": stageId,
        "token": token,
      };
}

class UpdateTaskRequest {
  String? name;
  String? info;
  String? url;
  String? startCondition;
  String? startCompletion;
  String? endCondition;
  String? endCompletion;
  // String? duration;
  String? relatedCount;
  String? relatedTime;
  String? mustContinuous;
  String? reminder;
  String? prayer;
  String? weight;
  String? point;
  String? stageId;
  String? token;
  String? id;

  UpdateTaskRequest({
    this.id,
    this.name,
    this.info,
    this.url,
    this.startCondition,
    this.startCompletion,
    this.endCondition,
    this.endCompletion,
    // this.duration,
    this.relatedCount,
    this.relatedTime,
    this.mustContinuous,
    this.reminder,
    this.prayer,
    this.weight,
    this.point,
    this.stageId,
    this.token,
  });

  factory UpdateTaskRequest.fromJson(Map<String, dynamic> json) =>
      UpdateTaskRequest(
        name: json["name"],
        id: json["id"],
        info: json["info"],
        url: json["url"],
        startCondition: json["startCondition"],
        startCompletion: json["startCompletion"],
        endCondition: json["endCondition"],
        endCompletion: json["endCompletion"],
        // duration: json["duration"],
        relatedCount: json["relatedCount"],
        relatedTime: json["relatedTime"],
        mustContinuous: json["mustContinuous"],
        reminder: json["reminder"],
        prayer: json["prayer"],
        weight: json["weight"],
        point: json["point"],
        stageId: json["stage_id"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "info": info,
        "url": url,
        "startCondition": startCondition,
        "startCompletion": startCompletion,
        "endCondition": endCondition,
        "endCompletion": endCompletion,
        // "duration": duration,
        "relatedCount": relatedCount,
        "relatedTime": relatedTime,
        "mustContinuous": mustContinuous,
        "reminder": reminder,
        "prayer": prayer,
        "weight": weight,
        "point": point,
        "stage_id": stageId,
        "token": token,
      };
}
