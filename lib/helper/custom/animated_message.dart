import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sulok/constant/app_colors.dart';
import 'package:sulok/constant/app_images.dart';
import 'package:sulok/helper/custom/shake_widget.dart';

import 'custom_text.dart';

class AnimatedMessage extends StatefulWidget {
  final String message;
  final bool? success;

  const AnimatedMessage({Key? key, required this.message, this.success})
      : super(key: key);

  @override
  State<AnimatedMessage> createState() => _AnimatedMessageState();
}

class _AnimatedMessageState extends State<AnimatedMessage>
    with SingleTickerProviderStateMixin {
  final messageShakeController = GlobalKey<ShakeWidgetState>();

  @override
  void initState() {
    // TODO: implement initState
    swipe();
    super.initState();
  }

  swipe() async {
    await Future.delayed(const Duration(milliseconds: 100)).then((value) {
      if (mounted) {
        setState(() {
          show = !show;
        });
      }
    });
    await Future.delayed(const Duration(milliseconds: 200)).then((value) => messageShakeController.currentState?.shake());
    await Future.delayed(const Duration(seconds: 4)).then((value) {
      setState(() {
        show = false;
      });

      Future.delayed(const Duration(milliseconds: 300)).then((value) {
        Get.back();
      });
    });
  }

  bool show = false;

  @override
  Widget build(BuildContext context) {
    log(widget.message.toString());
    return GestureDetector(
      onTap: () {
        setState(() {
          show = false;
        });
        Future.delayed(const Duration(milliseconds: 300))
            .then((value) => Get.back());
      },
      child: SizedBox(
        width: Get.width,
        // height: 180,
        child: Stack(
          children: [
            AnimatedPositioned(
              bottom: 60,
              left: show ? 20 : 500,
              right: show ? 20 : -500,
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    show = false;
                  });
                  Future.delayed(const Duration(milliseconds: 300))
                      .then((value) => Get.back());
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ShakeWidget(
                    key: messageShakeController,
                    shakeOffset: 10,
                    shakeCount: 1,
                    shakeDuration: const Duration(milliseconds: 300),
                    child: Container(
                      // width:Get.width,
                      // height: 65,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11),
                                  color: AppColors.amberOpsity),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  widget.success == true
                                      ? AppImages.success
                                      : AppImages.alert,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: CustomText(
                                widget.message,
                                size: 13,
                                color: AppColors.whiteGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
