import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/app_colors.dart';

class CustomDropdown extends StatefulWidget {
  final List<Item> listItems;
  final Item? selectedItem;
  final ValueChanged<Item>? onSelected;

  const CustomDropdown({
    super.key,
    required this.listItems,
    this.selectedItem,
    this.onSelected,
  });

  @override
  CustomDropdownState createState() => CustomDropdownState();
}

class CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: AppColors.white),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButton<Item>(
                menuMaxHeight: Get.height / 3,
                isExpanded: true,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.greyDark,
                ),
                focusColor: const Color(0xff00114F),
                borderRadius: BorderRadius.circular(10),
                underline: const SizedBox(),
                iconEnabledColor: Colors.black,
                dropdownColor: Colors.grey.shade200,
                items:
                    widget.listItems.map<DropdownMenuItem<Item>>((Item value) {
                  return DropdownMenuItem<Item>(
                    value: value,
                    child: Text(
                      value.name ?? "",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
                onChanged: (Item? newValue) {
                  if (newValue != null) {
                    widget.onSelected?.call(newValue);
                  }
                },
                hint: Text(
                  widget.selectedItem?.name ?? '',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                )),
          ),
        ),
      ],
    );
  }
}

class Item {
  String? id;
  String? name;
  String? parentID;
  bool isSelected = false;

  Item({this.id, this.name, this.parentID});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"].toString(),
        name: json["name"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
