import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant/app_colors.dart';

class CustomTextField<T> extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      this.controller,
      this.maxLines,
      this.inputFormatters,
      this.hintText,
      this.validator,
      this.suffixSvgIconName,
      this.title,
      this.autoFocus,
      this.lightLabel,
      this.inputType,
      this.suffixIcon,
      this.initialValue,
      this.showTitle,
      this.isSecure,
      this.onchange,
      this.isRequired})
      : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final int? maxLines;
  final String? title;
  final bool? isRequired;
  final bool? isSecure;
  final bool? showTitle;
  final bool? autoFocus;
  final bool? lightLabel;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final String? suffixSvgIconName;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final ValueChanged? onchange;
  final FormFieldValidator<String?>? validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 3.0),
          child: Row(
            children: [
              if (widget.showTitle ?? true)
                Text(widget.title ?? "",
                    style: TextStyle(
                        fontSize: 15,
                        color: widget.lightLabel == true
                            ? AppColors.whiteGrey
                            : AppColors.greyDark,
                        fontWeight: FontWeight.w500)),
              if (widget.isRequired ?? false)
                const Text("*", style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        TextFormField(
          initialValue: widget.initialValue,
          maxLines: widget.isSecure == true ? 1 : widget.maxLines,
          autofocus: widget.autoFocus ?? false,
          keyboardType: widget.inputType,
          validator: widget.validator,
          onChanged: widget.onchange,
          controller: widget.controller,
          obscureText: widget.isSecure ?? false,
          inputFormatters: widget.inputFormatters,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            filled: true,
            fillColor: AppColors.white,
            suffixIcon: widget.suffixIcon ??
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: (widget.suffixSvgIconName?.isNotEmpty ?? false)
                      ? SvgPicture.asset(
                          widget.suffixSvgIconName ?? "",
                          height: 2,
                        )
                      : null,
                ),
            hintText: widget.hintText,
            hintStyle:
                TextStyle(color: Colors.grey.withOpacity(.8), fontSize: 14),
            helperStyle: TextStyle(color: Colors.black.withOpacity(.5)),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: Colors.transparent, width: 2)),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              // borderSide:
              //     BorderSide(color: AppColors.textColor, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
