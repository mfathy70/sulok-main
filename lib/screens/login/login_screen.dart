import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sulok/constant/app_colors.dart';
import 'package:sulok/helper/custom/custom_text_feild.dart';
import 'package:sulok/helper/custom/default_screen.dart';
import 'package:sulok/helper/helper_functions.dart';
import 'package:sulok/screens/login/login_controller.dart';
import 'package:sulok/screens/login/otp_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/app_images.dart';
import '../../helper/custom/custom_button.dart';
import '../../helper/custom/custom_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: GetBuilder<LoginController>(
            init: LoginController(),
            builder: (controller) {
              return Column(
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
                  const Column(
                    children: [
                      CustomText(
                        'التسجيل عن طريق الموبايل',
                        size: 25,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.bold,
                        color: AppColors.amberSecond,
                      ),
                      CustomText(
                        'الرجاء إختيار رمز الدوله ثم رقم الموبايل كما هو موضح في المثال الظاهر امامك',
                        size: 15,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.normal,
                        color: AppColors.greyDark,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  CustomTextField(
                    showTitle: true,
                    hintText: '0 5 x x x x x x x x '.toUpperCase(),
                    inputType: TextInputType.phone,
                    title: 'رقم الجوال',
                    controller: controller.phoneController,
                    suffixIcon: SizedBox(
                      width: 40,
                      height: 40,
                      child: Center(
                        child: InkWell(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode: true,
                                useSafeArea: false,
                                favorite: ['SA', 'UAE', 'JO'],
                                onSelect: (Country country) {
                                  controller.selectedCountry = country;
                                  controller.update();
                                },
                              );
                            },
                            child: Text(
                              controller.selectedCountry?.flagEmoji ??
                                  "أختر الدولة",
                              style: const TextStyle(fontSize: 20),
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      controller.isTeacher = !controller.isTeacher;
                      controller.update();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.amberSecond),
                              shape: BoxShape.circle,
                              color: controller.isTeacher
                                  ? AppColors.amberSecond
                                  : AppColors.amberOpsity),
                          child: Visibility(
                            visible: controller.isTeacher,
                            child: const Center(
                                child: Icon(
                              Icons.check,
                              size: 11,
                              color: AppColors.white,
                            )),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const CustomText(
                          'تسجيل الدخول باستخدام حساب شيخ',
                          fontWeight: FontWeight.bold,
                          color: AppColors.greyDark,
                        )
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  const CustomText(
                    'عند الضغط على تسجيل أنت توافق على',
                    size: 15,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.normal,
                    color: AppColors.greyDark,
                  ),
                  InkWell(
                    onTap: () {
                      launchUrl(Uri.parse(
                          'https://solokapp.com/terms-and-conditions/'));
                    },
                    child: const CustomText(
                      ' الشروط والأحكام',
                      size: 16,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold,
                      color: AppColors.amberSecond,
                    ),
                  ),
                  // تسجيل
                  const SizedBox(
                    height: 30,
                  ),

                  CustomButton(
                    color: AppColors.amberSecond,
                    title: 'تسجيل',
                    pressed: () {
                      controller.submit();
                    },
                    height: 60,
                    borderRadius: 50,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
