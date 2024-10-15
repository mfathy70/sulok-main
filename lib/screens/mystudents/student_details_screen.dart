import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sulok/constant/app_colors.dart';
import 'package:sulok/helper/custom/custom_button.dart';
import 'package:sulok/helper/custom/custom_text.dart';
import 'package:sulok/helper/custom/custom_text_feild.dart';
import 'package:sulok/helper/custom/default_screen.dart';
import 'package:sulok/screens/teachermessages/send_message_controller.dart';

import '../../constant/app_images.dart';
import '../../helper/custom/liner_widget.dart';
import '../login/model/login_teacher_respone.dart';
import '../studentmessages/send_message_controller.dart';

class StudentDetailsScreen extends StatelessWidget {
  final Student student;

  const StudentDetailsScreen({Key? key, required this.student})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      onTapBack: () {
        Get.back();
      },
      title: student.name ?? "",
      child: SizedBox(
        width: Get.width,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(35),
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                'المعلومات الشخصية',
                color: AppColors.greyDark,
                size: 21,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 20,
              ),
              Wrap(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                runSpacing: 20,
                spacing: 20,
                children: [
                  dataField('الاسم', student.name ?? ""),
                  dataField('النقاط', student.points ?? ""),
                  dataField('نسبة الإنجاز', student.progress ?? ""),
                  dataField('البريد الالكتروني', student.email ?? ""),
                  dataField('اسم الشيخ', student.sheikhName ?? ""),
                  dataField('الرقم الجامعي', student.universityNumber ?? ""),
                  dataField('إسم البرنامج الدراسي', student.course ?? ""),
                  dataField('رقم الهاتف', student.phone ?? ""),
                  dataField('تاريخ الميلاد', student.dateBirth ?? ""),
                  dataField('الجنس', student.sex ?? ""),
                  dataField('بلد الإقامة', student.residence ?? ""),
                  dataField('الحالة الإجتماعيه', student.marital ?? ""),
                  dataField('عدد الاولاد', student.numberChildren ?? ""),
                  dataField('المستوى التعليمي', student.educational ?? ""),
                  dataField(
                      'هل درست دراسة شرعية', student.sheikhEducation ?? ""),
                  dataField('هل لك شيخ في التربية والسلوك والتصوف',
                      student.forensicStudies ?? ""),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // Container(
              //   width: Get.width,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(15),
              //     color: AppColors.white,
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(20),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         const Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             CustomText(
              //               'الأداء العام'
              //               '\nللمهام المطلوبه',
              //               color: AppColors.greenMain,
              //               size: 20,
              //               fontWeight: FontWeight.bold,
              //             ),
              //             Row(
              //               children: [
              //                 CustomText(
              //                   '%',
              //                   color: AppColors.greenMain,
              //                   size: 30,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //                 CustomText(
              //                   '88',
              //                   color: AppColors.amberSecond,
              //                   size: 30,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //         reportWidget(),
              //         reportWidget(),
              //         reportWidget(),
              //       ],
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 30,
              // ),
              MaterialButton(
                height: 55,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(55)),
                color: AppColors.amberSecond,
                onPressed: () {
                  Get.dialog(Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        backgroundColor: AppColors.whiteGrey,
                        child: GetBuilder<TeacherSendMessageController>(
                            init: TeacherSendMessageController(),
                            builder: (controller) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: Column(
                                      children: [
                                        CustomTextField(
                                          controller: controller.messageTitle,
                                          hintText: 'عنوان الرسالة..',
                                          suffixIcon: const SizedBox(),
                                          onchange: (v){
                                            controller.update();
                                          },
                                        ),
                                        CustomTextField(
                                          controller:
                                              controller.myMessageController,
                                          hintText: ' الرسالة..',
                                          maxLines: 3,
                                          onchange: (v){
                                            controller.update();
                                          },
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Visibility(
                                          visible: controller.messageTitle.text
                                                  .isNotEmpty &&
                                              controller.myMessageController
                                                  .text.isNotEmpty,
                                          child: CustomButton(
                                              color: AppColors.amberSecond,
                                              title: 'ارسال',
                                              pressed: () {
                                                FocusScopeNode currentFocus =
                                                    FocusScope.of(context);
                                                if (!currentFocus
                                                        .hasPrimaryFocus &&
                                                    currentFocus.focusedChild !=
                                                        null) {
                                                  FocusManager
                                                      .instance.primaryFocus!
                                                      .unfocus();
                                                }
                                                controller.sendMessage(
                                                    student.id.toString());
                                              }),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ],
                  ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const CustomText(
                      'ارسال رسالة',
                      fontWeight: FontWeight.bold,
                      size: 16,
                      color: AppColors.white,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    SvgPicture.asset(
                      AppImages.messages,
                      color: AppColors.white,
                      height: 25,
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

  reportWidget() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        CustomText(
          'البرنامج الأول',
          size: 14,
          color: AppColors.greyDark,
        ),
        SizedBox(
          height: 8,
        ),
        GradientContainer(
          percentage: 0.5,
          // Adjust this value to control the gradient percentage
          colors: [AppColors.amberSecond, AppColors.whiteGrey],
        ),
      ],
    );
  }

  dataField(String label, String data) {
    return Visibility(
      visible: data.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
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
