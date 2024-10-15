import 'package:get/get.dart';
import 'package:sulok/helper/custom/custom_loading.dart';
import 'package:sulok/screens/teachermessages/teacher_messages_repo.dart';

import '../login/login_repo.dart';

class TeacherMessagesController extends GetxController {
  TeacherMessagesRepo messagesRepo = TeacherMessagesRepo();

  @override
  onInit() async {
    await LoginRepo().refreshTeacherData();
    update();
    super.onInit();
  }

  makeReadMessage(String id) async {
    await messagesRepo.readMessageAPI({'msgid': id}).then((value) async {
      if (value.msgNum != 0) {
        await LoginRepo().refreshTeacherData();

        update();
      }
    });
  }

  makeDeleteMessage(String id) async {
    Get.back();
    loading();

    await messagesRepo.deleteMessage(id).then((value) async {
      if (value.msgNum != 0) {
        await LoginRepo().refreshTeacherData();

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
        await LoginRepo().refreshTeacherData();

        update();
      }
    });
    closeLoading();
    update();
  }
}
