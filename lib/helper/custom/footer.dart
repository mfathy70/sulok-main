import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sulok/constant/app_images.dart';
class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    SizedBox(
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
    );
  }
}
