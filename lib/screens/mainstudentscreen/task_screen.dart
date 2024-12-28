import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sulok/helper/custom/custom_text.dart';
import 'package:sulok/helper/custom/default_screen.dart';
import 'package:sulok/screens/login/model/student_response.dart';
import 'package:sulok/screens/mainstudentscreen/main_student_screen_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../constant/app_colors.dart';
import '../../helper/custom/custom_button.dart';
import '../../helper/custom/custom_text_feild.dart';

class TaskScreenDetails extends StatefulWidget {
  final Task task;

  const TaskScreenDetails({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskScreenDetails> createState() => _TaskScreenDetailsState();
}

class _TaskScreenDetailsState extends State<TaskScreenDetails> {
  WebViewController? controller;

  @override
  void initState() {
    print(widget.task.relatedCount);
    if (widget.task.url?.isNotEmpty ?? false) {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
          ),
        )
        ..loadRequest(Uri.parse(widget.task.url ?? ""));
    }
    if (mounted) {
      setState(() {});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
        title: widget.task.name,
        onTapBack: () {
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(widget.task.info ?? ""),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        info('مدة المهمه', widget.task.relatedTime, 'يوم'),
                        info('تكرار الذكر', widget.task.relatedCount, 'مرة'),
                        widget.task.remainingCount.toString() !=
                                widget.task.relatedCount
                            ? info('العدد المتبقي',
                                widget.task.remainingCount.toString(), 'مرة')
                            : Container(),
                        info('وزن المهمة', widget.task.weight, '%'),
                        info('درجة المهمة', widget.task.point, 'درجة'),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GetBuilder<MainStudentScreenController>(
                        builder: (controller) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if (widget.task.iscount.toString() == '1' ||
                                    widget.task.relatedCount != "0") {
                                  TextEditingController valueController =
                                      TextEditingController();
                                  Get.dialog(Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Dialog(
                                        backgroundColor: AppColors.whiteGrey,
                                        child: Padding(
                                          padding: const EdgeInsets.all(30.0),
                                          child: Column(
                                            children: [
                                              const Text(
                                                  'هذه المهمه مرتبطه بعدد ادخل العدد'),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              CustomTextField(
                                                controller: valueController,
                                                inputType: TextInputType.number,
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              CustomButton(
                                                  color: AppColors.greenMain,
                                                  title: 'حفظ كمُنجز',
                                                  pressed: () {
                                                    Get.back();
                                                    controller.complete(
                                                        widget.task.id
                                                                .toString() ??
                                                            "",
                                                        count: valueController
                                                            .text);
                                                  })
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ));
                                } else {
                                  controller
                                      .complete(widget.task.id.toString());
                                }
                              },
                              child: Container(
                                color: AppColors.amberSecond,
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: CustomText(
                                      'تحديد المهمة كمكتملة',
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // const SizedBox(
                          //   width: 20,
                          // ),
                          // Expanded(
                          //   child: InkWell(
                          //     onTap: () {
                          //       controller
                          //           .unComplete(widget.task.id.toString());
                          //     },
                          //     child: Container(
                          //       color: AppColors.amberSecond,
                          //       child: const Padding(
                          //         padding: EdgeInsets.all(8.0),
                          //         child: Center(
                          //           child: CustomText(
                          //             'تحديد المهمة كغير مكتملة',
                          //             color: AppColors.white,
                          //             fontWeight: FontWeight.bold,
                          //             size: 12,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                if (controller != null)
                  GestureDetector(
                    onVerticalDragUpdate: (details) {},
                    child: SizedBox(
                        height: Get.height / 2.05,
                        child: WebViewWidget(
                          controller: controller!,
                        )),
                  ),
              ],
            ),
          ),
        ));
  }

  Widget info(String label, String? info, String additionalInfo) {
    return Visibility(
      visible: (info?.isNotEmpty ?? false),
      child: Expanded(
        child: Column(
          children: [
            CustomText(
              label,
              // color: AppColors.greyDark,
              size: 12,
            ),
            CustomText(
              '${info ?? ""} $additionalInfo',
              // color: AppColors.greyDark,
              fontWeight: FontWeight.bold, size: 12,
            ),
          ],
        ),
      ),
    );
  }
}
