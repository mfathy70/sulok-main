import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sulok/helper/custom/custom_button.dart';
import 'package:sulok/screens/teacherprograms/levels/levels_screen.dart';

import '../../constant/app_colors.dart';
import '../../constant/const_var.dart';
import '../../helper/custom/custom_text.dart';
import '../../helper/custom/default_screen.dart';
import '../../helper/local_storage_helper.dart';
import '../login/model/login_teacher_respone.dart';
import 'add_program_controller.dart';
import 'add_program_screen.dart';

class TeacherProgramsScreen extends StatelessWidget {
  const TeacherProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddProgramController>(
        global: true,
        autoRemove: false,
        builder: (controller) {
          return DefaultScreen(
              title: 'البرامج الرئيسية',
              onRefresh: (){
                controller.update();
              },
              onTapBack: () {
                controller.programID = null;
                controller.levelID = null;
                controller.stageID = null;
                controller.taskID = null;
                controller.update();

                Get.back();
              },
              child: FutureBuilder(
                future: LocalStorageHelper.getTeacherData(),
                builder: (BuildContext context,
                    AsyncSnapshot<LoginTeacherResponse> teacher) {
                  if (teacher.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            if ((teacher.data?.programs?.isEmpty ?? true))
                              const Padding(
                                padding: EdgeInsets.all(30.0),
                                child: CustomText('لايوجد عناصر يمكن عرضها',
                                    color: AppColors.greenMain,
                                    fontWeight: FontWeight.bold,
                                    size: 30),
                              ),
                            ListView.builder(
                              padding: const EdgeInsets.all(35),
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: teacher.data?.programs?.length,
                              itemBuilder: (BuildContext context, int index) {
                                var item = teacher.data?.programs?[index];
                                return cardWidget(item,
                                    pending: false, controller: controller);
                              },
                            ),
                            IgnorePointer(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        AppColors.whiteGrey.withOpacity(0.1),
                                        AppColors.whiteGrey.withOpacity(0.2),
                                        AppColors.whiteGrey.withOpacity(0.3),
                                        AppColors.whiteGrey.withOpacity(0.4),
                                        AppColors.whiteGrey.withOpacity(0.5),
                                        AppColors.whiteGrey.withOpacity(0.6),
                                        AppColors.whiteGrey.withOpacity(0.7),
                                        AppColors.whiteGrey.withOpacity(0.8),
                                        AppColors.whiteGrey.withOpacity(0.9),
                                        AppColors.whiteGrey,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: CustomButton(
                          height: 65,
                          color: AppColors.amberSecond,
                          title: 'إضافة برنامج جديد',
                          pressed: () {
                            controller.programName.clear();
                            controller.programInfo.clear();
                            Get.to(const AddProgramScreen());
                          },
                        ),
                      )
                    ],
                  );
                },
              ));
        });
  }

  cardWidget(Program? item,
      {bool? pending, required AddProgramController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17.0),
      child: InkWell(
        onTap: () {
          controller.programID = item?.id;
          controller.update();
          Get.to(LevelsScreen(
            title: item?.name ?? "",
            programID: item?.id ?? 0,
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
                      item?.name ?? "",
                      fontWeight: FontWeight.bold,
                      size: 17,
                      maxLines: 1,
                    ),
                    CustomText(
                      item?.info ?? "",
                      fontWeight: FontWeight.normal,
                      size: 12,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
