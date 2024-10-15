import 'dart:convert';

import 'package:sulok/network/api_response_model.dart';
import 'package:sulok/screens/login/model/messages_response.dart';
import '../../constant/global_functions.dart';
import '../../network/api_urls.dart';
import '../../network/base_api.dart';
import 'package:http/http.dart' as http;

class MessagesRepo {
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
      final response = await BaseAPI.post(ApiUrl.sendMsgSalik, body);
      var model = ApiResponseModel.fromJson(response);
      return model;
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR LOGIN REPO');
      return ApiResponseModel(msg: 'حدث حطاء في الاتصال', msgNum: 2);
    }
  }

  Future<List<MsgResponse>> getAllMsg() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.getAllMsg));
      final List<dynamic> jsonData = jsonDecode(response.body)['messages'];
      return jsonData.map((msg) => MsgResponse.fromJson(msg)).toList();
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR LOGIN REPO');
      return [];
    }
  }
}
