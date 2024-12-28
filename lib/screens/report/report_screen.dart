import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sulok/constant/app_colors.dart';
import 'package:sulok/constant/const_var.dart';
import 'package:sulok/helper/custom/custom_text.dart';
import 'package:sulok/helper/custom/default_screen.dart';
import 'package:sulok/screens/mystudents/student_details_screen.dart';
import '../../helper/custom/custom_drop_down.dart';
import '../../helper/local_storage_helper.dart';
import '../login/model/login_teacher_respone.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      title: 'التقارير',
      onTapBack: () {
        Get.back();
      },
      child: SafeArea(
        child: FutureBuilder(
          future: LocalStorageHelper.getTeacherData(),
          builder: (BuildContext context,
              AsyncSnapshot<LoginTeacherResponse> teacher) {
            if (teacher.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: teacher.data?.salik?.active?.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = teacher.data?.salik?.active?[index];
                      return studentCard(item);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  studentCard(Student? item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () {
          Get.to(StudentDetailsScreen(student: item!));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
          ),
          child: Row(
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
                    CustomText(
                      item?.name ?? "",
                      fontWeight: FontWeight.bold,
                      size: 18,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomText(
                      "النقاط",
                      fontWeight: FontWeight.bold,
                      color: AppColors.greyDark,
                      size: 15,
                    ),
                    CustomText(
                      item?.points ?? "0",
                      fontWeight: FontWeight.bold,
                      color: AppColors.greyDark,
                      size: 15,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
