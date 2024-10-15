import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sulok/constant/app_colors.dart';
import 'package:sulok/constant/app_images.dart';
import 'package:sulok/screens/splash/splash_controller.dart';

import '../../helper/custom/custom_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GetBuilder<SplashController>(
            init: SplashController(),
            builder: (controller) {
              return Stack(
                children: [
                  Image.asset(
                    AppImages.splashBack,
                    width: Get.width,
                    height: Get.height,
                    fit: BoxFit.cover,
                  ),
                  Opacity(
                    opacity: 0.9,
                    child: Container(
                      decoration: const BoxDecoration(
                          // #02796600, #CE9D58
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              tileMode: TileMode.repeated,
                              colors: [
                            AppColors.greenMain,
                            AppColors.amberSecond
                          ])),
                    ),
                  ),
                  Opacity(
                    opacity: 0.02,
                    child: Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(AppImages.logoWhite,
                            width: Get.width * 2,
                            height: Get.height * 2,
                            fit: BoxFit.cover)),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(AppImages.logo)),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CustomText(
                        '1.0.0V\nSulok App',
                        textAlign: TextAlign.center,
                        color: AppColors.whiteGrey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
