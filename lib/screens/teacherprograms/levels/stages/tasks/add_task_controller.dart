import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sulok/helper/custom/custom_drop_down.dart';
import 'package:sulok/helper/custom/custom_loading.dart';
import 'package:sulok/helper/local_storage_helper.dart';
import 'package:sulok/screens/teacherprograms/add_program_controller.dart';
import 'package:sulok/screens/teacherprograms/levels/stages/tasks/model/add_task_request.dart';

import '../../../../../helper/helper_functions.dart';
import '../../../../login/login_repo.dart';
import '../../../../login/model/login_teacher_respone.dart';
import '../../../add_repo.dart';

class AddTaskController extends GetxController {
  final Task? task;
  int currentScreen = 1;
  TextEditingController name = TextEditingController();
  TextEditingController info = TextEditingController();
  TextEditingController url = TextEditingController();

  List<Item> startConditions = [
    Item(name: 'مقيدة بإنجاز', id: '1'),
    Item(id: '0', name: 'غير مقيدة بإنجاز'),
  ];
  List<Item> startConditionsItems = [];
  Item? selectedStartCondition;
  Item? selectedStartConditionItem;

  ///END
  List<Item> endConditions = [
    Item(name: 'مقيدة بإنجاز', id: '1'),
    Item(id: '0', name: 'غير مقيدة بإنجاز'),
  ];
  List<Item> endConditionsItems = [];
  Item? selectedEndCondition;
  Item? selectedEndConditionItem;

  //Duration
  // List<Item> durationItems = [
  //   // , المستوى , المهمه
  //   Item(name: 'مدة محددة', id: '1'),
  //   Item(name: 'مدى الحياة', id: '0'),
  // ];
  // Item? selectedDuration;

  ///Link with number
  bool isLinkWithNumber = false;
  int numberIsLinked = 0;

  //Linked with time
  bool isLinkWithTime = false;
  int timeIsLinked = 0;

  //time continuous
  bool continuous = false;

  //reminder
  bool reminder = false;

  //Salwat
  List<AlSalwat> mainSalawat = [];
  List<AlSalwat> alSalwatList = [
    AlSalwat(item: Item(name: 'صلاة الفجْر	', id: '1'), number: 0),
    AlSalwat(item: Item(name: 'صلاة الظُّهْر	', id: '2'), number: 0),
    AlSalwat(item: Item(name: 'صلاة العَصر	', id: '3'), number: 0),
    AlSalwat(item: Item(name: 'صلاة المَغرب', id: '4'), number: 0),
    AlSalwat(item: Item(name: 'صلاة العِشاء', id: '5'), number: 0)
  ];

  double sliderWight = 0;

  int grades = 1;
  List<Task> tasks = [];

  AlSalwat selectedNewSalah =
      AlSalwat(item: Item(name: 'إختر الصلاة', id: '0'), number: 0);

  AddTaskController({this.task});

  @override
  void onInit() async {
    // TODO: implement onInit
    await Future.delayed(const Duration(seconds: 1));
    loading();
    tasks.clear();
    await LocalStorageHelper.getTeacherData().then((value) {
      value.programs?.forEach((prog) {
        prog.level?.forEach((level) {
          level.stage?.forEach((stage) {
            stage.task?.forEach((task) {
              tasks.add(task);
            });
          });
        });
      });
    });
    endConditionsItems.clear();
    for (var element in tasks) {
      endConditionsItems
          .add(Item(id: element.id.toString(), name: element.name.toString()));
    }
    startConditionsItems.clear();
    for (var element in tasks) {
      startConditionsItems
          .add(Item(id: element.id.toString(), name: element.name.toString()));
    }
    await Future.delayed(const Duration(seconds: 1));
    update();

    final task = this.task;
    if (task != null) {
      print(task.toJson().toString() ?? "");
      name.text = task.name ?? "";
      info.text = task.info ?? "";
      url.text = task.url ?? "";
      mainSalawat = getSalatFromJson(task.prayer?.replaceAll(' ', ''));
      selectedStartCondition = Item(id: task.startCondition ?? "0");
      selectedStartConditionItem =
          getTaskSelectedByString(task.startCompletion);

      selectedEndCondition = Item(id: task.endCompletion ?? "0");
      selectedEndConditionItem = getTaskSelectedByString(task.endCondition);
      isLinkWithNumber = task.relatedCount == "0" ? false : true;
      numberIsLinked = int.tryParse(task.relatedCount ?? '0') ?? 0;

      isLinkWithTime = (int.tryParse(task.relatedTime ?? '0') ?? 0) > 0;
      timeIsLinked = int.tryParse(task.relatedTime ?? '0') ?? 0;

      continuous = task.mustContinuous == "0" ? false : true;

      reminder = task.reminder?.isNotEmpty ?? false;
      sliderWight = double.tryParse(task.weight ?? '0') ?? 0;
      grades = int.tryParse(task.point ?? '0') ?? 0;
      update();
    }
    closeLoading();
    super.onInit();
  }

