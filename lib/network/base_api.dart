import 'dart:convert';
import 'package:alice/core/alice_http_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:sulok/helper/local_storage_helper.dart';
import '../constant/global_functions.dart';
import 'api_response_model.dart';
import 'package:alice/alice.dart';

class BaseAPI {
  static Alice alice = Alice(
    showNotification: false,
    showInspectorOnShake: false,
    darkTheme: false,
    maxCallsCount: 10,
  );
  static const int _timeOutValueSeconds = 1000;

  static Future<dynamic> post(String url, Map<String, dynamic> body) async {
    try {
      body['token'] = FirebaseAuth.instance.currentUser?.uid ?? "";
      secureLog(url, name: 'POST');
      secureLog(body.toString(), name: 'BODY');
      final String queryString = Uri(
          queryParameters:
          body.map((key, value) => MapEntry(key, value?.toString()))).query;
      String fullUrl = "$url?$queryString";
      var response = await http
          .post(Uri.parse(fullUrl), headers: await getHeader(), body: {})
          .interceptWithAlice(alice, body: body)
          .timeout(
            const Duration(seconds: _timeOutValueSeconds),
          );
      Future.delayed(const Duration(seconds: 1))
          .then((value) => securePrint(response.body));
      secureLog(response.statusCode.toString(), name: 'POST STATUS CODE');
      secureLog(response.body, name: 'POST BODY');
      secureLog(
          '----------------------------------------------------------------',
          name: 'END POST');

      return (json.decode(response.body));
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR $url');
      return ApiResponseModel(msgNum: 0, msg: 'حدث مشكلة بالاتصال');
    }
  }

  // static Future<ApiResponseModel> postMultipartRequest(
  //     String url, Map<String, String> body, String? filePath) async {
  //   try {
  //     var request = http.MultipartRequest('POST', Uri.parse(url));
  //     request.headers.addAll(await getHeader());
  //     request.fields.addAll(body);
  //     if (filePath != null) {
  //       request.files
  //           .addAll({await http.MultipartFile.fromPath('image', filePath)});
  //     }
  //     http.StreamedResponse response = await request.send();
  //     var responseBody = await response.stream.bytesToString();
  //
  //     secureLog(
  //       'START',
  //       name: 'post $url API $body',
  //     );
  //     Future.delayed(const Duration(seconds: 1))
  //         .then((value) => securePrint(responseBody));
  //
  //     return ApiResponseModel.fromJson(json.decode(responseBody));
  //   } catch (e) {
  //     return ApiResponseModel(message: 'حدث خطاء', status: '0', data: {});
  //   }
  // }

  static Future<dynamic> get(String url, Map<String, dynamic> body,
      {bool? apiResponseModel}) async {
    apiResponseModel ??= true;
    try {
      final String queryString = Uri(
          queryParameters:
              body.map((key, value) => MapEntry(key, value?.toString()))).query;
      String fullUrl = "$url?$queryString";
      secureLog('START', name: 'Get $fullUrl API');
      var response = await http
          .get(Uri.parse(fullUrl), headers: await getHeader())
          .interceptWithAlice(alice, body: body)
          .timeout(
            const Duration(seconds: _timeOutValueSeconds),
          );
      secureLog(response.body, name: 'STATUS CODE ${response.statusCode}');
      if (response.statusCode == 401) {
        // makesecureLogOut();
      }
      if (apiResponseModel) {
        return ApiResponseModel.fromJson(json.decode(response.body));
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      secureLog(e.toString(), name: 'GET API ERROR $url');
      return ApiResponseModel(msgNum: 0, msg: '');
    }
  }

  static Future<Map<String, String>> getHeader() async {
    // String apiKey =
    //     'ZZnUS84FEKcw8roZlLwrJ83keSGj661AMomSjTMpiEsBoIlSgsOPI9kHV1ByV7ekBmOqe3oZ63ar8tV55vNZH4J78SMLCAR9iNxrHEXx6pMLVkU1KjzDUEGd9kaVAmZlB3dD4HZSXT4WdGFTDfmzJKlPuBQU4ep4MYQMewlqd8EclYwyZb4DKA7e7dyLyHgkkGOYGN6rQV9zhXPx2gS0LUJpagcDN827VHJ9Uivy5mCbTTpomydCh0Xpjz4UIrFh';
    // String? token = await LocalStorageHelper.getToken();
    String? token = '';
    Map<String, String> header = {
      // 'api_key': apiKey,
      'Accept': 'application/json',
      // 'Authorization': 'Bearer $token'
    };
    return header;
  }

// static Future<dynamic> put(String url, Map<String, dynamic> body,
//     {bool? isJson}) async {
//   http.Response response;
//   try {
//     final String queryString = Uri(
//         queryParameters:
//         body.map((key, value) => MapEntry(key, value?.toString()))).query;
//
//     String fullUrl = "$url?$queryString";
//     secureLog('START', name: 'PUT $fullUrl API');
//     response = await http
//         .put(Uri.parse(fullUrl), headers: _headers)
//         .interceptWithAlice(alice, body: body)
//         .timeout(
//       const Duration(seconds: _timeOutValueSeconds),
//     );
//     secureLog(response.body, name: 'STATUS CODE ${response.statusCode}');
//   } on SocketException catch (e) {
//     secureLog(e.message);
//     throw FetchDataException('No Internet connection');
//   } on Exception {
//     throw FetchDataException('Server Error');
//   }
//   if (isJson == false) return response;
//   return _handelResponse(response);
// }
//
// static Future<dynamic> head(String url, Map<String, dynamic> body,
//     {bool? isJson}) async {
//   http.Response response;
//   try {
//     final String queryString = Uri(
//         queryParameters:
//         body.map((key, value) => MapEntry(key, value?.toString()))).query;
//
//     String fullUrl = "$url?$queryString";
//     secureLog('START', name: 'HEAD $fullUrl API');
//     response = await http
//         .head(Uri.parse(fullUrl), headers: _headers)
//         .interceptWithAlice(alice, body: body)
//         .timeout(
//       const Duration(seconds: _timeOutValueSeconds),
//     );
//     secureLog(response.body, name: 'STATUS CODE ${response.statusCode}');
//   } on SocketException catch (e) {
//     secureLog(e.message);
//     throw FetchDataException('No Internet connection');
//   } on Exception {
//     throw FetchDataException('Server Error');
//   }
//   if (isJson == false) return response;
//   return _handelResponse(response);
// }

// static http.Response _handelResponse(http.Response response) {
//   return response;
// }
}
