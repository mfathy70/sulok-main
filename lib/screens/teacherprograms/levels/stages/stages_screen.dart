import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sulok/helper/custom/custom_button.dart';
import 'package:sulok/screens/teacherprograms/levels/stages/add_stage_screen.dart';
import 'package:sulok/screens/teacherprograms/levels/stages/tasks/tasks_screen.dart';

import '../../../../constant/app_colors.dart';
import '../../../../helper/custom/custom_text.dart';
import '../../../../helper/custom/default_screen.dart';
import '../../../login/model/login_teacher_respone.dart';
import '../../add_program_controller.dart';
import '../add_level_screen.dart';

class StagesScreen extends StatelessWidget {
  final Program level;

  const StagesScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddProgramController>(
        global: true,
        autoRemove: false,
        builder: (controller) {
          return DefaultScreen(
              title: level.name ?? "",
              onRefresh: (){
                controller.update();
              },
              onTapBack: () {
                controller.levelID = null;
                controller.stageID = null;
                controller.taskID = null;
                controller.update();
                Get.back();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        FutureBuilder<List<Program>>(
                            future: controller.getStagesByLevelID(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Program>> stages) {
                              if (stages.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              if ((stages.data?.isEmpty ?? true)) {
                                return const Padding(
                                  padding: EdgeInsets.all(30.0),
                                  child: CustomText('لايوجد عناصر يمكن عرضها',
                                      color: AppColors.greenMain,
                                      fontWeight: FontWeight.bold,
                                      size: 30),
                                );
                              }
                              return ListView.builder(
                                padding: const EdgeInsets.all(35),
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: stages.data?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var item = stages.data?[index];
                                  return cardWidget(item,
                                      pending: false, controller: controller);
                                },
                              );
                            }),
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
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            height: 65,
                            color: AppColors.amberSecond,
                            title: 'إضافة مرحلة جديد',
                            pressed: () {
                              controller.stageName.clear();
                              controller.stageInfo.clear();
                              Get.to(const AddStageScreen());
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: CustomButton(
                            height: 65,
                            color: AppColors.greenMain,
                            title: 'حذف المستوى',
                            pressed: () {
                              Get.dialog(AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                            'هل انت متاكد من حذف ${level.name ?? ""}')),
                                  ],
                                ),
                                actions: [
                                  MaterialButton(
                                    onPressed: () {
                                      controller.deleteLevel();
                                    },
                                    child: const CustomText(
                                      "حذف",
                                      color: Colors.red,
                                    ),
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const CustomText("الغاء"),
                                  ),
                                ],
                              ));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomButton(
                      height: 65,
                      color: AppColors.greenMain,
                      title: 'تعديل المستوى',
                      pressed: () async {
                        controller.levelName.text = level.name ?? "";
                        controller.levelInfo.text = level.info ?? "";

                        Get.to(AddLevelScreen(
                            programID: controller.programID ?? 0,
                            level: level));
                      },
                    ),
                  ),
                ],
              ));
        });
  }

  cardWidget(Program? item,
      {bool? pending, required AddProgramController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17.0),
      child: InkWell(
        onTap: () {
          controller.stageID = item?.id;
          controller.update();
          Get.to(TasksScreen(
            stage: item!,
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
