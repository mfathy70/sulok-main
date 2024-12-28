import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sulok/constant/app_images.dart';
import 'package:sulok/constant/const_var.dart';
import 'package:sulok/helper/custom/default_screen.dart';
import 'package:sulok/screens/login/model/login_teacher_respone.dart';
import 'package:sulok/screens/login/model/shi5_messages_response.dart';
import 'package:sulok/screens/teachermessages/teacher_message_controller.dart';
import 'package:sulok/screens/teachermessages/teacher_messages_repo.dart';
import '../../constant/app_colors.dart';
import '../../helper/custom/custom_text.dart';
import '../login/model/student_response.dart';
import 'message_screen.dart';

class TeacherMessagesScreen extends StatefulWidget {
  final LoginTeacherResponse teacher;
  const TeacherMessagesScreen({Key? key, required this.teacher})
      : super(key: key);

  @override
  State<TeacherMessagesScreen> createState() => _TeacherMessagesScreenState();
}

class _TeacherMessagesScreenState extends State<TeacherMessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      headerWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                const CustomText('الرسائل',
                    color: AppColors.whiteGrey, size: 25),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.whiteGrey)),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.whiteGrey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const CustomText(
              'يصلك كل يوم رساله على الأقل من ضمن برنامج الإشراف التربوي - خدمات الموقع',
              color: AppColors.white,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: GetBuilder<TeacherMessagesController>(
            init: TeacherMessagesController(),
            builder: (controller) {
              return FutureBuilder(
                  future: TeacherMessagesRepo()
                      .getAllMsgShi5(widget.teacher.info?.id.toString(), null),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Shi5MsgResponse>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CupertinoActivityIndicator();
                    }
                    var messages = snapshot.data;
                    var filteredList = [];
                    if (messages != null) {
                      final filteredMap = <String, Shi5MsgResponse>{};
                      for (var msg in messages.reversed) {
                        if (msg.salikId != null) {
                          filteredMap[msg.salikId!] = msg;
                        }
                      }
                      filteredList = filteredMap.values.toList();
                    }
                    return Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        children: [
                          if (filteredList.isEmpty)
                            const Padding(
                              padding: EdgeInsets.all(30.0),
                              child: CustomText('لايوجد عناصر يمكن عرضها',
                                  color: AppColors.greenMain,
                                  fontWeight: FontWeight.bold,
                                  size: 30),
                            ),
                          RefreshIndicator(
                            child: ListView.builder(
                              padding: const EdgeInsets.all(0),
                              shrinkWrap: true,
                              itemCount: filteredList.length,
                              itemBuilder: (context, index) {
                                return cardWidget(filteredList[index],
                                    controller: controller);
                              },
                            ),
                            onRefresh: () async {
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    );
                  });
            }),
      ),
    );
  }

  cardWidget(Shi5MsgResponse? messageData,
      {bool? isNew, required TeacherMessagesController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17.0),
      child: InkWell(
        onTap: () {
          if (isNew == true) {
            controller.makeReadMessage(messageData?.id.toString() ?? "");
          }
          Get.to(TeacherMessageScreen(
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
                      messageData?.salik?.name ?? '',
                      fontWeight: FontWeight.bold,
                      size: 17,
                    ),
                    CustomText(
                      messageData?.msg ?? "",
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
