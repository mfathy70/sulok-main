import '../../constant/global_functions.dart';
import '../../helper/local_storage_helper.dart';
import '../../network/api_urls.dart';
import '../../network/base_api.dart';
import '../login/model/login_teacher_respone.dart';

class MyStudentsRepo {
  Future<dynamic> activeOrDeActive(
      {required bool active, required String id}) async {
    try {
      final response = await BaseAPI.post(ApiUrl.getTeacherData, {
        (active) ? 'salikactive' : 'salikdeactive': id,
      });
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
}
