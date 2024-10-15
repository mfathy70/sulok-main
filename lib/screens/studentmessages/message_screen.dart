import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sulok/constant/app_colors.dart';
import 'package:sulok/constant/const_var.dart';
import 'package:sulok/helper/custom/custom_text.dart';
import 'package:sulok/helper/custom/custom_text_feild.dart';
import 'package:sulok/helper/custom/default_screen.dart';
import 'package:sulok/helper/local_storage_helper.dart';
import 'package:sulok/screens/login/model/student_response.dart';
import 'package:sulok/screens/studentmessages/send_message_controller.dart';

class MessageScreen extends StatefulWidget {
  final MessageData messageData;

  const MessageScreen({Key? key, required this.messageData}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late StudentResponse studentData;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    studentData = await LocalStorageHelper.getStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
        resizeToAvoidBottomInset: true,
        title: 'رسالة من : ${widget.messageData.from}',
        onTapBack: () {
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10),
          child: GetBuilder<SendMessageController>(
              init: SendMessageController(),
              builder: (controller) {
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    messageBox(widget.messageData, false),
                    //messageBox(messageData, true),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: controller.messageTitle,
                            hintText: 'عنوان الرسالة..',
                            suffixIcon: const SizedBox(),
                          ),
                          CustomTextField(
                            controller: controller.myMessageController,
                            hintText: ' الرسالة..',
                            maxLines: 3,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                  onTap: () {
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);
                                    if (!currentFocus.hasPrimaryFocus &&
                                        currentFocus.focusedChild != null) {
                                      FocusManager.instance.primaryFocus!
                                          .unfocus();
                                    }
                                    controller.sendMessage(
                                        studentData.profile!.shi5Id.toString());
                                  },
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.greenMain),
                                      child: const AnimatedRotation(
                                          turns: 0.10,
                                          duration: Duration(milliseconds: 1),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.send_rounded,
                                                color: AppColors.white,
                                                size: 15),
                                          )))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ));
  }

  Widget messageBox(MessageData messageData, bool fromME) {
    return Row(
      mainAxisAlignment:
          fromME ? MainAxisAlignment.start : MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: Get.width / 1.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment:
                fromME ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: fromME ? AppColors.greenMain : AppColors.amberSecond,
                    borderRadius: BorderRadius.only(
                      topLeft: fromME
                          ? const Radius.circular(18)
                          : const Radius.circular(0),
                      topRight: fromME
                          ? const Radius.circular(0)
                          : const Radius.circular(18),
                      bottomLeft: const Radius.circular(18),
                      bottomRight: const Radius.circular(18),
                    ),
                  ),
                  child: CustomText(
                    messageData.msg ?? "",
                    color: AppColors.white,
                  )),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CustomText(
                  ConstVars.timeAgo(messageData.createdAt),
                  color: AppColors.grey,
                  size: 10,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
