import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sulok/helper/custom/default_screen.dart';

import '../../helper/local_storage_helper.dart';
import '../constant/app_colors.dart';
import '../helper/custom/custom_text.dart';
import '../screens/login/model/login_teacher_respone.dart';

class TeacherProfile extends StatelessWidget {
  const TeacherProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      onTapBack: (){
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
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dataField('الاسم', teacher?.name ?? ""),
                      dataField('وصف', teacher?.description ?? ""),
                      dataField('رقم الهاتف', teacher?.phone ?? ""),
                      dataField('الكود', teacher?.code ?? ""),
                    ],
                  );
                }
            ),
          ),
        ));
  }
  dataField(String label, String data) {
    return Visibility(
      visible: data.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
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
                Wrap(
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
                ),
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
