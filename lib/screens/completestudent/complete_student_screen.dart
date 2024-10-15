import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sulok/helper/custom/custom_date_picker.dart';
import 'package:sulok/helper/custom/custom_drop_down.dart';
import 'package:sulok/helper/custom/default_screen.dart';
import 'package:sulok/screens/login/login_screen.dart';

import '../../constant/app_colors.dart';
import '../../constant/app_images.dart';
import '../../helper/custom/custom_button.dart';
import '../../helper/custom/custom_text.dart';
import '../../helper/custom/custom_text_feild.dart';
import '../../helper/custom/liner_widget.dart';
import '../../helper/local_storage_helper.dart';
import 'complete_student_controller.dart';

class CompleteStudentScreen extends StatelessWidget {
  final bool? updateData;

  const CompleteStudentScreen({Key? key, this.updateData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return updateData == true;
      },
      child: GetBuilder<CompleteStudentController>(
          init: CompleteStudentController(updateData),
          builder: (controller) {
            return DefaultScreen(
              onTapBack: updateData == true
                  ? () {
                      Get.back();
                    }
                  : () {
                      Get.to(const LoginScreen());
                    },
              title: updateData == true ? 'الملف الشخصي' : " ",
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.grey.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 3),
                        child: SvgPicture.asset(
                          AppImages.logoAmber,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Visibility(
                      visible: updateData != true,
                      child: const Column(
                        children: [
                          CustomText(
                            'أهلا بك',
                            size: 25,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.bold,
                            color: AppColors.amberSecond,
                          ),
                          CustomText(
                            'هذه المرة الأولى التي تسجل بها , لذلك نحتاج إلى بيانات إضافية لإتمام عملية التسجيل والبدء باستخدام التطبيق ',
                            size: 15,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.normal,
                            color: AppColors.greyDark,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      hintText: 'email@site.com',
                      controller: controller.email,
                    ),
                    CustomTextField(
                      hintText: 'كود الشيخ إن وجد',
                      controller: controller.code,
                    ),
                    CustomTextField(
                      hintText: 'الإسم الكامل',
                      controller: controller.fullName,
                    ),
                    CustomTextField(
                      hintText:
                          'الرقم الجامعي (إذا كنت من طلاب كلية الفقه الحنفي)',
                      controller: controller.universityID,
                    ),
                    CustomTextField(
                      hintText: 'إسم البرنامج الدراسي',
                      controller: controller.programName,
                    ),
                    CustomDateField(
                      initialTime: controller.birthData,
                      label: 'تاريخ الميلاد',
                      onConfirm: (v) {
                        controller.birthData = v;
                        controller.update();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomDropdown(
                        listItems: [
                          Item(name: 'ذكر', id: '1'),
                          Item(name: 'انثى', id: '2'),
                        ],
                        selectedItem: controller.selectedGender,
                        onSelected: (v) {
                          controller.selectedGender = v;
                          controller.update();
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: false,
                          useSafeArea: true,
                          favorite: ['SA', 'UAE', 'JO'],
                          onSelect: (Country country) {
                            controller.selectedCountry = country;
                            controller.update();
                          },
                        );
                      },
                      child: Container(
                        height: 50,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                controller.selectedCountry?.name ??
                                    'بلد الإقامة',
                                color: AppColors.greyDark,
                              ),
                              const Icon(
                                Icons.arrow_drop_down_outlined,
                                color: AppColors.greyDark,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomDropdown(
                        listItems: [
                          Item(name: 'متزوج', id: '1'),
                          Item(name: 'اعزب', id: '2'),
                          Item(name: 'مطلق', id: '3'),
                        ],
                        selectedItem: controller.selectedSocial,
                        onSelected: (v) {
                          controller.selectedSocial = v;
                          controller.update();
                        }),
                    CustomTextField(
                      hintText: 'عدد الاولاد',
                      controller: controller.numberOfChild,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        controller.areYouStudied = !controller.areYouStudied;
                        controller.update();
                      },
                      child: Container(
                        height: 50,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: controller.areYouStudied
                                    ? Colors.green
                                    : AppColors.amberOpsity,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const CustomText(
                                'هل درست دراسة شرعية',
                                color: AppColors.greyDark,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: controller.areYouStudied,
                      child: Column(
                        children: [
                          CustomDropdown(
                              listItems: [
                                Item(name: 'التعليم الابتدائي', id: '1'),
                                Item(name: 'التعليم الأساسي', id: '2'),
                                Item(name: 'التعليم الثانوي', id: '3'),
                                Item(name: 'التعليم الجامعي', id: '4'),
                                Item(name: 'التعليم العالي', id: '5'),
                              ],
                              selectedItem: controller.selectedEducation,
                              onSelected: (v) {
                                controller.selectedEducation = v;
                                controller.update();
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.youHaveTeacher = !controller.youHaveTeacher;
                        controller.update();
                      },
                      child: Container(
                        height: 50,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: controller.youHaveTeacher
                                    ? Colors.green
                                    : AppColors.amberOpsity,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const CustomText(
                                'هل لك شيخ في التربية والسلوك والتصوف',
                                color: AppColors.greyDark,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.youHaveTeacher,
                      child: CustomTextField(
                        hintText: 'اذكر إسمه إن رغبت',
                        controller: controller.teacherName,
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    if (updateData == true)
                      Column(
                        children: [
                          Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomText(
                                        'الأداء العام'
                                        '\nللمهام المطلوبه',
                                        color: AppColors.greenMain,
                                        size: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      Row(
                                        children: [
                                          CustomText(
                                            controller.studentResponse?.chart
                                                    ?.total ??
                                                "0",
                                            color: AppColors.amberSecond,
                                            size: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  for (var i in controller
                                          .studentResponse?.chart?.items ??
                                      [])
                                    reportWidget(i['program'].toString(),
                                        i['progress'].toString()),
                                  const SizedBox(
                                    height: 35,
                                  ),
                                  Row(
                                    children: [
                                      const CustomText("النقاط : ",
                                          color: AppColors.greenMain,
                                          fontWeight: FontWeight.bold),
                                      CustomText(
                                          controller.studentResponse?.profile
                                                  ?.points ??
                                              "",
                                          color: AppColors.greenMain,
                                          fontWeight: FontWeight.bold),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const CustomText("نسبة الإنجاز : ",
                                          color: AppColors.greenMain,
                                          fontWeight: FontWeight.bold),
                                      CustomText(
                                          controller.studentResponse?.profile
                                                  ?.progress ??
                                              "",
                                          color: AppColors.greenMain,
                                          fontWeight: FontWeight.bold),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: CustomButton(
                        color: AppColors.amberSecond,
                        title: 'تحديث البيانات',
                        pressed: () {
                          controller.submit();
                        },
                        height: 60,
                        borderRadius: 50,
                      ),
                    ),
                    if (updateData == true)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: CustomButton(
                          color: AppColors.amberSecond,
                          title: 'حذف الحساب',
                          pressed: () {
                            Get.dialog(CupertinoAlertDialog(
                              title: Text("حذف الحساب"),
                              actions: [
                                CupertinoDialogAction(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("تراجع")),
                                CupertinoDialogAction(
                                    onPressed: () {
                                      controller.deleteAccount();
                                    },
                                    child: Text("حذف")),
                              ],
                              content: Text(
                                  "هل انت متاكد من اتمام عملية حذف الحساب ؟"),
                            ));
                          },
                          height: 60,
                          borderRadius: 50,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: CustomButton(
                        color: AppColors.amberSecond,
                        title: 'تسجيل الخروج',
                        pressed: () {
                          LocalStorageHelper.logOut();
                        },
                        height: 60,
                        borderRadius: 50,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  reportWidget(String name, String perc) {
    print("name $name perc $perc");
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        CustomText(
          name,
          size: 14,
          color: AppColors.greyDark,
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            // CustomText(perc),
            // SizedBox(width: 20),
            Expanded(
              child: GradientContainer(
                percentage:
                    perc != '100' ? (double.tryParse('0.$perc') ?? 0) : 1,
                // Adjust this value to control the gradient percentage
                colors: [AppColors.amberSecond, AppColors.whiteGrey],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
