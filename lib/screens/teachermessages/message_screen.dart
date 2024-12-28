import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sulok/constant/app_colors.dart';
import 'package:sulok/constant/app_images.dart';
import 'package:sulok/constant/const_var.dart';
import 'package:sulok/helper/custom/custom_text.dart';
import 'package:sulok/helper/custom/custom_text_feild.dart';
import 'package:sulok/helper/local_storage_helper.dart';
import 'package:sulok/screens/login/model/login_teacher_respone.dart';
import 'package:sulok/screens/login/model/shi5_messages_response.dart';
import 'package:sulok/screens/teachermessages/send_message_controller.dart';
import 'package:sulok/screens/teachermessages/teacher_message_controller.dart';
import 'package:sulok/screens/teachermessages/teacher_messages_repo.dart';
import '../login/model/student_response.dart';
import '../studentmessages/message_screen.dart';

class TeacherMessageScreen extends StatefulWidget {
  final Shi5MsgResponse messageData;

  const TeacherMessageScreen({Key? key, required this.messageData})
      : super(key: key);

  @override
  State<TeacherMessageScreen> createState() => _TeacherMessageScreenState();
}

class _TeacherMessageScreenState extends State<TeacherMessageScreen> {
  late LoginTeacherResponse shi5Data;
  final TeacherMessagesRepo repo = TeacherMessagesRepo();
  final scrollController = ScrollController();
  late List<Shi5MsgResponse> msgs;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    shi5Data = await LocalStorageHelper.getTeacherData();
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
                        Expanded(
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
                                child: CustomText(
                                    "رسالة من : ${widget.messageData.salik?.name}",
                                    color: AppColors.whiteGrey,
                                    size: 20),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: true,
                          child: InkWell(
                            onTap: () {
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: AppColors.whiteGrey)),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.refresh,
                                  color: AppColors.whiteGrey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
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
                child: GetBuilder<TeacherSendMessageController>(
                    init: TeacherSendMessageController(),
                    builder: (controller) {
                      return FutureBuilder<List<Shi5MsgResponse>>(
                          future: repo.getAllMsgShi5(
                              widget.messageData.cityhallId.toString(),
                              widget.messageData.from),
                          initialData: const [],
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.greenMain,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return const Text('Error loading messages');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Text('No messages found');
                            } else {
                              msgs = snapshot.data!;
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
                                      final Shi5MsgResponse msg = msgs[index];
                                      return messageBox(
                                        MessageData(
                                            name: msg.name,
                                            msg: msg.msg,
                                            createdAt: msg.createdAt,
                                            from: msg.from),
                                        msg.status == "sent",
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
                  init: TeacherSendMessageController(),
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
                                    await controller.sendMessage(
                                        widget.messageData.salikId.toString());
                                    // msgs.insert(
                                    //   0,
                                    //   Shi5MsgResponse(
                                    //     name: "User",
                                    //     from: shi5Data.info?.id.toString(),
                                    //     to: widget.messageData.salikId,
                                    //     msg:
                                    //         controller.myMessageController.text,
                                    //     createdAt: DateTime.now(),
                                    //   ),
                                    // );
                                    //setState(() {});
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
      {bool? isNew, required TeacherMessagesController controller}) {
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
