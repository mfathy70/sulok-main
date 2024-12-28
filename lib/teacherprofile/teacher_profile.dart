import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sulok/helper/custom/custom_button.dart';
import 'package:sulok/helper/custom/custom_text_feild.dart';
import 'package:sulok/helper/custom/default_screen.dart';
import 'package:sulok/teacherprofile/teacher_profile_repo.dart';

import '../../helper/local_storage_helper.dart';
import '../constant/app_colors.dart';
import '../helper/custom/custom_text.dart';
import '../screens/login/model/login_teacher_respone.dart';

class TeacherProfile extends StatelessWidget {
  const TeacherProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descController = TextEditingController();

    return DefaultScreen(
        onTapBack: () {
          Get.back();
        },
        title: 'الملف الشخصي',
        child: SizedBox(
          width: Get.width,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(35),
            physics: const BouncingScrollPhysics(),
            child: FutureBuilder(
                future: LocalStorageHelper.getTeacherData(),
                builder: (BuildContext context,
                    AsyncSnapshot<LoginTeacherResponse> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CupertinoActivityIndicator();
                  }
                  var teacher = snapshot.data?.info;
                  nameController.text = teacher?.name ?? " ";
                  descController.text = teacher?.description ?? " ";
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Label(label: "الاسم"),
                      CustomTextField(
                        hintText: 'الاسم',
                        controller: nameController,
                      ),
                      const SizedBox(height: 25),
                      const Label(label: "الوصف"),
                      CustomTextField(
                        hintText: 'الوصف',
                        controller: descController,
                      ),
                      const SizedBox(height: 25),
                      dataField('رقم الهاتف', teacher?.phone ?? ""),
                      dataField('الكود', teacher?.code ?? ""),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: CustomButton(
                          color: AppColors.amberSecond,
                          title: 'تحديث البيانات',
                          pressed: () {
                            TeacherProfileRepo().updateTeacherData(
                                nameController.text, descController.text);
                          },
                          height: 60,
                          borderRadius: 50,
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ));
  }

  dataField(String label, String data) {
    return Visibility(
      visible: data.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), color: AppColors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Label(label: label),
                CustomText(
                  data,
                  color: AppColors.greyDark.withOpacity(0.7),
                  size: 12,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Label extends StatelessWidget {
  final String label;
  const Label({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
              color: AppColors.amberSecond, shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 10,
        ),
        CustomText(
          label,
          color: AppColors.greyDark,
          size: 17,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
