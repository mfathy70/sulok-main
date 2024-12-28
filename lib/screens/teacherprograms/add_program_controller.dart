import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sulok/helper/custom/custom_loading.dart';
import 'package:sulok/helper/helper_functions.dart';
import 'package:sulok/screens/login/login_repo.dart';
import 'package:sulok/screens/login/model/login_teacher_respone.dart';
import 'package:sulok/screens/teacherprograms/add_repo.dart';
import 'package:sulok/screens/teacherprograms/levels/model/add_level_request.dart';
import 'package:sulok/screens/teacherprograms/model/add_program_request.dart';
import 'package:sulok/screens/teacherprograms/model/add_response.dart';

import '../../helper/local_storage_helper.dart';
import 'levels/stages/model/add_stage_request.dart';

class AddProgramController extends GetxController {
  TextEditingController programName = TextEditingController();
  TextEditingController programInfo = TextEditingController();
  TextEditingController levelName = TextEditingController();
  TextEditingController levelInfo = TextEditingController();
  TextEditingController stageName = TextEditingController();
  TextEditingController stageInfo = TextEditingController();
  AddRepo addRepo = AddRepo();

  int? programID;
  int? levelID;
  int? stageID;
  int? taskID;

  Future<List<Program>> getLevelsByProgramID() async {
    var teacher = await LocalStorageHelper.getTeacherData();
    return teacher.programs
            ?.where((element) => element.id == programID)
            .first
            .level ??
        [];
  }

  Future<List<Program>> getStagesByLevelID() async {
    var levels = await getLevelsByProgramID();
    return levels
            .where((element) => element.id == levelID)
            .toList()
            .first
            .stage ??
        [];
  }

  Future<List<Task>> getTasksByStageID() async {
    var levels = await getStagesByLevelID();
    return levels
            .where((element) => element.id == stageID)
            .toList()
            .first
            .task ??
        [];
  }

  addNewProgram() async {
    if (programName.text.isNotEmpty) {
      loading();
      AddResponse addResponse = await addRepo.addProgram(
          AddProgramRequest(name: programName.text, info: programInfo.text));
      if (addResponse.msgNum == 1) {
        await LoginRepo().refreshTeacherData();
        closeLoading();
        programName.clear();
        programInfo.clear();
        Future.delayed(const Duration(seconds: 1)).then((value) => Get.back());
      } else {
        closeLoading();
        HelperFun.showToast(addResponse.msg ?? "");
      }
    } else {
      HelperFun.showToast('جميع الحقول مطلوبه');
    }
    update();
  }

  updateProgram(Program program) async {
    if (programName.text.isNotEmpty) {
      loading();
      AddResponse addResponse = await addRepo.updateProgram(
          UpdateProgramRequest(
              name: programName.text,
              info: programInfo.text,
              id: program.id.toString()));
      if (addResponse.msgNum == 1) {
        await LoginRepo().refreshTeacherData();
        closeLoading();
        programName.clear();
        programInfo.clear();
        Future.delayed(const Duration(seconds: 1)).then((value) => Get.back());
      } else {
        closeLoading();
        HelperFun.showToast(addResponse.msg ?? "");
      }
    } else {
      HelperFun.showToast('جميع الحقول مطلوبه');
    }
    update();
  }

  addNewLevel(int programID) async {
    if (levelName.text.isNotEmpty) {
      loading();
      AddResponse addResponse = await addRepo.addLevel(AddLevelRequest(
          name: levelName.text,
          info: levelInfo.text,
          programID: programID.toString()));
      if (addResponse.msgNum == 1) {
        await LoginRepo().refreshTeacherData();
        closeLoading();
        levelName.clear();
        levelInfo.clear();
        Future.delayed(const Duration(seconds: 1)).then((value) => Get.back());
      } else {
        closeLoading();
        HelperFun.showToast(addResponse.msg ?? "");
      }
    } else {
      HelperFun.showToast('جميع الحقول مطلوبه');
    }

    update();
  }

