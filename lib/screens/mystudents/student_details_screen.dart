import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
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
                color: Colors.black,
                size: 22,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularPercentIndicator(
                    radius: 60,
                    percent: 1,
                    lineWidth: 10,
                    progressColor: AppColors.amberSecond,
                    animation: true,
                    animationDuration: 1000,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text(
                      student.points ?? "0",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 22),
                    ),
                    footer: const Text(
                      " النقاط",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                  ),
                  const SizedBox(width: 20),
                  CircularPercentIndicator(
                    radius: 60,
                    percent: double.parse(student.progress ?? "0") / 100,
                    lineWidth: 10,
                    progressColor: AppColors.greenMain,
                    animation: true,
                    animationDuration: 1000,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text(
                      "${student.progress ?? "0"}%",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 22),
                    ),
                    footer: const Text(
                      "نسبة الإنجاز",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DataField(label: 'الاسم', data: student.name ?? ""),
                  DataField(
                      label: 'البريد الالكتروني', data: student.email ?? ""),
                  DataField(label: 'اسم الشيخ', data: student.sheikhName ?? ""),
                  DataField(
                      label: 'الرقم الجامعي',
                      data: student.universityNumber ?? ""),
                  DataField(
                      label: 'إسم البرنامج الدراسي',
                      data: student.course ?? ""),
                  DataField(label: 'رقم الهاتف', data: student.phone ?? ""),
                  DataField(
                      label: 'تاريخ الميلاد', data: student.dateBirth ?? ""),
                  DataField(label: 'الجنس', data: student.sex ?? ""),
                  DataField(
                      label: 'بلد الإقامة', data: student.residence ?? ""),
                  DataField(
                      label: 'الحالة الإجتماعيه', data: student.marital ?? ""),
                  DataField(
                      label: 'عدد الاولاد', data: student.numberChildren ?? ""),
                  DataField(
                      label: 'المستوى التعليمي',
                      data: student.educational ?? ""),
                  // DataField(label: 'النقاط', data: student.points ?? ""),
                  // DataField(
                  //     label: 'نسبة الإنجاز', data: student.progress ?? ""),
                  DataField(
                      label: 'هل درست دراسة شرعية',
                      data: student.forensicStudies ?? ""),

                  DataField(
                      label: 'هل لك شيخ في التربية والسلوك والتصوف',
                      data: student.sheikhEducation ?? ""),
                  DataField(
                      label: 'عدد المهمات',
                      data: student.totaltasksalik.toString()),
                  DataField(
                      label: 'عدد المهمات المنجزة',
                      data: student.totaltasksalikComplete.toString()),
                  DataField(
                      label: 'عدد المهمات الغير منجزة',
                      data: student.totaltasksalikNew.toString()),
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
                                          onchange: (v) {
                                            controller.update();
                                          },
                                        ),
                                        CustomTextField(
                                          controller:
                                              controller.myMessageController,
                                          hintText: ' الرسالة..',
                                          maxLines: 3,
                                          onchange: (v) {
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
}

class DataField extends StatelessWidget {
  final String label;
  final String data;
  const DataField({
    super.key,
    required this.label,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: data.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
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
                      color: Colors.black,
                      size: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                CustomText(
                  data,
                  color: AppColors.greyDark.withOpacity(0.7),
                  size: 14,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
