import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sulok/screens/login/model/student_response.dart';
import '../../constant/global_functions.dart';
import '../../network/api_response_model.dart';
import '../../network/api_urls.dart';
import '../../network/base_api.dart';
import 'package:http/http.dart' as http;

class StudentMainRepo {
  Future<ApiResponseModel> taskComplete(String id, {String? count}) async {
    try {
      final response = await BaseAPI.post(ApiUrl.authStudent,
          {'taskcomplete': id, if (count != null) 'iscount': count});
      print(response);
      var model = ApiResponseModel.fromJson(response);
      return model;
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR LOGIN REPO');
      return ApiResponseModel(msg: 'حدث حطاء في الاتصال', msgNum: 2);
    }
  }

  Future<ApiResponseModel> taskUnComplete(String id) async {
    try {
      final response =
          await BaseAPI.post(ApiUrl.authStudent, {'taskuncomplete': id});
      var model = ApiResponseModel.fromJson(response);
      return model;
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR LOGIN REPO');
      return ApiResponseModel(msg: 'حدث حطاء في الاتصال', msgNum: 2);
    }
  }

  Future<List<CompletedTask>> getCompletedTasks(String from, String to) async {
    try {
      final response = await http.post(
        Uri.parse(
            "${ApiUrl.getCmpletedTasks}?status=complete&from=$from&to=$to"),
        body: {"token": FirebaseAuth.instance.currentUser?.uid},
      );
      var data = jsonDecode(response.body);
      if (data["tasks"] != null) {
        List taskList = data["tasks"];
        List<CompletedTask> tasks = List<CompletedTask>.from(
            taskList.map((e) => CompletedTask.fromJson(e)));
        return tasks;
      }
      return [];
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR STUDENT REPO');
      return [];
    }
  }
}
