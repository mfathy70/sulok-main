import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sulok/constant/app_colors.dart';
import 'package:sulok/helper/custom/custom_button.dart';
import 'package:sulok/helper/custom/custom_text.dart';
import 'package:sulok/helper/custom/custom_text_feild.dart';

class NumberBox extends StatelessWidget {
  final int currentNumber;
  final ValueChanged<int>? onChange;
  final bool? enableNegative;
  final Color? offColor;

  const NumberBox(
      {Key? key,
      required this.currentNumber,
      this.offColor,
      this.onChange,
      this.enableNegative})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: currentNumber == 0
                ? offColor ?? AppColors.whiteGrey
                : AppColors.amberSecond,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const RotatedBox(
                  quarterTurns: 2,
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 15,
                    color: AppColors.white,
                  )),
              Expanded(
                child: InkWell(
                  onTap: () {
                    TextEditingController valueController =
                        TextEditingController(text: currentNumber.toString());
                    Get.dialog(Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Dialog(
                          backgroundColor: AppColors.whiteGrey,
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
                              children: [
                                CustomTextField(
                                  controller: valueController,
                                  inputType: TextInputType.number,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                CustomButton(
                                    color: AppColors.greenMain,
                                    title: 'حفظ',
                                    pressed: () {
                                      int num =
                                          int.tryParse(valueController.text) ?? 0;
                                      if (num > 0) {
                                        onChange?.call(num);
                                      } else if (enableNegative == true) {
                                        onChange?.call(num);
                                      }
                                      Get.back();
                                    })
                              ],
                            ),
                          ),
                        ),
                      ],
                    ));
                  },
                  child: FittedBox(
                    child: Center(
                      child: CustomText(
                        currentNumber.toString(),
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_back_ios_new,
                size: 15,
                color: AppColors.white,
              ),
            ],
          ),
        ),
        Positioned(
          left: 40,
          right: 0,
          top: 0,
          bottom: 0,
          child: InkWell(
            onTap: () {
              if (currentNumber > 0 || enableNegative == true) {
                var num = currentNumber - 1;
                onChange?.call(num);
              }
            },
          ),
        ),
        Positioned(
          left: 0,
          right: 40,
          top: 0,
          bottom: 0,
          child: InkWell(
            onTap: () {
              if (currentNumber < 31) {
                var num = currentNumber + 1;
                onChange?.call(num);
              }
            },
          ),
        ),
      ],
    );
  }
}
