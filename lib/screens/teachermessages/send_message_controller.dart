import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sulok/helper/custom/custom_loading.dart';
import 'package:sulok/screens/login/model/student_response.dart';
import 'package:sulok/screens/teachermessages/teacher_messages_repo.dart';

class TeacherSendMessageController extends GetxController {
  MessageData? myMessage;
  TextEditingController myMessageController = TextEditingController();
  TextEditingController messageTitle = TextEditingController();
  TeacherMessagesRepo teacherMessagesRepo = TeacherMessagesRepo();

  Future<void> sendMessage(String id) async {
    //Get.back();
    //loading();
    await teacherMessagesRepo.sendMessage({
      'name': myMessageController.text,
      'msg': myMessageController.text,
      'to': '{"to":[$id]}'
    });
    messageTitle.clear();
    myMessageController.clear();
    update();
    //closeLoading();
  }
}
