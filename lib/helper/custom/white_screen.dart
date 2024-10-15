import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sulok/constant/app_colors.dart';
import 'package:sulok/constant/app_images.dart';
import 'package:sulok/helper/custom/custom_text.dart';

class WhiteScreen extends StatelessWidget {
  final Widget child;
  final Widget? leading;
  final String? title;
  final GestureTapCallback? onTapBack;

  const WhiteScreen(
      {super.key,
        required this.child,
        this.title,
        this.onTapBack,
        this.leading});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteGrey,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Visibility(
                visible: title != null,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Visibility(visible: leading != null, child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal  :8.0),
                              child: leading??const SizedBox(),
                            )),
                            Expanded(
                              child: CustomText(title ?? "",
                                  color: AppColors.greenMain, size: 25),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: onTapBack != null,
                        child: InkWell(
                          onTap: onTapBack,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.greenMain)),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.greenMain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Expanded(
              child: Stack(
                children: [
                  child,
                  Positioned(
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.whiteGrey.withOpacity(0.0),
                            AppColors.whiteGrey.withOpacity(0.1),
                            AppColors.whiteGrey.withOpacity(0.2),
                            AppColors.whiteGrey.withOpacity(0.3),
                            AppColors.whiteGrey.withOpacity(0.4),
                            AppColors.whiteGrey.withOpacity(0.5),
                            AppColors.whiteGrey.withOpacity(0.6),
                            AppColors.whiteGrey.withOpacity(0.7),
                            AppColors.whiteGrey.withOpacity(0.8),
                            AppColors.whiteGrey.withOpacity(0.9),
                            AppColors.whiteGrey,
                          ],
                        ),
                      ),
                      width: Get.width,
                      height: 100,
                      child: Stack(
                        children: [
                          Positioned(
                              left: 0,
                              bottom: 0,
                              child: SvgPicture.asset(AppImages.amberLayer)),
                          Positioned(
                              left: 0,
                              bottom: 0,
                              child: SvgPicture.asset(AppImages.greenLayer)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
