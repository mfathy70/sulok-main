import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sulok/helper/custom/custom_text_feild.dart';
import 'package:sulok/helper/custom/default_screen.dart';
import 'package:sulok/screens/login/model/login_teacher_respone.dart';
import 'package:sulok/screens/teacherprograms/add_program_controller.dart';

import '../../../../constant/app_colors.dart';
import '../../../../helper/custom/custom_button.dart';
import '../../../../helper/custom/white_screen.dart';

class AddStageScreen extends StatelessWidget {
  final Program? stage;

  const AddStageScreen({Key? key,this.stage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WhiteScreen(
      title: stage?.name??'مرحلة جديدة',
      onTapBack: () {
        Get.back();
      },
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GetBuilder<AddProgramController>(builder: (controller) {
          return Column(
            children: [
              CustomTextField(
                hintText: 'أسم المرحلة',
                controller: controller.stageName,
              ),
              CustomTextField(
                maxLines: 6,
                hintText: 'الوصف',
                controller: controller.stageInfo,
              ),
              const SizedBox(
                height: 45,
              ),
              CustomButton(
                height: 65,
                color: AppColors.amberSecond,
                title: 'إضافة مرحلة جديدة',
                pressed: () {
                  controller.addNewStage();
                },
              ),
              if(stage!=null)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: CustomButton(
                  height: 65,
                  color: AppColors.greenMain,
                  title: 'تعديل المرحلة',
                  pressed: () {
                    controller.updateStage(stage!.id!);
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
