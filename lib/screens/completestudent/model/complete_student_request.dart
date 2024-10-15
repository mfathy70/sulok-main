// To parse this JSON data, do
//
//     final completeStudentData = completeStudentDataFromJson(jsonString);

import 'dart:convert';

CompleteStudentRequest completeStudentDataFromJson(String str) =>
    CompleteStudentRequest.fromJson(json.decode(str));

String completeStudentDataToJson(CompleteStudentRequest data) =>
    json.encode(data.toJson());

class CompleteStudentRequest {
  String? token;
  String? name;
  String? universityNumber;
  String? course;
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
  String? teacherCode;

  CompleteStudentRequest({
    this.token,
    this.name,
    this.universityNumber,
    this.course,
    this.dateBirth,
    this.teacherCode,
    this.sex,
    this.residence,
    this.marital,
    this.numberChildren,
    this.forensicStudies,
    this.educational,
    this.sheikhEducation,
    this.sheikhName,
    this.email,
  });

  factory CompleteStudentRequest.fromJson(Map<String, dynamic> json) =>
      CompleteStudentRequest(
        token: json["token"],
        name: json["name"],
        teacherCode: json["cityhall_id"],
        universityNumber: json["universityNumber"],
        course: json["course"],
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
      );

  Map<String, dynamic> toJson() => {
        "token": token ?? "",
        "cityhall_id": teacherCode ?? "",
        "name": name ?? "",
        "universityNumber": universityNumber ?? "",
        "course": course ?? "",
        "dateBirth": dateBirth ?? "",
        "sex": sex ?? "",
        "residence": residence ?? "",
        "marital": marital ?? "",
        "numberChildren": numberChildren ?? "",
        "forensicStudies": forensicStudies ?? "",
        "educational": educational ?? "",
        "sheikhEducation": sheikhEducation ?? "",
        "sheikhName": sheikhName ?? "",
        "email": email ?? "",
      };
}
