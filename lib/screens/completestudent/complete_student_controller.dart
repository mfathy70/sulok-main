import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:sulok/helper/custom/custom_drop_down.dart';
import 'package:sulok/helper/custom/custom_loading.dart';
import 'package:sulok/helper/local_storage_helper.dart';
import 'package:sulok/network/api_response_model.dart';
import 'package:sulok/screens/completestudent/model/complete_student_request.dart';
import 'package:sulok/screens/login/login_controller.dart';
import 'package:sulok/screens/login/login_screen.dart';
import 'package:sulok/screens/login/model/student_response.dart';

import '../../helper/countries_json.dart';
import '../../helper/helper_functions.dart';
import '../mainstudentscreen/main_student_screen.dart';
import 'complete_data_repo.dart';

class CompleteStudentController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController universityID = TextEditingController();
  TextEditingController programName = TextEditingController();
  TextEditingController numberOfChild = TextEditingController();
  TextEditingController teacherName = TextEditingController();
  final bool? updateData;
  DateTime? birthData;

  Item selectedGender = Item(name: 'ذكر', id: '1');
  Item selectedSocial = Item(name: 'اعزب', id: '2');
  Item selectedEducation = Item(name: 'التعليم الجامعي', id: '4');
  Country? selectedCountry;

  bool areYouStudied = false;
  bool youHaveTeacher = false;
  StudentResponse? studentResponse;

  CompleteStudentController(this.updateData);

  submit() async {
    loading();
    CompleteStudentRequest completeStudentRequest = CompleteStudentRequest(
        name: fullName.text,
        email: email.text,
        course: programName.text,
        dateBirth: birthData != null
            ? DateFormat('yyyy-MM-dd').format(birthData!)
            : "",
        educational: selectedEducation.name,
        forensicStudies: areYouStudied ? 'yes' : 'no',
        marital: selectedSocial.name,
        numberChildren: numberOfChild.text,
        residence: selectedCountry?.name,
        sex: selectedGender.name,
        sheikhEducation: youHaveTeacher ? "yes" : "no",
        sheikhName: teacherName.text,
        teacherCode: code.text,
        universityNumber: universityID.text,
        token: FirebaseAuth.instance.currentUser?.uid);
    ApiResponseModel apiResponseModel =
        await CompleteDataRepo().completeStudentData(completeStudentRequest);
    closeLoading();
    await HelperFun.showToast(apiResponseModel.msg ?? "",
        success: apiResponseModel.msgNum != 0);

    if (apiResponseModel.msgNum == 1) {
      Get.put(LoginController()).makeRegisterStudent(
          FirebaseAuth.instance.currentUser?.uid ?? "",
          FirebaseAuth.instance.currentUser?.phoneNumber);
      Get.offAll(const MainStudentScreen());
    } else if (apiResponseModel.msgNum == 0) {
      Get.offAll(const LoginScreen());
      await HelperFun.showToast(apiResponseModel.msg ?? "");
    } else {
      await HelperFun.showToast(apiResponseModel.msg ?? "");
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    if (updateData == true) {
      //   name: fullName.text,
      // email: email.text,
      // course: programName.text,
      // dateBirth: birthData?.toIso8601String(),
      // educational: selectedEducation.name,
      // forensicStudies: areYouStudied ? 'yes' : 'no',
      // marital: selectedSocial.name,
      // numberChildren: numberOfChild.text,
      // residence: selectedCountry?.name,
      // sex: selectedGender.name,
      // sheikhEducation: youHaveTeacher ? "yes" : "no",
      // sheikhName: teacherName.text,
      // teacherCode: code.text,
      // universityNumber: universityID.text,
      studentResponse = await LocalStorageHelper.getStudentData();
      email.text = studentResponse?.profile?.email ?? "";
      code.text = studentResponse?.profile?.cityhallId ?? "";
      universityID.text = studentResponse?.profile?.universityNumber ?? "";
      programName.text = studentResponse?.profile?.course ?? "";
      fullName.text = studentResponse?.profile?.name ?? "";
      selectedGender.name = studentResponse?.profile?.sex ?? "";
      selectedCountry = Country(
          phoneCode: '',
          countryCode: '',
          e164Sc: 0,
          geographic: false,
          level: 0,
          name: studentResponse?.profile?.residence ?? "",
          example: '',
          displayName: '',
          displayNameNoCountryCode: '',
          e164Key: '');
      selectedSocial.name = studentResponse?.profile?.marital ?? "";
      numberOfChild.text = studentResponse?.profile?.numberChildren ?? "";
      areYouStudied =
          (studentResponse?.profile?.forensicStudies ?? "") == 'yes';
      selectedEducation.name = studentResponse?.profile?.educational ?? "";
      youHaveTeacher =
          (studentResponse?.profile?.sheikhEducation ?? "") == 'yes';
      teacherName.text = studentResponse?.profile?.sheikhName ?? "";
      try {
        birthData = DateFormat('yyyy-MM-dd')
            .parse(studentResponse?.profile?.dateBirth ?? "");
      } catch (e) {}
    }
    update();
    super.onInit();
  }

  void deleteAccount() async {
    await CompleteDataRepo()
        .deleteMyAccount()
        .then((value) => LocalStorageHelper.logOut());
  }
}
