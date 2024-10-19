import 'package:get/get.dart';
import 'package:sulok/screens/studentmessages/student_messages_repo.dart';

import '../../helper/custom/custom_loading.dart';
import '../login/login_repo.dart';
import '../mainstudentscreen/main_student_screen_controller.dart';

class StudentMessagesController extends GetxController {
  MessagesRepo messagesRepo = MessagesRepo();

  @override
  onInit() async {
    var mainController = Get.find<MainStudentScreenController>();
    await mainController.refreshStudentData();
    update();
    super.onInit();
  }

  makeReadMessage(String id) async {
    await messagesRepo.readMessageAPI({'msgid': id}).then((value) async {
      if (value.msgNum != 0) {
        var mainController = Get.find<MainStudentScreenController>();
        await mainController.refreshStudentData();
        update();
      }
    });
  }

  makeDeleteMessage(String id) async {
    Get.back();
    loading();
    await messagesRepo.deleteMessage(id).then((value) async {
      if (value.msgNum != 0) {
        await LoginRepo().refreshStudentData();

        update();
      }
    });
    closeLoading();
    update();
  }

  makeAllDeleteMessage() async {
    Get.back();
    loading();

    await messagesRepo.deleteMessage('all').then((value) async {
      if (value.msgNum != 0) {
        await LoginRepo().refreshStudentData();

        update();
      }
    });
    closeLoading();
    update();
  }

  makeDeleteNotification(String id) async {
    Get.back();
    loading();
    await messagesRepo.deleteNotifications(id).then((value) async {
      if (value.msgNum != 0) {
        await LoginRepo().refreshStudentData();

        update();
      }
    });
    closeLoading();
    update();
  }

  makeAllDeleteNotifications() async {
    Get.back();
    loading();
    await messagesRepo.deleteNotifications(null).then((value) async {
      LoginRepo().refreshStudentData();
      if (value.msgNum != 0) {
        await LoginRepo().refreshStudentData();

        update();
      }
    });
    closeLoading();
    update();
  }
}
