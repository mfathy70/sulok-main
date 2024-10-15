import 'dart:convert';
import 'dart:developer';

import 'package:sulok/constant/global_functions.dart';
import 'package:sulok/screens/login/model/login_request.dart';
import 'package:sulok/screens/login/model/login_teacher_respone.dart';
import 'package:sulok/screens/splash/model/sliders.dart';
import '../../helper/local_storage_helper.dart';
import '../../network/api_urls.dart';
import '../../network/base_api.dart';
import 'model/student_response.dart';

class LoginRepo {
  Future<LoginTeacherResponse> loginRequestAPI(
      LoginRequest loginRequest) async {
    try {
      final response =
          await BaseAPI.post(ApiUrl.teacherLogin, loginRequest.toJson());
      var loginTeacherResponse = LoginTeacherResponse.fromJson(response);
      if (loginTeacherResponse.info?.token == null) {
        return LoginTeacherResponse(
            msgNum: 0, msg: loginTeacherResponse.msg ?? 'حدث خطاء في الاتصال');
      }
      return loginTeacherResponse;
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR LOGIN REPO');
      return LoginTeacherResponse(msgNum: 0, msg: 'حدث خطاء في الاتصال');
    }
  }

  Future<StudentResponse> studentRegisterAPI(LoginRequest loginRequest) async {
    try {
      final response =
          await BaseAPI.post(ApiUrl.authStudent, loginRequest.toJson());
      var student = StudentResponse.fromJson(response);
      if (student.profile == null) {
        return StudentResponse(msgNum: 55, msg: student.msg ?? "");
      }
      return student;
    } catch (e) {
      log(e.toString(), name: 'ERROR STUDENT LOGIN REPO');
      return StudentResponse(msgNum: 0, msg: 'حدث خطاء في الاتصال');
    }
  }

  Future<LoginTeacherResponse> refreshTeacherData() async {
    try {
      final response = await BaseAPI.post(ApiUrl.teacherLogin, {});
      var loginTeacherResponse = LoginTeacherResponse.fromJson(response);
      if (loginTeacherResponse.info?.token == null) {
        return LoginTeacherResponse(msgNum: 0, msg: 'حدث خطاء في الاتصال');
      }
      await LocalStorageHelper.saveTeacherData(loginTeacherResponse);
      return loginTeacherResponse;
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR LOGIN REPO');
      return LoginTeacherResponse(msgNum: 0, msg: 'حدث خطاء في الاتصال');
    }
  }

  Future<StudentResponse> refreshStudentData() async {
    try {
      final response = await BaseAPI.post(ApiUrl.authStudent, {});
      var model = StudentResponse.fromJson(response);
      if (model.profile?.token == null) {
        return StudentResponse(msgNum: 0, msg: 'حدث خطاء في الاتصال');
      }
      await LocalStorageHelper.saveStudentData(model);
      return model;
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR LOGIN REPO');
      return StudentResponse(msgNum: 0, msg: 'حدث خطاء في الاتصال');
    }
  }
}
