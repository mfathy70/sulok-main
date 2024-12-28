import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sulok/helper/custom/custom_drop_down.dart';
import 'package:sulok/helper/custom/custom_text_feild.dart';
import 'package:sulok/screens/login/model/login_teacher_respone.dart';
import 'package:sulok/screens/mainteacher/main_teacer_screen.dart';
import 'package:sulok/screens/teacherprograms/add_program_controller.dart';
import 'package:sulok/screens/teacherprograms/levels/stages/tasks/add_task_controller.dart';
import '../../../../../constant/app_colors.dart';
import '../../../../../helper/custom/custom_button.dart';
import '../../../../../helper/custom/custom_tab_selecter.dart';
import '../../../../../helper/custom/custom_text.dart';
import '../../../../../helper/custom/number_box.dart';
import '../../../../../helper/custom/white_screen.dart';

class AddTaskScreen extends StatelessWidget {
  final Task? task;

  const AddTaskScreen({Key? key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddTaskController>(
        init: AddTaskController(task: task),
        builder: (con) {
          print("here ${con.isLinkWithNumber}");
          return WhiteScreen(
            title: 'مهمة جديدة',
            onTapHome: () {
              Get.offAll(Get.offAll(const MainTeacherScreen()));
            },
            onTapBack: () {
              if (con.currentScreen == 2) {
                con.currentScreen = 1;
                con.update();
              } else {
                Get.back();
              }
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                  top: 30, right: 30, left: 30, bottom: 90),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Text(task?.toJson().toString()??"",textDirection: TextDirection.ltr),
                  currentScreen(con),
                  const SizedBox(
                    height: 45,
                  ),
                  CustomButton(
                    height: 65,
                    color: AppColors.amberSecond,
                    title: con.currentScreen == 1 ? 'التالي' : "اضافة جديد",
                    pressed: () {
                      if (con.currentScreen == 1) {
                        con.currentScreen = 2;
                        con.update();
                      } else {
                        con.submit();
                      }
                    },
                  ),
                  Visibility(
                    visible: task != null && con.currentScreen == 2,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: CustomButton(
                        height: 65,
                        color: AppColors.greenMain,
                        title: 'حفظ',
                        pressed: () {
                          con.updateTask();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget firstScreen(AddTaskController con) {
    print("here ${con.isLinkWithNumber}");
    return Column(
      children: [
        CustomTextField(
          hintText: 'أسم المهمة',
          controller: con.name,
        ),
        CustomTextField(
          maxLines: 4,
          hintText: 'الوصف',
          controller: con.info,
        ),
        CustomTextField(
          maxLines: 1,
          hintText: 'رابط - يوتيوب , ملف كتاب pdf , صفحة إنترنت',
          controller: con.url,
        ),
        CustomTabSelector(
          items: con.startConditions,
          label: 'شرط البدء ؟ ',
          selectedItem:
              con.selectedStartCondition ?? Item(name: 'اختر', id: '0'),
          onChange: (v) {
            con.selectedStartCondition = v;
            con.selectedStartConditionItem = null;
            con.update();
          },
        ),
        Visibility(
          visible: con.selectedStartCondition?.id == '1',
          child: CustomDropdown(
              listItems: con.startConditionsItems,
              selectedItem:
                  con.selectedStartConditionItem ?? Item(name: 'اختر', id: '0'),
              onSelected: (v) {
                con.selectedStartConditionItem = v;
                con.update();
              }),
        ),
        CustomTabSelector(
          items: con.endConditions,
          label: 'شرط الإنتهاء ؟',
          selectedItem: con.selectedEndCondition ?? Item(name: 'اختر', id: '0'),
          onChange: (v) {
            con.selectedEndCondition = v;
            con.selectedEndConditionItem = null;
            con.update();
          },
        ),
        Visibility(
          visible: con.selectedEndCondition?.id == '1',
          child: CustomDropdown(
              listItems: con.endConditionsItems,
              selectedItem:
                  con.selectedEndConditionItem ?? Item(name: 'اختر', id: '0'),
              onSelected: (v) {
                con.selectedEndConditionItem = v;
                con.update();
              }),
        ),
        // CustomTabSelector(
        //   items: con.durationItems,
        //   label: 'المدة',
        //   selectedItem: con.selectedDuration ?? Item(name: 'اختر', id: '0'),
        //   onChange: (v) {
        //     con.selectedDuration = v;
        //     con.update();
        //   },
        // ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  'مرتبط بعدد',
                  color: AppColors.greyDark,
                  fontWeight: FontWeight.bold,
                ),
                CupertinoSwitch(
                  value: con.isLinkWithNumber,
                  onChanged: (v) {
                    con.isLinkWithNumber = v;
                    con.numberIsLinked = 0;
                    con.update();
                  },
                  activeColor: AppColors.amberSecond,
                )
              ],
            ),
            const Divider(
              color: AppColors.grey,
            ),
            Visibility(
              visible: con.isLinkWithNumber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: NumberBox(
                      offColor: AppColors.grey,
                      currentNumber: con.numberIsLinked,
                      onChange: (v) {
                        con.numberIsLinked = v;
                        con.update();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Expanded(
                    child: CustomText(
                        'العدد المطلوب لكل فترة , إذا إخترت مواقيت الصلاة يتم إعتبار كل وقت فترة , إذا لم يحدد سيتم إعتبار كل يوم فترة '),
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  'مرتبطه بزمن',
                  color: AppColors.greyDark,
                  fontWeight: FontWeight.bold,
                ),
                CupertinoSwitch(
                  value: con.isLinkWithTime,
                  onChanged: (v) {
                    con.isLinkWithTime = v;
                    con.timeIsLinked = 0;
                    con.update();
                  },
                  activeColor: AppColors.amberSecond,
                )
              ],
            ),
            const Divider(
              color: AppColors.grey,
            ),
            Visibility(
              visible: con.isLinkWithTime,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NumberBox(
                    offColor: AppColors.grey,
                    currentNumber: con.timeIsLinked,
                    onChange: (v) {
                      con.timeIsLinked = v;
                      con.update();
                    },
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Expanded(
                    child: CustomText('عدد الأيام'),
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomText(
              'يشترط أن يكون الزمن متواصل',
              color: AppColors.greyDark,
              fontWeight: FontWeight.bold,
            ),
            CupertinoSwitch(
              value: con.continuous,
              onChanged: (v) {
                con.continuous = v;
                con.update();
              },
              activeColor: AppColors.amberSecond,
            )
          ],
        ),
        const Divider(
          color: AppColors.grey,
        ),
      ],
    );
  }

  Widget secScreen(AddTaskController con) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomText(
              'هل يوجد تذكير',
              color: AppColors.greyDark,
              fontWeight: FontWeight.bold,
            ),
            CupertinoSwitch(
              value: con.reminder,
              onChanged: (v) {
                con.reminder = v;
                con.update();
              },
              activeColor: AppColors.amberSecond,
            )
          ],
        ),
        const Divider(
          color: AppColors.grey,
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomText(
              'أوقات الصلاة',
              color: AppColors.greyDark,
              fontWeight: FontWeight.bold,
            ),
            CustomText(
              'الوقت\nبالدقائق',
              color: AppColors.greyDark.withOpacity(0.6),
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              size: 12,
            ),
          ],
        ),
        const Divider(
          color: AppColors.grey,
        ),
        for (var item in con.mainSalawat)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Dismissible(
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (v) {
                con.mainSalawat.remove(item);
                con.update();
              },
              key: Key(item.item.id ?? ""),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.white),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6.0, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(item.item.name ?? ""),
                      NumberBox(
                        currentNumber: item.number,
                        onChange: (v) {
                          item.number = v;
                          con.update();
                        },
                        enableNegative: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.white),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomDropdown(
                      listItems: con.alSalwatList.map((e) => e.item).toList(),
                      selectedItem: con.selectedNewSalah.item,
                      onSelected: (v) {
                        con.selectedNewSalah.item = v;
                        con.update();
                      },
                    ),
                  ),
                  NumberBox(
                    currentNumber: con.selectedNewSalah.number,
                    onChange: (v) {
                      if (con.selectedNewSalah.item.id != '0') {
                        con.selectedNewSalah.number = v;
                        con.mainSalawat.add(con.selectedNewSalah);
                        con.selectedNewSalah = AlSalwat(
                            item: Item(name: 'إختر الصلاة', id: '0'),
                            number: 0);
                        con.update();
                      }
                    },
                    enableNegative: true,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        const CustomText(
          'وزن المهمة',
          color: AppColors.greyDark,
          fontWeight: FontWeight.bold,
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Slider(
              value: con.sliderWight,
              inactiveColor: AppColors.grey,
              divisions: 10,
              activeColor: AppColors.amberSecond,
              min: 0,
              max: 100,
              label: con.sliderWight.toInt().toString(),
              onChanged: (v) {
                con.sliderWight = v;
                con.update();
              }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const CustomText(
                'درجات\nالمهمة',
                fontWeight: FontWeight.bold,
                color: AppColors.greyDark,
                textAlign: TextAlign.center,
                size: 15,
              ),
              const SizedBox(
                width: 15,
              ),
              NumberBox(
                currentNumber: con.grades,
                onChange: (v) {
                  con.grades = v;
                  con.update();
                },
              )
            ],
          ),
        )
      ],
    );
  }

  Widget currentScreen(AddTaskController con) {
    switch (con.currentScreen) {
      case 1:
        return firstScreen(con);
      case 2:
        return secScreen(con);
      default:
        return firstScreen(con);
    }
  }
}
