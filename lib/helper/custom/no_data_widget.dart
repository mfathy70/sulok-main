import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constant/app_colors.dart';
import '../../constant/app_images.dart';

class NoDataWidget extends StatelessWidget {
  final String? title;

  const NoDataWidget({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SvgPicture.asset(AppImages.logo, height: 50),
      const SizedBox(
        height: 20,
      ),
      Text(title.toString(), style: const TextStyle(fontSize: 20)),
    ]);
  }
}
