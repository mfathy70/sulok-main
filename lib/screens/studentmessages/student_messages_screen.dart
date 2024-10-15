import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sulok/constant/app_images.dart';
import 'package:sulok/constant/const_var.dart';
import 'package:sulok/helper/custom/custom_text_feild.dart';
import 'package:sulok/helper/local_storage_helper.dart';
import 'package:sulok/screens/login/model/messages_response.dart';
import 'package:sulok/screens/studentmessages/send_message_controller.dart';
import 'package:sulok/screens/studentmessages/student_message_controller.dart';
import 'package:sulok/screens/studentmessages/student_messages_repo.dart';
import '../../constant/app_colors.dart';
import '../../helper/custom/custom_text.dart';
import '../login/model/student_response.dart';
import 'message_screen.dart';

class StudentMessagesScreen extends StatefulWidget {
  const StudentMessagesScreen({Key? key}) : super(key: key);

  @override
  State<StudentMessagesScreen> createState() => _StudentMessagesScreenState();
}

class _StudentMessagesScreenState extends State<StudentMessagesScreen> {
  late StudentResponse studentData;
  final StreamController<List<MsgResponse>> _controllerMsg =
      StreamController<List<MsgResponse>>.broadcast();
  final scrollController = ScrollController();
  late List<MsgResponse> msgs;

  @override
  void initState() {
    super.initState();
    getMsg();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
    _controllerMsg.close();
  }

  void getMsg() async {
    final MessagesRepo repo = MessagesRepo();
    msgs = await repo.getAllMsg();
    _controllerMsg.add(msgs);
  }

  void getData() async {
    studentData = await LocalStorageHelper.getStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteGrey,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.greenMain,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
              ),
              child: Visibility(
                  visible: true,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Row(
                            children: [
                              // Visibility(
                              //     visible: leading != null,
                              //     child: Padding(
                              //       padding:
                              //           const EdgeInsets.symmetric(horizontal: 8.0),
                              //       child: leading ?? const SizedBox(),
                              //     )),
                              Expanded(
                                child: CustomText("الرسائل",
                                    color: AppColors.whiteGrey, size: 25),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: true,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: AppColors.whiteGrey)),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColors.whiteGrey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.whiteGrey,
                ),
                child: GetBuilder<StudentMessagesController>(
                    init: StudentMessagesController(),
                    builder: (controller) {
                      return StreamBuilder<List<MsgResponse>>(
                          stream: _controllerMsg.stream,
                          initialData: const [],
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                color: AppColors.greenMain,
                              ));
                            } else if (snapshot.hasError) {
                              return const Text('Error loading messages');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Text('No messages found');
                            } else {
                              List<MsgResponse> msgs = snapshot.data!;
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: ShaderMask(
                                  shaderCallback: (Rect rect) {
                                    return const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.green,
                                        Colors.transparent,
                                        Colors.transparent,
                                        Colors.transparent,
                                      ],
                                      stops: [
                                        0.0,
                                        0.1,
                                        0.9,
                                        1.0
                                      ], // 10% purple, 80% transparent, 10% purple
                                    ).createShader(rect);
                                  },
                                  blendMode: BlendMode.dstOut,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    reverse: true,
                                    itemCount: msgs.length,
                                    controller: scrollController,
                                    itemBuilder: (context, index) {
                                      final MsgResponse msg = msgs[index];
                                      return messageBox(
                                        MessageData(
                                            name: msg.name,
                                            msg: msg.msg,
                                            createdAt: msg.createdAt,
                                            from: msg.from),
                                        msg.from ==
                                            studentData.profile?.id.toString(),
                                      );
                                    },
                                  ),
                                ),
                              );
                            }
                          });
                    }),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: AppColors.greenMain,
              ),
              child: GetBuilder(
                  init: SendMessageController(),
                  builder: (controller) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
                      child: Column(
                        children: [
                          // CustomTextField(
                          //   controller: controller.messageTitle,
                          //   hintText: 'عنوان الرسالة..',
                          //   suffixIcon: const SizedBox(),
                          // ),
                          CustomTextField(
                            controller: controller.myMessageController,
                            hintText: ' الرسالة..',
                            maxLines: 3,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                  onTap: () async {
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);
                                    if (!currentFocus.hasPrimaryFocus &&
                                        currentFocus.focusedChild != null) {
                                      FocusManager.instance.primaryFocus!
                                          .unfocus();
                                    }
                                    controller.sendMessage(
                                        studentData.profile!.shi5Id.toString());
                                    msgs.insert(
                                      0,
                                      MsgResponse(
                                        name: "User",
                                        from:
                                            studentData.profile?.id.toString(),
                                        to: studentData.profile?.shi5Id,
                                        msg:
                                            controller.myMessageController.text,
                                        createdAt: DateTime.now(),
                                      ),
                                    );
                                    setState(() {
                                      _controllerMsg.sink.add(msgs);
                                    });
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
                    );
                  }),
            ),
          ],
        ),
      ),
    );
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

  cardWidget(MessageData? messageData,
      {bool? isNew, required StudentMessagesController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17.0),
      child: InkWell(
        onTap: () {
          if (isNew == true) {
            controller.makeReadMessage(messageData?.id.toString() ?? "");
          }
          Get.to(MessageScreen(
            messageData: messageData!,
          ));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 5,
                  height: 60,
                  color: AppColors.amberSecond,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      messageData?.name ?? '',
                      fontWeight: FontWeight.bold,
                      size: 17,
                    ),
                    CustomText(
                      messageData?.from ?? "",
                      fontWeight: FontWeight.normal,
                      size: 12,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppImages.messages,
                      color: isNew == true
                          ? AppColors.amberSecond
                          : AppColors.greyDark,
                      height: 25,
                    ),
                    CustomText(
                      ConstVars.timeAgo(messageData?.createdAt),
                      fontWeight: FontWeight.normal,
                      size: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
