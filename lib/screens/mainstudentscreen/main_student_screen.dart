import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sulok/helper/custom/custom_text.dart';
import 'package:sulok/screens/completestudent/complete_student_screen.dart';
import 'package:sulok/screens/login/model/student_response.dart';
import 'package:sulok/screens/mainstudentscreen/main_student_screen_controller.dart';
import 'package:sulok/screens/mainstudentscreen/student_main_repo.dart';
import 'package:sulok/screens/mainstudentscreen/task_screen.dart';
import '../../constant/app_colors.dart';
import '../../constant/app_images.dart';
import '../../helper/custom/custom_button.dart';
import '../../helper/custom/custom_text_feild.dart';
import '../../helper/local_storage_helper.dart';
import '../menu/menu_screen.dart';
import '../studentnotification/student_notification_screen.dart';

class MainStudentScreen extends StatefulWidget {
  const MainStudentScreen({Key? key}) : super(key: key);

  @override
  State<MainStudentScreen> createState() => _MainStudentScreenState();
}

class _MainStudentScreenState extends State<MainStudentScreen> {
  String from = DateFormat('y-MM-d').format(DateTime.now());
  String to =
      DateFormat('y-MM-d').format(DateTime.now().add(const Duration(days: 1)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: AppColors.white,
      body: GetBuilder<MainStudentScreenController>(
          init: MainStudentScreenController(),
          builder: (controller) {
            return SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(const CompleteStudentScreen(
                                  updateData: true,
                                ));
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.grey,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(const StudentNotificationScreen());
                              },
                              child: Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: AppColors.amberSecond,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: SvgPicture.asset(
                                            AppImages.notification),
                                      ),
                                    ),
                                    Positioned(
                                        top: 0,
                                        left: 0,
                                        // bottom: 0,
                                        child: FutureBuilder(
                                            future: LocalStorageHelper
                                                .getStudentData(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<StudentResponse>
                                                    snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return SizedBox(
                                                    height: Get.height,
                                                    child: const Center(
                                                        child:
                                                            CupertinoActivityIndicator()));
                                              }
                                              var lngth = snapshot
                                                  .data?.notification?.length;
                                              if ((lngth ?? 0) > 0) {
                                                return Container(
                                                    width: 25,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          AppColors.amberSecond,
                                                      border: Border.all(
                                                          color: AppColors
                                                              .greenMain,
                                                          width: 3),
                                                    ),
                                                    child: Center(
                                                        child: CustomText(
                                                      lngth.toString(),
                                                      color: AppColors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      size: 12,
                                                    )));
                                              }
                                              return SizedBox(
                                                  height: Get.height,
                                                  child: const Center(
                                                      child:
                                                          CupertinoActivityIndicator()));
                                            }))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const CustomText(
                          'الرئيسية',
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                          size: 25,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(const MenuScreen(isTeacher: false),
                                fullscreenDialog: true);
                          },
                          child: SizedBox(
                            width: 45,
                            height: 45,
                            child: Align(
                              alignment: Alignment.center,
                              child: SvgPicture.asset(AppImages.menu),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Container(
                            color: AppColors.greenMain,
                            height: 160,
                            width: Get.width,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  left: 0,
                                  bottom: 0,
                                  child: SizedBox(
                                    height: 160,
                                    width: Get.width,
                                    child: Container(
                                      color: AppColors.greenMain,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 70.0),
                                            child: Container(
                                              height: 160 - 70,
                                              width: Get.width,
                                              decoration: const BoxDecoration(
                                                  color: AppColors.whiteGrey,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  25),
                                                          topLeft:
                                                              Radius.circular(
                                                                  25))),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  bottom: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      for (var day in controller.days)
                                        InkWell(
                                          onTap: () {
                                            controller.currentIndex =
                                                controller.days.indexOf(day);
                                            from = DateFormat('y-MM-d').format(
                                                controller.days[
                                                    controller.currentIndex]);
                                            to = DateFormat('y-MM-d').format(
                                                controller.days[
                                                        controller.currentIndex]
                                                    .add(const Duration(
                                                        days: 1)));

                                            controller.update();
                                          },
                                          child: Container(
                                            height: 150,
                                            width: 58,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: AppColors.amberSecond,
                                              gradient: day.day ==
                                                      DateTime.now().day
                                                  ? const LinearGradient(
                                                      colors: [
                                                        AppColors.greenMain,
                                                        AppColors.amberSecond
                                                      ],
                                                      begin:
                                                          Alignment.bottomLeft,
                                                      end: Alignment.topRight,
                                                      stops: [0.00005, 1.0])
                                                  : null,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      CustomText(
                                                        DateFormat('dd')
                                                            .format(day),
                                                        color: AppColors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      CustomText(
                                                        DateFormat('EEEE', 'ar')
                                                            .format(day),
                                                        color: AppColors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        size: 12,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                  const Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: AppColors.white,
                                                  ),
                                                  const SizedBox(),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: AppColors.whiteGrey,
                            child: Column(
                              children: [
                                SizedBox(
                                    height: Get.height * 0.58,
                                    child: currentWidget(controller)),
                                SizedBox(
                                  width: Get.width,
                                  height: 100,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          left: 0,
                                          bottom: 0,
                                          child: SvgPicture.asset(
                                              AppImages.amberLayer)),
                                      Positioned(
                                          left: 0,
                                          bottom: 0,
                                          child: SvgPicture.asset(
                                              AppImages.greenLayer)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget currentWidget(MainStudentScreenController controller) {
    switch (controller.currentIndex) {
      case 2:
        return FutureBuilder(
            future: LocalStorageHelper.getStudentData(),
            builder: (BuildContext context,
                AsyncSnapshot<StudentResponse> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CupertinoActivityIndicator();
              }
              if (snapshot.data?.tasks?.isEmpty ?? true) {
                return const Padding(
                  padding: EdgeInsets.all(30.0),
                  child: CustomText('لايوجد عناصر يمكن عرضها',
                      color: AppColors.greenMain,
                      fontWeight: FontWeight.bold,
                      size: 30),
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    controller.update();
                  });
                },
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  padding: const EdgeInsets.only(
                      top: 25, left: 25, right: 25, bottom: 20),
                  itemCount: snapshot.data?.tasks?.length,
                  itemBuilder: (context, index) {
                    var task = snapshot.data?.tasks?[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 17.0),
                      child: Dismissible(
                        confirmDismiss: (direction) async {
                          if (task?.isPermanent == 1) {
                            return false;
                          }
                          return true;
                        },
                        key: Key(task?.id.toString() ?? ""),
                        background: Row(
                          children: [
                            Expanded(
                                child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.amberSecond,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          'مُنجز',
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold,
                                          size: 25,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                            Expanded(
                                child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.greenMain,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          'مُنجز',
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold,
                                          size: 25,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                          ],
                        ),
                        onDismissed: (v) {
                          if (task?.iscount.toString() == '1' ||
                              task?.relatedCount != "0") {
                            TextEditingController valueController =
                                TextEditingController();
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
                                                  task?.id.toString() ?? "",
                                                  count: valueController.text);
                                            })
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ));
                          } else {
                            controller.complete(task?.id.toString() ?? "");
                          }
                        },
                        child: cardWidget(task, controller),
                      ),
                    );
                  },
                ),
              );
            });
      default:
        return FutureBuilder(
            future: StudentMainRepo().getCompletedTasks(from, to),
            builder: (BuildContext context,
                AsyncSnapshot<List<CompletedTask>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                    height: Get.height,
                    child: const Center(child: CupertinoActivityIndicator()));
              }
              if (snapshot.data?.isEmpty ?? true) {
                return const Padding(
                  padding: EdgeInsets.all(30.0),
                  child: CustomText('لايوجد عناصر يمكن عرضها',
                      color: AppColors.greenMain,
                      fontWeight: FontWeight.bold,
                      size: 30),
                );
              }
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                    top: 25, left: 25, right: 25, bottom: 20),
                shrinkWrap: true,
                // physics:
                //     const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  var program = snapshot.data?[index];
                  return programWidget(program, controller);
                },
              );
            });
    }
  }

  Widget cardWidget(Task? item, MainStudentScreenController controller) {
    return StatefulBuilder(builder: (context, update) {
      return InkWell(
        onTap: () {
          Get.to(TaskScreenDetails(
            task: item,
          ));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 5,
                      height: 60,
                      color: AppColors.amberSecond,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            item?.isPermanent == 1
                                ? const Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Icon(
                                      Icons.push_pin_rounded,
                                      size: 15,
                                      color: AppColors.greyDark,
                                    ),
                                  )
                                : Container(),
                            CustomText(
                              item?.name ?? "",
                              fontWeight: FontWeight.bold,
                              size: 17,
                            ),
                          ],
                        ),
                        CustomText(
                          item?.info ?? "",
                          fontWeight: FontWeight.normal,
                          size: 12,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      item.isOpen = !item.isOpen;
                      update(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        !item!.isOpen
                            ? Icons.arrow_drop_down_rounded
                            : Icons.arrow_drop_up_rounded,
                        color: AppColors.greyDark,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
              Visibility(
                visible: item.isOpen,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          info('مدة المهمه', item.relatedTime, 'يوم'),
                          info('تكرار الذكر', item.relatedCount, 'مرة'),
                          item.remainingCount.toString() != item.relatedCount
                              ? info('العدد المتبقي',
                                  item.remainingCount.toString(), 'مرة')
                              : Container(),
                          info('وزن المهمة', item.weight, '%'),
                          info('درجة المهمة', item.point, 'درجة'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          item.isPermanent == 1
                              ? Container()
                              : Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      if (item.iscount.toString() == '1' ||
                                          item.relatedCount != "0") {
                                        TextEditingController valueController =
                                            TextEditingController();
                                        Get.dialog(Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Dialog(
                                              backgroundColor:
                                                  AppColors.whiteGrey,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(30.0),
                                                child: Column(
                                                  children: [
                                                    const Text(
                                                        'هذه المهمه مرتبطه بعدد ادخل العدد'),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    CustomTextField(
                                                      controller:
                                                          valueController,
                                                      inputType:
                                                          TextInputType.number,
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    CustomButton(
                                                        color:
                                                            AppColors.greenMain,
                                                        title: 'حفظ كمُنجز',
                                                        pressed: () {
                                                          Get.back();
                                                          controller.complete(
                                                              item.id
                                                                  .toString(),
                                                              count:
                                                                  valueController
                                                                      .text);
                                                        })
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ));
                                      } else {
                                        controller.complete(item.id.toString());
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
                          //       controller.unComplete(item.id.toString());
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
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget programWidget(
      CompletedTask? item, MainStudentScreenController controller) {
    return StatefulBuilder(builder: (context, update) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 5,
                            height: 60,
                            color: AppColors.amberSecond,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          item?.name ?? "",
                          fontWeight: FontWeight.bold,
                          size: 17,
                          maxLines: 1,
                        ),
                        // CustomText(
                        //   item?.info ?? "",
                        //   fontWeight: FontWeight.normal,
                        //   size: 12,
                        //   maxLines: 2,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
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
