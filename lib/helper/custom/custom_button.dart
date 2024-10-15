import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sulok/constant/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final Color? colorTitle;
  final String title;
  final VoidCallback pressed;
  final int? fontSize;
  double? width;
  double? height;
  double? borderRadius;

  CustomButton({
    super.key,
    required this.color,
    required this.title,
    required this.pressed,
    this.borderRadius,
    this.colorTitle,
    this.fontSize,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: pressed,
      child: Container(
        height: height??45,
        width: width??Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 20),
          color: color,
        ),
        child: Center(
            child: Text(title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: colorTitle??AppColors.whiteGrey ,
                ))),
      ),
    );
  }
}
