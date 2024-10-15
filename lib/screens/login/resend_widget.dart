import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../constant/app_colors.dart';
import '../../helper/custom/custom_text.dart';

class ResendWidget extends StatefulWidget {
  final GestureTapCallback? onTap;

  const ResendWidget({super.key, this.onTap});

  @override
  State<ResendWidget> createState() => _ResendWidgetState();
}

class _ResendWidgetState extends State<ResendWidget>
    with TickerProviderStateMixin {
  late AnimationController _controllerTime;
  TextEditingController textEditingController = TextEditingController();
  bool isResend = false;

  // ..text = "123456";

  late StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    _controllerTime = AnimationController(
        vsync: this, duration: const Duration(minutes: 1)
        // gameData.levelClock is a user entered number elsewhere in the applciation
        );
    _controllerTime.forward().whenComplete(() {
      if (mounted) {
        setState(() {
          isResend = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    _controllerTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !isResend
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                'إعادة الإرسال بعد',
                size: 16,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
                color: AppColors.whiteGrey,
              ),
              Countdown(
                animation: StepTween(
                  begin: 60,
                  end: 0,
                ).animate(_controllerTime),
              )
            ],
          )
        : Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap:(){
                    widget.onTap?.call();
                    setState(() {
                      isResend = false;
                      _controllerTime = AnimationController(
                          vsync: this,
                          duration: const Duration(minutes: 1)
                        // gameData.levelClock is a user entered number elsewhere in the applciation
                      );
                      _controllerTime.forward().whenComplete(() {
                        setState(() {
                          isResend = true;
                        });
                      });
                    });
                  },
                  child: const CustomText(
                    'إعادة الإرسال',
                    size: 16,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                    color: AppColors.amberSecond,
                  ),
                ),
              ],
            ),
          );
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;
  bool isTimeout = false;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    if (timerText == '0') {
      timerText = '0';
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        timerText,
        style: const TextStyle(
            color: AppColors.whiteGrey, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
