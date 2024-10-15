import '../../constant/global_functions.dart';
import '../../network/api_response_model.dart';
import '../../network/api_urls.dart';
import '../../network/base_api.dart';

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
}
