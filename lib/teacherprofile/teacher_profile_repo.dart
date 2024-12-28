import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sulok/constant/global_functions.dart';
import 'package:sulok/helper/custom/custom_loading.dart';
import 'package:sulok/helper/helper_functions.dart';
import 'package:sulok/network/api_response_model.dart';
import 'package:sulok/network/api_urls.dart';
import 'package:sulok/screens/login/login_controller.dart';
import 'package:sulok/screens/login/login_screen.dart';
import 'package:sulok/screens/mainteacher/main_teacer_screen.dart';

import '../network/base_api.dart';

class TeacherProfileRepo {
  Future<void> updateTeacherData(String name, String desc) async {
    loading();
    try {
      final response = await BaseAPI.post(
        ApiUrl.updateTeacherData,
        {
          "name": name,
          "descreption": desc,
          "token": FirebaseAuth.instance.currentUser?.uid ?? ""
        },
      );
      print(response);
      ApiResponseModel apiResponseModel =
          await ApiResponseModel.fromJson(response);
      print(apiResponseModel.msg);
      closeLoading();
      if (apiResponseModel.msgNum == 1) {
        Get.put(LoginController()).makeLoginTeacher(
            FirebaseAuth.instance.currentUser?.uid ?? "",
            FirebaseAuth.instance.currentUser?.phoneNumber);
        Get.offAll(const MainTeacherScreen());
      } else if (apiResponseModel.msgNum == 0) {
        Get.offAll(const LoginScreen());
        await HelperFun.showToast(apiResponseModel.msg ?? "");
      } else {
        await HelperFun.showToast(apiResponseModel.msg ?? "");
      }
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR LOGIN REPO');
    }
  }
}
