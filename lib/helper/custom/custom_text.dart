import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String data;
  final TextAlign? textAlign;
  final double? size;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;

  const CustomText(this.data,
      {super.key,
      this.size,
      this.maxLines,
      this.fontWeight,
      this.color,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.clip,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: size,
        overflow: TextOverflow.clip,
      ),
    );
  }
}
