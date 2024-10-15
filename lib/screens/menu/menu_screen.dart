import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sulok/constant/app_images.dart';
import 'package:sulok/helper/custom/custom_text.dart';
import 'package:sulok/screens/studentmessages/student_messages_screen.dart';
import 'package:sulok/screens/studentnotification/student_notification_screen.dart';
import 'package:sulok/screens/teachermessages/teacher_messages_screen.dart';
import 'package:sulok/screens/teachernotification/teacher_notification_screen.dart';

import '../../constant/app_colors.dart';
import '../../helper/local_storage_helper.dart';
import '../../teacherprofile/teacher_profile.dart';
import '../completestudent/complete_student_screen.dart';
import '../login/model/login_teacher_respone.dart';
import '../login/model/student_response.dart';

class MenuScreen extends StatelessWidget {
  final bool isTeacher;

  const MenuScreen({Key? key, required this.isTeacher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Visibility(
              visible: !isTeacher,
              child: Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(30),
                  child: FutureBuilder(
                      future: LocalStorageHelper.getStudentData(),
                      builder: (BuildContext context,
                          AsyncSnapshot<StudentResponse> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CupertinoActivityIndicator();
                        }
                        var student = snapshot.data;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(const CompleteStudentScreen(
                                          updateData: true,
                                        ));
                                      },
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.grey,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomText(
                                      student?.profile?.name ?? "",
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white,
                                      size: 17,
                                    ),
                                    CustomText(
                                      student?.profile?.educational ?? "",
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.white,
                                      size: 14,
                                    )
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: AppColors.whiteDark,
                                      size: 30,
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppImages.home),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  const CustomText(
                                    'الرئيسية',
                                    fontWeight: FontWeight.bold,
                                    size: 16,
                                    color: AppColors.white,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(const StudentMessagesScreen());
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        AppImages.messages,
                                        color: AppColors.whiteDark,
                                      ),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                      CustomText(
                                        'الرسائل',
                                        fontWeight: FontWeight.bold,
                                        size: 16,
                                        color: AppColors.whiteDark,
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    visible: student!
                                            .message?.messageNew?.isNotEmpty ??
                                        false,
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.amberSecond),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(const StudentNotificationScreen());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppImages.bell,
                                    color: AppColors.whiteDark,
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  CustomText(
                                    'التنبيهات',
                                    fontWeight: FontWeight.bold,
                                    size: 16,
                                    color: AppColors.whiteDark,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(const CompleteStudentScreen(
                                  updateData: true,
                                ));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppImages.user,
                                    color: AppColors.whiteDark,
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  CustomText(
                                    'الملف الشخصي',
                                    fontWeight: FontWeight.bold,
                                    size: 16,
                                    color: AppColors.whiteDark,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                LocalStorageHelper.logOut();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppImages.logout,
                                    color: AppColors.whiteDark,
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  CustomText(
                                    'تسجيل الخروج',
                                    fontWeight: FontWeight.bold,
                                    size: 16,
                                    color: AppColors.whiteDark,
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ),
            ),
            Visibility(
              visible: isTeacher,
              child: Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(30),
                  child: FutureBuilder(
                      future: LocalStorageHelper.getTeacherData(),
                      builder: (BuildContext context,
                          AsyncSnapshot<LoginTeacherResponse> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CupertinoActivityIndicator();
                        }
                        var teacher = snapshot.data;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(const TeacherProfile());
                                      },
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.grey,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomText(
                                      teacher?.info?.name ?? "",
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white,
                                      size: 17,
                                    ),
                                    // CustomText(
                                    //   teacher?.info?.description ?? "",
                                    //   maxLines: 2,
                                    //   fontWeight: FontWeight.normal,
                                    //   color: AppColors.white,
                                    //   size: 14,
                                    // ),
                                    // CustomText(
                                    //   teacher?.info?.phone ?? "",
                                    //   fontWeight: FontWeight.normal,
                                    //   color: AppColors.white,
                                    //   size: 14,
                                    // ),
                                    CustomText(
                                      teacher?.info?.code ?? "",
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.amberSecond,
                                      size: 14,
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: AppColors.whiteDark,
                                      size: 30,
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppImages.home),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  const CustomText(
                                    'الرئيسية',
                                    fontWeight: FontWeight.bold,
                                    size: 16,
                                    color: AppColors.white,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(TeacherMessagesScreen(
                                  teacher: teacher!,
                                ));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppImages.messages,
                                    color: AppColors.whiteDark,
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  CustomText(
                                    'الرسائل',
                                    fontWeight: FontWeight.bold,
                                    size: 16,
                                    color: AppColors.whiteDark,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(const TeacherNotificationScreen());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppImages.bell,
                                    color: AppColors.whiteDark,
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  CustomText(
                                    'التنبيهات',
                                    fontWeight: FontWeight.bold,
                                    size: 16,
                                    color: AppColors.whiteDark,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(const TeacherProfile());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppImages.user,
                                    color: AppColors.whiteDark,
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  CustomText(
                                    'الملف الشخصي',
                                    fontWeight: FontWeight.bold,
                                    size: 16,
                                    color: AppColors.whiteDark,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                LocalStorageHelper.logOut();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppImages.logout,
                                    color: AppColors.whiteDark,
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  CustomText(
                                    'تسجيل الخروج',
                                    fontWeight: FontWeight.bold,
                                    size: 16,
                                    color: AppColors.whiteDark,
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ),
            ),
            const CustomText(
              'تطبيق سلوك',
              fontWeight: FontWeight.normal,
              size: 16,
              color: AppColors.white,
            ),
            CustomText(
              'النسخة 1.0.0',
              fontWeight: FontWeight.normal,
              size: 13,
              color: AppColors.whiteDark,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
