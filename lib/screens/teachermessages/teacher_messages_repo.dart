import 'dart:convert';

import 'package:sulok/network/api_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:sulok/screens/login/model/messages_response.dart';
import 'package:sulok/screens/login/model/shi5_messages_response.dart';
import '../../constant/global_functions.dart';
import '../../network/api_urls.dart';
import '../../network/base_api.dart';

class TeacherMessagesRepo {
  Future<ApiResponseModel> readMessageAPI(Map<String, String> body) async {
    try {
      final response = await BaseAPI.post(ApiUrl.readMsg, body);
      var model = ApiResponseModel.fromJson(response);
      return model;
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR LOGIN REPO');
      return ApiResponseModel(msg: 'حدث حطاء في الاتصال', msgNum: 2);
    }
  }

  Future<ApiResponseModel> deleteMessage(String id) async {
    try {
      final response = await BaseAPI.post(ApiUrl.deleteMsg, {'msgid': id});
      var model = ApiResponseModel.fromJson(response);
      return model;
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR LOGIN REPO');
      return ApiResponseModel(msg: 'حدث حطاء في الاتصال', msgNum: 2);
    }
  }

  Future<ApiResponseModel> sendMessage(Map<String, String> body) async {
    try {
      final response = await BaseAPI.post(ApiUrl.sendMsg, body);
      var model = ApiResponseModel.fromJson(response);
      return model;
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR LOGIN REPO');
      return ApiResponseModel(msg: 'حدث حطاء في الاتصال', msgNum: 2);
    }
  }

  Future<List<Shi5MsgResponse>> getAllMsgShi5(
      String? shi5Id, String? studentId) async {
    print(shi5Id);
    print(studentId);
    Uri url = studentId == null
        ? Uri.parse("${ApiUrl.getAllMsgShi5}?cityhall_id=$shi5Id")
        : Uri.parse(
            "${ApiUrl.getAllMsgShi5}?cityhall_id=$shi5Id&salik_id=$studentId");
    try {
      print(url);
      final response = await http.get(url);
      print(response.body);
      final List<dynamic> jsonData = jsonDecode(response.body)['messages'];
      return jsonData.map((msg) => Shi5MsgResponse.fromJson(msg)).toList();
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR LOGIN REPO');
      return [];
    }
  }
}
