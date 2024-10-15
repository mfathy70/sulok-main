import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../constant/app_colors.dart';

class Pickers {
  static void showDatePickerMenaMe(
      {DateTime? initialTime, ValueChanged<DateTime>? onConfirm}) {
    showRoundedDatePicker(
      textPositiveButton: "موافق",
      textNegativeButton: "الغاء",
      context: Get.context!,
      initialDate: initialTime,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 100),
      borderRadius: 16,
      height: Get.height / 2,
      styleYearPicker: MaterialRoundedYearPickerStyle(),
      builderDay: (dateTime, isCurrentDay, selected, defaultTextStyle) =>
          Container(
        decoration: BoxDecoration(
          color: selected ? AppColors.amberSecond : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            // DateFormat.d(Get.locale?.languageCode == 'ar' ? 'ar_SA' : 'en_USA')
            //     .format(dateTime),
            DateFormat.d(
                    Get.locale?.languageCode == 'en_USA' ? 'en_USA' : 'en_USA')
                .format(dateTime),
            style: defaultTextStyle.copyWith(
              color: selected
                  ? AppColors.whiteGrey
                  : isCurrentDay
                      ? AppColors.amberSecond
                      : Colors.black,
            ),
          ),
        ),
      ),
    ).then((value) {
      if (value != null) {
        onConfirm?.call(value);
      }
    });
  }

  static void showTimePickerMenaMe(
      {required TimeOfDay initialTime, ValueChanged<TimeOfDay>? onConfirm}) {
    showTimePicker(
      context: Get.context!,
      initialTime: initialTime,
      helpText: 'أختر الوقت',
      cancelText: "الغاء",
      confirmText: "موافق",
    ).then((value) {
      if (value != null) {
        onConfirm?.call(value);
      }
    });
  }
}
