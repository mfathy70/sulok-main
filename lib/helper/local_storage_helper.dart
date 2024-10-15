import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:sulok/screens/login/model/login_teacher_respone.dart';
import 'package:sulok/screens/login/model/student_response.dart';
import 'package:sulok/screens/splash/splash_screen.dart';

class LocalStorageHelper {
  static FlutterSecureStorage storage = const FlutterSecureStorage();

  ///Intro
  static Future<void> changeSkipLandingPage(bool skip) async {
    await storage.write(
        key: LocalStorageKeys.skipLandingPage, value: skip ? '1' : '0');
  }

  static Future<bool> skipLandingPage() async {
    return await storage.read(key: LocalStorageKeys.skipLandingPage) == '1';
  }

  static Future<String?> checkUserType() async {
    return await storage.read(key: LocalStorageKeys.userType);
  }

  ///Auth Teacher
  static Future<void> saveTeacherData(
      LoginTeacherResponse loginTeacherResponse) async {
    await storage.write(key: LocalStorageKeys.userType, value: '1');
    await storage.write(
        key: LocalStorageKeys.teacherData,
        value: json.encode(loginTeacherResponse.toJson()));
  }

  static Future<LoginTeacherResponse> getTeacherData() async {
    LoginTeacherResponse loginTeacherResponse = LoginTeacherResponse.fromJson(
        json.decode(
            await storage.read(key: LocalStorageKeys.teacherData) ?? "{}"));
    return loginTeacherResponse;
  }

  static Future<bool> checkTeacherIsLoggedIn() async {
    LoginTeacherResponse loginTeacherResponse = LoginTeacherResponse.fromJson(
        json.decode(
            await storage.read(key: LocalStorageKeys.teacherData) ?? "{}"));
    return loginTeacherResponse.info?.token?.isNotEmpty ?? false;
  }

  static Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await storage.delete(key: LocalStorageKeys.teacherData);
    await storage.delete(key: LocalStorageKeys.studentData);
    await storage.delete(key: LocalStorageKeys.userType);
    Get.offAll(const SplashScreen());
  }

  ///End Auth Teacher

  ///Student Auth

  static Future<void> saveStudentData(StudentResponse studentResponse) async {
    await storage.write(key: LocalStorageKeys.userType, value: '2');
    await storage.write(
        key: LocalStorageKeys.studentData,
        value: json.encode(studentResponse.toJson()));
  }

  static Future<StudentResponse> getStudentData() async {
    StudentResponse loginTeacherResponse = StudentResponse.fromJson(json
        .decode(await storage.read(key: LocalStorageKeys.studentData) ?? "{}"));
    // print(loginTeacherResponse.toJson());
    return loginTeacherResponse;
  }

  static Future<bool> checkStudentIsLoggedIn() async {
    StudentResponse studentResponse = StudentResponse.fromJson(json
        .decode(await storage.read(key: LocalStorageKeys.studentData) ?? "{}"));
    return studentResponse.profile?.token?.isNotEmpty ?? false;
  }
}

class LocalStorageKeys {
  static String skipLandingPage = '0';
  static String teacherData = '1';
  static String studentData = '2';
  static String userType = '3';
}
