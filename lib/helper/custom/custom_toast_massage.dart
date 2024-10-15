import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/app_colors.dart';

class CustomSnackBar  {


  static void showCustomSnackBar({
     String ?message,
     Color ?backgroundColor,
     Duration? duration,
  }) {
    Get.rawSnackbar(
      borderRadius: 0,

      icon: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.close,color: Colors.redAccent,)),
      padding: const EdgeInsets.all(30),
      snackStyle: SnackStyle.FLOATING,
      messageText: Text(
        message??"--",
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: backgroundColor??AppColors.greenMain,
      duration: duration??const Duration(seconds: 2),
    );
  }
}
