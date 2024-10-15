import 'package:flutter/material.dart';
import 'package:sulok/constant/app_colors.dart';
import 'package:sulok/helper/custom/custom_text.dart';

import 'custom_drop_down.dart';

class CustomTabSelector extends StatelessWidget {
  final List<Item> items;
  final Item selectedItem;
  final ValueChanged<Item>? onChange;
  final String label;

  const CustomTabSelector(
      {Key? key,
      required this.label,
      required this.items,
      required this.selectedItem,
      this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label,
            color: AppColors.greyDark,
            fontWeight: FontWeight.bold,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.amberSecond),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  for (var item in items)
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          onChange?.call(item);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: item.id == selectedItem.id
                                  ? AppColors.white
                                  : Colors.transparent),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Center(
                                child: CustomText(
                              item.name ?? "",
                              color: item.id == selectedItem.id
                                  ? AppColors.greyDark
                                  : AppColors.white,
                              fontWeight: FontWeight.bold,
                            )),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
