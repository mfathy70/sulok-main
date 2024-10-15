import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom/animated_message.dart';

class HelperFun {
  static Future<void> showToast(String message, {bool? success}) async {
    await Get.bottomSheet(AnimatedMessage(message: message, success: success),
        barrierColor: Colors.transparent,
        exitBottomSheetDuration: Duration.zero,
        enterBottomSheetDuration: Duration.zero,
        isDismissible: false);
  }
}
