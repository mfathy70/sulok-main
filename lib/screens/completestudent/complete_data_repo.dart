import '../../constant/global_functions.dart';
import '../../network/api_response_model.dart';
import '../../network/api_urls.dart';
import '../../network/base_api.dart';
import '../login/model/login_teacher_respone.dart';
import 'model/complete_student_request.dart';

class CompleteDataRepo {
  Future<ApiResponseModel> completeStudentData(
      CompleteStudentRequest completeStudentRequest) async {
    try {
      final response = await BaseAPI.post(
          ApiUrl.authStudent, completeStudentRequest.toJson());
      var model = ApiResponseModel.fromJson(response);
      return model;
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR LOGIN REPO');
      return ApiResponseModel(msgNum: 0, msg: 'حدث خطاء في الاتصال');
    }
  }
  Future<ApiResponseModel> deleteMyAccount(
      ) async {
    try {
      final response = await BaseAPI.post(
          ApiUrl.deleteAccount, {});
      var model = ApiResponseModel.fromJson(response);
      return model;
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR LOGIN REPO');
      return ApiResponseModel(msgNum: 0, msg: 'حدث خطاء في الاتصال');
    }
  }
}