  List<AlSalwat> getSalatFromJson(String? input) {
    try {
      if (input == null) return [];
      if (input == '[]') return [];
      // Remove the square brackets to get the content inside
      String cleanedInput = input.replaceAll(RegExp(r'[\[\]]'), '');

      // Split the cleaned string by '},' to separate each map item
      List<String> mapItems = cleanedInput.split('},{');

      // Initialize a list to store the extracted key-value pairs
      List<Map<int, int>> keyValuePairs = [];
      List<AlSalwat> salawatFinal = [];
      // Iterate over each map item
      for (String item in mapItems) {
        // Remove any remaining curly braces from the current item
        String cleanedItem = item.replaceAll(RegExp(r'[{}]'), '');

        // Split the cleaned item by ':' to separate key and value
        List<String> parts = cleanedItem.split(':');

        // Parse key and value as integers
        int key = int.parse(parts[0]);
        int value = int.parse(parts[1]);

        // Create a map with the extracted key-value pair and add it to the list
        Map<int, int> pair = {key: value};
        AlSalwat temp =
            AlSalwat(item: alSalwatList[key - 1].item, number: value);
        salawatFinal.add(temp);
        keyValuePairs.add(pair);
      }
      return salawatFinal;
    } catch (e) {
      return [];
    }
  }

  getTaskSelectedByString(String? input) {
    if (input == null) return;
    try {
      // Remove the surrounding curly braces
      String cleanedInput = input.replaceAll(RegExp(r'[{}]'), '');

      // Split the cleaned string by commas to get key-value pairs
      List<String> keyValuePairs = cleanedInput.split(',');

      // Initialize variables to store the extracted id and name
      int? id;
      String? name;

      // Iterate over each key-value pair
      for (String pair in keyValuePairs) {
        // Split each pair into key and value
        List<String> parts = pair.split(':');

        // Trim leading and trailing whitespace from key and value
        String key = parts[0].trim();
        String value = parts[1].trim();

        // Remove surrounding quotes from value if present
        if (value.startsWith("'") && value.endsWith("'")) {
          value = value.substring(1, value.length - 1);
        }

        // Determine which key we're processing and assign the value accordingly
        if (key == 'id') {
          id = int.tryParse(value) ??
              0; // Parse value as int (default to 0 if parsing fails)
        } else if (key == 'name') {
          name = value;
        }
      }

      // Print the extracted id and name
      print('Extracted ID: $id');
      print('Extracted Name: $name');
      return Item(name: name ?? "", id: id.toString());
    } catch (e) {
      return;
    }
  }

  AddRepo addRepo = AddRepo();

  submit() async {
    loading();
    AddTaskRequest addTaskRequest = AddTaskRequest(
      name: name.text,
      info: info.text,
      url: url.text,
      startCondition: selectedStartCondition?.id,
      startCompletion: selectedStartConditionItem?.toJson().toString() ?? "",
      endCondition: selectedEndCondition?.id,
      endCompletion: selectedEndConditionItem?.toJson().toString() ?? "",
      // duration: selectedDuration?.id,
      mustContinuous: continuous ? '1' : '0',
      weight: sliderWight.toString(),
      reminder: reminder ? '1' : '0',
      point: grades.toString(),
      stageId: Get.find<AddProgramController>().stageID.toString(),
      prayer: mainSalawat.map((e) => e.toJson()).toList().toString(),
      relatedCount: numberIsLinked.toString(),
      relatedTime: timeIsLinked.toString(),
    );
    var response = await addRepo.addTask(addTaskRequest);
    await LoginRepo().refreshTeacherData();
    Get.find<AddProgramController>().update();
    closeLoading();
    if (response.msgNum == 1) {
      Get.back();
    } else {
      HelperFun.showToast(response.msg ?? "");
    }
  }

  updateTask() async {
    loading();
    UpdateTaskRequest addTaskRequest = UpdateTaskRequest(
      name: name.text,
      id: task?.id.toString(),
      info: info.text,
      url: url.text,
      startCondition: selectedStartCondition?.id,
      startCompletion: selectedStartConditionItem?.toJson().toString() ?? "",
      endCompletion: selectedEndCondition?.id,
      endCondition: selectedEndConditionItem?.toJson().toString() ?? "",
      // duration: selectedDuration?.id,
      mustContinuous: continuous ? '1' : '0',
      weight: sliderWight.toString(),
      reminder: reminder ? '1' : '0',
      point: grades.toString(),
      stageId: Get.find<AddProgramController>().stageID.toString(),
      prayer: mainSalawat.map((e) => e.toJson()).toList().toString(),
      relatedCount: numberIsLinked.toString(),
      relatedTime: timeIsLinked.toString(),
    );
    var response = await addRepo.updateTask(addTaskRequest);
    await LoginRepo().refreshTeacherData();
    Get.find<AddProgramController>().update();
    closeLoading();
    if (response.msgNum == 1) {
      Get.back();
    } else {
      HelperFun.showToast(response.msg ?? "");
    }
  }
}

class AlSalwat {
  Item item;
  int number;

  AlSalwat({required this.item, required this.number});

  Map<String, String> toJson() {
    return {item.id.toString(): number.toString()};
  }
}
