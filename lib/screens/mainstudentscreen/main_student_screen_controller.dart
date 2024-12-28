import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sulok/constant/const_var.dart';
import 'package:sulok/helper/custom/custom_loading.dart';
import 'package:sulok/screens/mainstudentscreen/student_main_repo.dart';

import '../../helper/helper_functions.dart';
import '../login/login_repo.dart';

class MainStudentScreenController extends GetxController {
  List<DateTime> days = [];
  StudentMainRepo studentMainRepo = StudentMainRepo();
  int currentIndex = 2;

  @override
  void onInit() {
    // TODO: implement onInit
    DateTime today = DateTime.now();

    // Calculate the previous two days
    DateTime previousDay1 = today.subtract(const Duration(days: 2));
    DateTime previousDay2 = today.subtract(const Duration(days: 1));

    // Calculate the next two days
    DateTime nextDay1 = today.add(const Duration(days: 1));
    DateTime nextDay2 = today.add(const Duration(days: 2));

    // Create a list of the dates
    days = [previousDay1, previousDay2, today, nextDay1, nextDay2];

    // Format the dates as strings (optional)
    update();
    super.onInit();
  }

  refreshStudentData() async {
    await LoginRepo().refreshStudentData().then((value) async {
      update();
    });
  }

  complete(String id, {String? count}) async {
    loading();
    studentMainRepo.taskComplete(id, count: count).then((value) async {
      if (value.msgNum != 0) {
        await refreshStudentData();
        closeLoading();
        refreshStudentData();
        Get.back();
      }
      HelperFun.showToast(value.msg ?? "غير مكتمل", success: value.msgNum != 0);
    });
  }

  unComplete(String id) async {
    loading();

    studentMainRepo.taskUnComplete(id).then((value) async {
      if (value.msgNum != 0) {
        await refreshStudentData();
        closeLoading();
        refreshStudentData();
        Get.back();
      }
      HelperFun.showToast(value.msg ?? "", success: value.msgNum != 0);
    });
  }
}
