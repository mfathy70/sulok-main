import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sulok/constant/app_images.dart';
import 'package:sulok/constant/const_var.dart';
import 'package:sulok/helper/custom/custom_button.dart';
import 'package:sulok/helper/custom/default_screen.dart';

import '../../constant/app_colors.dart';
import '../../helper/custom/custom_text.dart';
import '../../helper/custom/white_screen.dart';
import '../../helper/local_storage_helper.dart';
import '../login/model/student_response.dart';
import '../studentmessages/student_message_controller.dart';

class StudentNotificationScreen extends StatelessWidget {
  const StudentNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentMessagesController>(
        init: StudentMessagesController(),
        builder: (controller) {
          return FutureBuilder(
              future: LocalStorageHelper.getStudentData(),
              builder: (BuildContext context,
                  AsyncSnapshot<StudentResponse> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CupertinoActivityIndicator();
                }
                var notifications = snapshot.data?.notification;
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
                            const CustomText('التنبيهات',
                                color: AppColors.whiteGrey, size: 25),
                            InkWell(
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
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomButton(
                            color: notifications?.isEmpty ?? true
                                ? AppColors.grey
                                : AppColors.amberSecond,
                            title: 'حذف جميع التنبيهات',
                            pressed: (notifications?.isEmpty ?? true)
                                ? () {}
                                : () {
                                    Get.dialog(AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 5,
                                            height: 70,
                                            color: AppColors.amberSecond,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Expanded(
                                              child: CustomText(
                                                  'هل انت متاكد من حذف جميع التنبيهات')),
                                        ],
                                      ),
                                      actions: [
                                        MaterialButton(
                                          onPressed: () {
                                            controller
                                                .makeAllDeleteNotifications();
                                          },
                                          child: const CustomText(
                                            "حذف",
                                            color: Colors.red,
                                          ),
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            Get.back();
                                            controller.update();
                                          },
                                          child: const CustomText("الغاء"),
                                        ),
                                      ],
                                    ));
                                  })
                      ],
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: [
                        if (notifications?.isEmpty ?? true)
                          const Padding(
                            padding: EdgeInsets.all(30.0),
                            child: CustomText('لايوجد عناصر يمكن عرضها',
                                color: AppColors.greenMain,
                                fontWeight: FontWeight.bold,
                                size: 30),
                          ),
                        for (var i in notifications ?? [])
                          Dismissible(
                              key: Key(i?.id.toString() ?? ""),
                              background: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        'حذف',
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                        size: 20,
                                      ),
                                      CustomText(
                                        'حذف',
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onDismissed: (v) {
                                Get.dialog(AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 5,
                                        height: 70,
                                        color: AppColors.amberSecond,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          child: CustomText(
                                              'هل انت متاكد من حذف ${i?.name}')),
                                    ],
                                  ),
                                  actions: [
                                    MaterialButton(
                                      onPressed: () {
                                        controller.makeDeleteNotification(
                                            i?.id.toString() ?? "");
                                      },
                                      child: const CustomText(
                                        "حذف",
                                        color: Colors.red,
                                      ),
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        Get.back();
                                        controller.update();
                                      },
                                      child: const CustomText("الغاء"),
                                    ),
                                  ],
                                ));
                              },
                              child: cardWidget(i))
                      ],
                    ),
                  ),
                );
              });
        });
  }

  Widget cardWidget(NotificationModel? notificationModel) {
    return StatefulBuilder(builder: (context, update) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 17.0),
        child: InkWell(
          onTap: () {
            notificationModel?.isOpen = !(notificationModel.isOpen ?? false);
            update(() {});
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.white,
            ),
            child: Column(
              children: [
                Row(
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
                            notificationModel?.name ?? "",
                            fontWeight: FontWeight.bold,
                            size: 17,
                          ),
                          CustomText(
                            notificationModel?.from ?? "",
                            fontWeight: FontWeight.normal,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppImages.bell),
                        CustomText(
                          ConstVars.timeAgo(
                              notificationModel?.createdAt ?? DateTime.now()),
                          fontWeight: FontWeight.normal,
                          size: 10,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                Visibility(
                  visible: notificationModel?.isOpen ?? false,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      notificationModel?.msg ?? "",
                      fontWeight: FontWeight.normal,
                      size: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
