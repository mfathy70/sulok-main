import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sulok/constant/app_colors.dart';
import 'package:sulok/constant/app_images.dart';
import 'package:sulok/helper/custom/custom_text.dart';

class DefaultScreen extends StatelessWidget {
  final Widget child;
  final Widget? headerWidget;
  final Widget? leading;
  final String? title;
  final GestureTapCallback? onTapBack;
  final GestureTapCallback? onRefresh;
  final bool? resizeToAvoidBottomInset;
  final bool? hasBottom;

  const DefaultScreen(
      {super.key,
      required this.child,
      this.title,
      this.onRefresh,
      this.resizeToAvoidBottomInset,
      this.headerWidget,
      this.onTapBack,
      this.leading,
      this.hasBottom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
                visible: title != null && headerWidget == null,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Visibility(
                                visible: leading != null,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: leading ?? const SizedBox(),
                                )),
                            Expanded(
                              child: CustomText(title ?? "",
                                  color: AppColors.whiteGrey, size: 25),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: onRefresh != null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: InkWell(
                            onTap: onRefresh,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: AppColors.whiteGrey)),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.refresh,
                                  color: AppColors.whiteGrey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: onTapBack != null,
                        child: InkWell(
                          onTap: onTapBack,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.whiteGrey)),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.whiteGrey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            if (headerWidget != null)
              Visibility(
                  visible: headerWidget != null,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: headerWidget!,
                  )),
            const SizedBox(),
            Expanded(
              child: Container(
                width: Get.width,
                margin: const EdgeInsets.only(top: 30),
                decoration: const BoxDecoration(
                    color: AppColors.whiteGrey,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                child: Column(
                  children: [
                    Expanded(child: child),
                    hasBottom ?? true
                        ? SizedBox(
                            width: Get.width,
                            height: 100,
                            child: Stack(
                              children: [
                                Positioned(
                                    left: 0,
                                    bottom: 0,
                                    child:
                                        SvgPicture.asset(AppImages.amberLayer)),
                                Positioned(
                                    left: 0,
                                    bottom: 0,
                                    child:
                                        SvgPicture.asset(AppImages.greenLayer)),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
