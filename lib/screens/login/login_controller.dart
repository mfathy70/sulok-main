import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sulok/constant/global_functions.dart';
import 'package:sulok/helper/custom/custom_loading.dart';
import 'package:sulok/helper/local_storage_helper.dart';
import 'package:sulok/screens/login/login_repo.dart';
import 'package:sulok/screens/login/login_screen.dart';
import 'package:sulok/screens/login/model/login_request.dart';
import 'package:sulok/screens/login/model/login_teacher_respone.dart';
import 'package:sulok/screens/mainteacher/main_teacer_screen.dart';

import '../../helper/helper_functions.dart';
import '../completestudent/complete_student_screen.dart';
import '../mainstudentscreen/main_student_screen.dart';
import 'otp_screen.dart';

class LoginController extends GetxController {
  Country? selectedCountry = CountryService().findByCode('SA');
  String smsCode = '';
  String verificationId = '';
  TextEditingController phoneController = TextEditingController();

  var isTeacher = false;

  String getFullPhoneNumber() {
    if (phoneController.text.isEmpty) return '';
    return '+${selectedCountry?.phoneCode ?? ""}${phoneController.text}';
  }

  confirmCode() async {
    // Create a PhoneAuthCredential with the code
    loading();
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      // Sign the user in (or link) with the credential
      var firebaseUser =
          await FirebaseAuth.instance.signInWithCredential(credential);
      closeLoading();
      if (isTeacher) {
        await makeLoginTeacher(
            firebaseUser.user?.uid ?? "", firebaseUser.user?.phoneNumber ?? "");
      } else {
        await makeRegisterStudent(
            firebaseUser.user?.uid ?? "", firebaseUser.user?.phoneNumber ?? "");
      }
    } catch (e) {
      closeLoading();
      HelperFun.showToast('الرمز المدخل غير صحيح');
    }
  }

  submit() async {
    loading();
    securePrint(getFullPhoneNumber());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: getFullPhoneNumber(),
      verificationCompleted: (PhoneAuthCredential credential) async {
        //login
        var firebaseUser =
            await FirebaseAuth.instance.signInWithCredential(credential);
        closeLoading();
        if (isTeacher) {
          await makeLoginTeacher(firebaseUser.user?.uid ?? "",
              firebaseUser.user?.phoneNumber ?? "");
        } else {
          await makeRegisterStudent(firebaseUser.user?.uid ?? "",
              firebaseUser.user?.phoneNumber ?? "");
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        closeLoading();
        HelperFun.showToast(e.message ?? "");
      },
      codeSent: (String verificationId, int? resendToken) async {
        this.verificationId = verificationId;
        closeLoading();
        Get.offAll(const OTPScreen());
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
    );
  }

  makeRegisterStudent(String? token, String? phone) async {
    loading();
    LoginRequest loginRequest = LoginRequest(
        phone: phone,
        token: token,
        tokenfcm: await FirebaseMessaging.instance.getToken());
    LoginRepo().studentRegisterAPI(loginRequest).then((value) async {
      closeLoading();
      if (value.profile?.name?.isNotEmpty ?? false) {
        await LocalStorageHelper.saveStudentData(value);
        Get.offAll(const MainStudentScreen());
      } else if (value.msgNum == 55) {
        Get.to(const CompleteStudentScreen());
      }
      // else {
      //   await HelperFun.showToast(value.msg ?? "");
      //   Get.offAll(const LoginScreen());
      // }
    });
  }

  makeLoginTeacher(String token, String? phone) async {
    loading();
    LoginRequest loginRequest = LoginRequest(
        phone: phone,
        token: token,
        tokenfcm: await FirebaseMessaging.instance.getToken());
    LoginRepo().loginRequestAPI(loginRequest).then((value) async {
      closeLoading();
      if (value.msgNum != 0) {
        await LocalStorageHelper.saveTeacherData(value);
        Get.offAll(const MainTeacherScreen());
      } else {
        await HelperFun.showToast(value.msg ?? "");
        Get.offAll(const LoginScreen());
      }
    });
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }
}
