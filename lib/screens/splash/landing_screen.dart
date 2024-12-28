import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sulok/constant/app_colors.dart';
import 'package:sulok/constant/app_images.dart';
import 'package:sulok/helper/custom/custom_button.dart';
import 'package:sulok/helper/custom/custom_text.dart';
import 'package:sulok/helper/local_storage_helper.dart';
import 'package:sulok/screens/splash/splash_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../login/login_screen.dart';
import 'model/sliders.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 34.0),
            child: SizedBox(
              height: Get.height,
              width: Get.width,
              child: Stack(
                children: [
                  AnimatedContainer(
                    height:
                        controller.sliders?[controller.currentIndex].id == 10101
                            ? Get.height / 1.3
                            : Get.height,
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: AppColors.whiteGrey,
                        borderRadius: BorderRadius.only(
                            topLeft: controller
                                        .sliders?[controller.currentIndex].id ==
                                    10101
                                ? const Radius.circular(0)
                                : const Radius.circular(34),
                            topRight: controller
                                        .sliders?[controller.currentIndex].id ==
                                    10101
                                ? const Radius.circular(0)
                                : const Radius.circular(34),
                            bottomLeft: controller
                                        .sliders?[controller.currentIndex].id ==
                                    10101
                                ? const Radius.circular(50)
                                : const Radius.circular(0),
                            bottomRight: controller
                                        .sliders?[controller.currentIndex].id ==
                                    10101
                                ? const Radius.circular(50)
                                : const Radius.circular(141))),
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.fastEaseInToSlowEaseOut,
                  ),
                  SizedBox(
                    width: Get.width,
                    height:
                        controller.sliders?[controller.currentIndex].id == 10101
                            ? Get.height / 1.3
                            : Get.height,
                    child: PageView.builder(
                        controller: controller.pageViewController,
                        onPageChanged: (i) {
                          controller.currentIndex = i;
                          controller.update();
                        },
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.sliders?.length,
                        pageSnapping: true,
                        itemBuilder: (context, index) {
                          return controller
                                      .sliders?[controller.currentIndex].id ==
                                  10101
                              ? welcomeBox()
                              : page(controller.sliders![index]);
                        }),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 5,
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0;
                                i < (controller.sliders?.length ?? 0);
                                i++)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  height: 5,
                                  width: i == controller.currentIndex ? 30 : 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2000),
                                      color: i == controller.currentIndex
                                          ? AppColors.amberSecond
                                          : AppColors.grey),
                                ),
                              ),
                          ],
                        )),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget welcomeBox() {
    return SizedBox(
      width: Get.width,
      height: Get.height / 1.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  AppImages.fullLogo,
                  height: Get.height / 2.4,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomText(
                  'ابدأ رحلتك معنا',
                  size: 25,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                  color: AppColors.amberSecond,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomText(
                  'دروس وأذكار ومقاطع فيديو وكتب دينية تتبع المنهج الإسلامي السني',
                  size: 20,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                  color: AppColors.greenMain,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              color: AppColors.amberSecond,
              title: 'سجل عن طريق الجوال',
              pressed: () {
                LocalStorageHelper.changeSkipLandingPage(true);
                Get.offAll(const LoginScreen());
              },
              height: 60,
              borderRadius: 50,
            ),
          ),
        ],
      ).paddingAll(12),
    );
  }

  Widget page(Sliders sliders) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: sliders.image ?? "",
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                const Center(child: CupertinoActivityIndicator()),
            errorWidget: (context, url, error) =>
                SvgPicture.asset(AppImages.landing),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomText(
            sliders.title ?? "",
            size: 25,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
            color: AppColors.amberSecond,
          ),
          CustomText(
            sliders.description ?? "",
            size: 20,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
            color: AppColors.greenMain,
          ),
        ],
      ),
    );
  }
}