  updateLevel(int programID, int levelId) async {
    if (levelName.text.isNotEmpty) {
      loading();
      AddResponse addResponse = await addRepo.updateLevel(UpdateLevelRequest(
          name: levelName.text,
          info: levelInfo.text,
          id: levelId.toString(),
          programID: programID.toString()));
      if (addResponse.msgNum == 1) {
        await LoginRepo().refreshTeacherData();
        closeLoading();
        levelName.clear();
        levelInfo.clear();
        Future.delayed(const Duration(seconds: 1)).then((value) => Get.back());
      } else {
        closeLoading();
        HelperFun.showToast(addResponse.msg ?? "");
      }
    } else {
      HelperFun.showToast('جميع الحقول مطلوبه');
    }

    update();
  }

  addNewStage() async {
    if (stageName.text.isNotEmpty) {
      loading();
      AddResponse addResponse = await addRepo.addStage(AddStageRequest(
          name: stageName.text,
          info: stageInfo.text,
          levelID: levelID.toString()));
      if (addResponse.msgNum == 1) {
        await LoginRepo().refreshTeacherData();
        closeLoading();
        stageName.clear();
        stageInfo.clear();
        Future.delayed(const Duration(seconds: 1)).then((value) => Get.back());
      } else {
        closeLoading();
        HelperFun.showToast(addResponse.msg ?? "");
      }
    } else {
      HelperFun.showToast('جميع الحقول مطلوبه');
    }
    update();
  }

  updateStage(int stageId) async {
    if (stageName.text.isNotEmpty) {
      loading();
      AddResponse addResponse = await addRepo.updateStage(UpdateStageRequest(
          name: stageName.text,
          info: stageInfo.text,
          id: stageId.toString(),
          levelID: levelID.toString()));
      if (addResponse.msgNum == 1) {
        await LoginRepo().refreshTeacherData();
        closeLoading();
        stageName.clear();
        stageInfo.clear();
        Future.delayed(const Duration(seconds: 1)).then((value) => Get.back());
      } else {
        closeLoading();
        HelperFun.showToast(addResponse.msg ?? "");
      }
    } else {
      HelperFun.showToast('جميع الحقول مطلوبه');
    }
    update();
  }

  deleteProgram() async {
    Get.back();
    Get.back();
    loading();
    var addResponse = await addRepo.delete('program_id', programID.toString());
    if (addResponse.msgNum == 1) {
      await LoginRepo().refreshTeacherData();
      closeLoading();
    } else {
      closeLoading();
      HelperFun.showToast(addResponse.msg ?? "");
    }

    update();
  }

  deleteLevel() async {
    Get.back();
    Get.back();
    loading();
    var addResponse = await addRepo.delete('level_id', levelID.toString());
    if (addResponse.msgNum == 1) {
      await LoginRepo().refreshTeacherData();
      closeLoading();
    } else {
      closeLoading();
      HelperFun.showToast(addResponse.msg ?? "");
    }

    update();
  }

  deleteStage() async {
    Get.back();
    Get.back();
    loading();
    var addResponse = await addRepo.delete('stage_id', stageID.toString());
    if (addResponse.msgNum == 1) {
      await LoginRepo().refreshTeacherData();
      closeLoading();
    } else {
      closeLoading();
      HelperFun.showToast(addResponse.msg ?? "");
    }

    update();
  }

  deleteTask(String id) async {
    Get.back();
    loading();
    var addResponse = await addRepo.delete('task_id', id);
    if (addResponse.msgNum == 1) {
      await LoginRepo().refreshTeacherData();
      closeLoading();
    } else {
      closeLoading();
      HelperFun.showToast(addResponse.msg ?? "");
    }

    update();
  }

  Future<Program> getProgramById() async {
    var teacher = await LocalStorageHelper.getTeacherData();
    return teacher.programs
            ?.where((element) => element.id == programID)
            .first ??
        Program();
  }
}
