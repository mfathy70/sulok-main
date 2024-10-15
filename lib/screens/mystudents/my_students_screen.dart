import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sulok/constant/app_colors.dart';
import 'package:sulok/constant/const_var.dart';
import 'package:sulok/helper/custom/custom_text.dart';
import 'package:sulok/helper/custom/default_screen.dart';
import 'package:sulok/screens/mystudents/my_students_controller.dart';
import 'package:sulok/screens/mystudents/student_details_screen.dart';

import '../../helper/local_storage_helper.dart';
import '../login/model/login_teacher_respone.dart';

class MyStudentScreen extends StatelessWidget {
  const MyStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyStudentsController>(
        init: MyStudentsController(),
        builder: (controller) {
          return DefaultScreen(
            title: 'السالكين',
            onTapBack: () {
              Get.back();
            },
            child: FutureBuilder(
              future: LocalStorageHelper.getTeacherData(),
              builder: (BuildContext context,
                  AsyncSnapshot<LoginTeacherResponse> teacher) {
                if (teacher.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: teacher.data?.salik?.active?.length,
                        itemBuilder: (BuildContext context, int index) {
                          var item = teacher.data?.salik?.active?[index];
                          return Dismissible(
                              background: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.amberOpsity,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: AppColors.greyDark)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(3.0),
                                          child: Icon(Icons.clear),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: AppColors.greyDark)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(3.0),
                                          child: Icon(Icons.clear),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onDismissed: (v) {
                                controller
                                    .deActiveStudent(item?.id.toString() ?? "");
                              },
                              key: Key(item?.id.toString() ?? ''),
                              child:
                                  studentCar(item, controller, pending: false));
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Visibility(
                        visible:
                            teacher.data?.salik?.pinding?.isNotEmpty ?? false,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              'طلبات الانضمام',
                              size: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.greyDark,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: teacher.data?.salik?.pinding?.length,
                              itemBuilder: (BuildContext context, int index) {
                                var item = teacher.data?.salik?.pinding?[index];
                                return studentCar(item, controller,
                                    pending: true);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        });
  }

  studentCar(Student? item, MyStudentsController controller, {bool? pending}) {
    return Padding(
      padding: const EdgeInsets.only(bottom:8.0),
      child: InkWell(
        onTap: (){
          Get.to(StudentDetailsScreen(student: item!));
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
                    ),
                    Visibility(
                      visible: pending != true,
                      child: CustomText(
                        item?.course ?? "",
                        fontWeight: FontWeight.normal,
                        size: 12,
                      ),
                    ),
                    Visibility(
                      visible: item?.createdAt != null && pending == true,
                      child: CustomText(
                        'طلب الإنضمام ${ConstVars.timeAgo(item?.createdAt)}',
                        fontWeight: FontWeight.normal,
                        size: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Visibility(
                      visible: pending == true,
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                controller
                                    .deActiveStudent(item?.id.toString() ?? '0');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.greyDark)),
                                child: const Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child: Icon(Icons.clear),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                controller
                                    .activeStudent(item?.id.toString() ?? '0');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: AppColors.amberSecond)),
                                child: const Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child: Icon(
                                    Icons.check,
                                    color: AppColors.amberSecond,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  Visibility(
                    visible: item?.updatedAt != null && pending != true,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        ConstVars.timeAgo(item?.updatedAt),
                        size: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
