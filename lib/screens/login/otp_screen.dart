import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sulok/screens/login/login_screen.dart';
import 'package:sulok/screens/login/resend_widget.dart';

import '../../constant/app_colors.dart';
import '../../constant/app_images.dart';
import '../../helper/custom/custom_text.dart';
import '../../helper/custom/custom_text_feild.dart';
import 'login_controller.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: GetBuilder<LoginController>(builder: (controller) {
          return Column(
            children: [
              Row(
                children: [
                  IconButton(onPressed: (){Get.offAll(const LoginScreen());}, icon: const Icon(Icons.clear,color: AppColors.white,)),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                  child: SvgPicture.asset(
                    AppImages.logoAmber,
                    color: AppColors.whiteGrey,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Column(
                children: [
                  CustomText(
                    'التحقق من الرقم',
                    size: 25,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                    color: AppColors.amberSecond,
                  ),
                  CustomText(
                    'لإتمام عملية التسجيل وتسجيل الدخول يرجى إدخال الرمز المكون من خمسة ارقام والذي تم إرساله إلى رقم الموبايل الذي قمت بإدخاله',
                    size: 15,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.normal,
                    color: AppColors.whiteGrey,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  keyboardType:TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    fieldHeight: 45,
                    fieldWidth: 45,
                    disabledColor: Colors.transparent,
                    activeFillColor: Colors.transparent,
                    activeColor: AppColors.amberSecond,
                    selectedFillColor: Colors.transparent,
                    inactiveColor: AppColors.amberSecond.withOpacity(0.7),
                    selectedColor:AppColors.greyDark,
                    inactiveFillColor: Colors.transparent,
                    errorBorderColor: AppColors.amberSecond,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  textStyle: const TextStyle(color: AppColors.whiteGrey),
                  // errorAnimationController: errorController,
                  // controller: textEditingController,
                  onCompleted: (v) {
                    controller.confirmCode();
                  },
                  onChanged: (value) {
                    controller.smsCode = value;
                  },
                  beforeTextPaste: (text) {
                    return true;
                  },
                  appContext: context,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const CustomText(
                'تم إرسال الرمز إلى رقم الموبايل ',
                size: 15,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.normal,
                color: AppColors.whiteGrey,
              ),
              // !isResend
              //     ? Countdown(
              //   animation: StepTween(
              //     begin: 60,
              //     // THIS IS A USER ENTERED NUMBER
              //     end: 0,
              //   ).animate(_controllerTime),
              // )
              //     : Center(
              //   child: Column(
              //     mainAxisSize: MainAxisSize.max,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text(
              //         "notRecive".tr,
              //         style: TextStyle(
              //           fontSize: 13,
              //           color: Theme.of(context)
              //               .accentColor
              //               .withOpacity(0.5),
              //         ),
              //       ),
              //       InkWell(
              //         onTap: () async {
              //           await userController.verificationPhone();
              //           setState(() {
              //             isResend = false;
              //             _controllerTime = AnimationController(
              //                 vsync: this,
              //                 duration: Duration(minutes: 1)
              //               // gameData.levelClock is a user entered number elsewhere in the applciation
              //             );
              //             _controllerTime.forward().whenComplete(() {
              //               print('_controllerTime');
              //               setState(() {
              //                 isResend = true;
              //               });
              //             });
              //           });
              //         },
              //         child: Text(
              //           "resend".tr,
              //           style: TextStyle(
              //             fontSize: 13,
              //             color: Theme.of(context).primaryColor,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const ResendWidget(),
              const SizedBox(
                height: 30,
              ),
            ],
          );
        }),
      ),
    );
  }
}
