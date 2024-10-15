import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sulok/helper/local_storage_helper.dart';
import 'package:sulok/screens/login/login_controller.dart';
import 'package:sulok/screens/login/login_screen.dart';
import 'package:sulok/screens/mainteacher/main_teacer_screen.dart';
import 'package:sulok/screens/splash/splash_repo.dart';

import '../completestudent/complete_student_screen.dart';
import 'landing_screen.dart';
import 'model/sliders.dart';

class SplashController extends GetxController {
  SplashRepo splashRepo = SplashRepo();
  List<Sliders>? sliders;
  late PageController pageViewController;

  int currentIndex = 0;

  bool moving = false;

  @override
  void onInit() async {
    super.onInit();
    sliders = [];
    sliders?.add(Sliders(id: 10101, description: '', image: '', title: ''));
    sliders?.addAll(await splashRepo.getSliders());
    pageViewController =
        PageController(initialPage: ((sliders?.length ?? 1) - 1));
    currentIndex = ((sliders?.length ?? 1) - 1);
    await Future.delayed(const Duration(seconds: 1));
    String? userType = await LocalStorageHelper.checkUserType();
    if (userType == '1') {
      if (await LocalStorageHelper.checkTeacherIsLoggedIn()) {
        var teacher = await LocalStorageHelper.getTeacherData();
        Get.put(LoginController()).makeLoginTeacher(teacher.info?.token ?? "",null);
      }else{
        Get.offAll(const LoginScreen());
      }
    } else if (userType == '2') {
      if (await LocalStorageHelper.checkStudentIsLoggedIn()) {
        var student = await LocalStorageHelper.getStudentData();
        Get.put(LoginController())
            .makeRegisterStudent(student.profile?.token ?? "",null);
      }else{
        Get.offAll(const LoginScreen());
      }
    } else {
      if (sliders?.isNotEmpty ?? false) {
        if (await LocalStorageHelper.skipLandingPage()) {
          Get.offAll(const LoginScreen());
        } else {
          Get.offAll(const LandingScreen());
        }
      }
    }
  }
}
