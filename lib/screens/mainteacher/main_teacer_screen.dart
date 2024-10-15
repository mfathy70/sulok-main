import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sulok/constant/app_colors.dart';
import 'package:sulok/constant/app_images.dart';
import 'package:sulok/constant/const_var.dart';
import 'package:sulok/helper/custom/custom_text.dart';
import 'package:sulok/helper/custom/default_screen.dart';
import 'package:sulok/helper/local_storage_helper.dart';
import 'package:sulok/screens/teacherprograms/add_program_controller.dart';
import 'package:sulok/teacherprofile/teacher_profile.dart';

import '../login/model/login_teacher_respone.dart';
import '../menu/menu_screen.dart';
import '../mystudents/my_students_screen.dart';
import '../report/report_screen.dart';
import '../teachernotification/teacher_notification_screen.dart';
import '../teacherprograms/teacher_programs_screen.dart';

class MainTeacherScreen extends StatefulWidget {
  const MainTeacherScreen({super.key});

  @override
  State<MainTeacherScreen> createState() => _MainTeacherScreenState();
}

class _MainTeacherScreenState extends State<MainTeacherScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      title: 'البرامج الرئيسية',
      leading: InkWell(
        onTap: () {
          Get.to(const TeacherProfile());
        },
        child: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: AppColors.grey),
          child: const Icon(
            Icons.person,
            color: AppColors.white,
          ),
        ),
      ),
      headerWidget: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(const TeacherProfile());
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const TeacherNotificationScreen());
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: AppColors.amberSecond,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: SvgPicture.asset(AppImages.notification),
                            ),
                          ),
                          Positioned(
                              top: 0,
                              left: 0,
                              child: FutureBuilder(
                                  future: LocalStorageHelper.getTeacherData(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<LoginTeacherResponse>
                                          snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CupertinoActivityIndicator();
                                    }
                                    var lngth =
                                        snapshot.data?.notification?.length;
                                    return Visibility(
                                      visible: (lngth ?? 0) > 0,
                                      child: Container(
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.amberSecond,
                                            border: Border.all(
                                                color: AppColors.greenMain,
                                                width: 3),
                                          ),
                                          child: Center(
                                              child: CustomText(
                                            lngth.toString(),
                                            color: AppColors.white,
                                            fontWeight: FontWeight.bold,
                                            size: 12,
                                          ))),
                                    );
                                  }))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const CustomText(
                'الرئيسية',
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                size: 25,
              ),
              InkWell(
                onTap: () {
                  Get.to(const MenuScreen(isTeacher: true),
                      fullscreenDialog: true);
                },
                child: SizedBox(
                  width: 45,
                  height: 45,
                  child: Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(AppImages.menu),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(35),
          child: FutureBuilder(
            future: LocalStorageHelper.getTeacherData(),
            builder: (BuildContext context,
                AsyncSnapshot<LoginTeacherResponse> snapshot) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.put(AddProgramController());
                      Get.to(const TeacherProgramsScreen());
                    },
                    child: Container(
                      height: 88,
                      width: Get.width,
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          boxShadow: ConstVars.amberBoxShadow,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: CustomText(
                              'البرامج الرئيسية',
                              fontWeight: FontWeight.bold,
                              size: 20,
                              color: AppColors.amberSecond,
                            ),
                          ),
                          SvgPicture.asset(AppImages.book),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.to(const MyStudentScreen());
                          },
                          child: Container(
                            height: 140,
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                                color: AppColors.greenMain,
                                boxShadow: ConstVars.amberBoxShadow,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 15.0,
                                        left: 15,
                                        right: 15,
                                        bottom: 5),
                                    child: CustomText(
                                      'السالكين',
                                      fontWeight: FontWeight.bold,
                                      size: 20,
                                      color: AppColors.whiteGrey,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: SvgPicture.asset(AppImages.students),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.to(const ReportScreen());
                          },
                          child: Container(
                            height: 140,
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                                color: AppColors.amberSecond,
                                boxShadow: ConstVars.amberBoxShadow,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 15.0,
                                        left: 15,
                                        right: 15,
                                        bottom: 5),
                                    child: CustomText(
                                      'التقارير',
                                      fontWeight: FontWeight.bold,
                                      size: 20,
                                      color: AppColors.whiteGrey,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 0,
                                          bottom: -40,
                                          right: -10,
                                          child: SvgPicture.asset(
                                            AppImages.reports,
                                            width: 100,
                                            height: 100,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height / 2,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
