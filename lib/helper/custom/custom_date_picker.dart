import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sulok/helper/custom/custom_text.dart';
import 'package:sulok/helper/custom/pickers.dart';

import '../../constant/app_colors.dart';

class CustomDateField extends StatefulWidget {
  final DateTime? initialTime;
  final ValueChanged<DateTime>? onConfirm;
  final String? label;

  const CustomDateField({
    super.key,
    this.initialTime,
    this.onConfirm,
    this.label,
  });

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  var dotsFormat = DateFormat('dd.MM.yyyy', "en");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: () {
              Pickers.showDatePickerMenaMe(
                  initialTime: widget.initialTime ?? DateTime.now(),
                  onConfirm: (value) {
                    widget.onConfirm?.call(value);
                  });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.label ?? "",
                    style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.grey,
                        fontWeight: FontWeight.w500)),
                CustomText(
                  dotsFormat.format(widget.initialTime ?? DateTime.now()),
                  size: 14.0,
                  color: AppColors.greyDark,
                ),
              ],
            ),
          )),
    );
  }
}
