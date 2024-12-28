import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sulok/helper/custom/custom_loading.dart';
import 'package:sulok/screens/login/model/student_response.dart';
import 'package:sulok/screens/studentmessages/student_messages_repo.dart';

class SendMessageController extends GetxController {
  MessageData? myMessage;
  TextEditingController myMessageController = TextEditingController();
  TextEditingController messageTitle = TextEditingController();
  MessagesRepo studentMessagesRepo = MessagesRepo();

  Future<void> sendMessage(String id) async {
    //Get.back();
    //loading();
    // myMessage = MessageData(
    //   msg: myMessageController.text,
    //   name: messageTitle.text,
    //   createdAt: DateTime.now(),
    // );
    await studentMessagesRepo.sendMessage({
      'name': myMessageController.text, //messageTitle.text,
      'msg': myMessageController.text,
      'to': '{"to":[$id]}'
    });
    messageTitle.clear();
    myMessageController.clear();
    update();
    //closeLoading();
  }
}
