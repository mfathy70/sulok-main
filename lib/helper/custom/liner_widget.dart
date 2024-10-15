import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GradientContainer extends StatelessWidget {
  final double percentage;
  final List<Color> colors;

  const GradientContainer({super.key, required this.percentage, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [percentage, percentage],
        ),
      ),
      child: FractionallySizedBox(
        widthFactor: percentage,
        child: Container(
          color: Colors.transparent, // Set to transparent to see the gradient
        ),
      ),
    );
  }
}