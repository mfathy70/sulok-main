import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sulok/helper/custom/default_screen.dart';
import 'package:sulok/screens/login/model/student_response.dart';
import 'package:sulok/screens/mainstudentscreen/displayprogram/stage_details_screen.dart';

import '../../../constant/app_colors.dart';
import '../../../helper/custom/custom_text.dart';
import '../../../helper/local_storage_helper.dart';

class LevelScreen extends StatelessWidget {
  final Program level;

  const LevelScreen({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
        title: level.name ?? "",
        onTapBack: () {
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  level.info ?? "",
                  fontWeight: FontWeight.normal,
                  size: 12,
                ),
                Visibility(
                  visible: level.stage?.isNotEmpty??false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const CustomText("المراحل", color: AppColors.greyDark, size: 20,fontWeight: FontWeight.bold),
                      const SizedBox(
                        height: 30,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: level.stage?.length,
                        itemBuilder: (context, index) {
                          var item = level.stage?[index];
                          return programWidget(item);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget programWidget(Program? item) {
    return StatefulBuilder(builder: (context, update) {
      return InkWell(
        onTap: () {
          Get.to(StageScreen(
            stage: item!,
          ));
        },
        child: Padding(
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
                          CustomText(
                            item?.info ?? "",
                            fontWeight: FontWeight.normal,
                            size: 12,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
