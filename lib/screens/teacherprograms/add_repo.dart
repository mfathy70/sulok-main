import 'package:sulok/network/api_response_model.dart';
import 'package:sulok/screens/teacherprograms/levels/stages/tasks/model/add_task_request.dart';
import 'package:sulok/screens/teacherprograms/model/add_program_request.dart';

import '../../constant/global_functions.dart';
import '../../network/api_urls.dart';
import '../../network/base_api.dart';
import 'levels/model/add_level_request.dart';
import 'levels/stages/model/add_stage_request.dart';
import 'model/add_response.dart';

class AddRepo {
  Future<AddResponse> addProgram(AddProgramRequest addProgramRequest) async {
    try {
      final response =
          await BaseAPI.post(ApiUrl.saveProgram, addProgramRequest.toJson());
      var addResponse = AddResponse.fromJson(response);
      return addResponse;
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR LOGIN REPO');
      return AddResponse(msg: 'حدث حطاء في الاتصال', msgNum: 2);
    }
  }

  Future<AddResponse> updateProgram(
      UpdateProgramRequest updateProgramRequest) async {
    try {
      final response =
          await BaseAPI.post(ApiUrl.saveProgram, updateProgramRequest.toJson());
      var addResponse = AddResponse.fromJson(response);
      return addResponse;
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR LOGIN REPO');
      return AddResponse(msg: 'حدث حطاء في الاتصال', msgNum: 2);
    }
  }

  Future<AddResponse> addLevel(AddLevelRequest addLevelRequest) async {
    try {
      final response =
          await BaseAPI.post(ApiUrl.saveLevel, addLevelRequest.toJson());
      var addResponse = AddResponse.fromJson(response);
      return addResponse;
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR addLevel REPO');
      return AddResponse(msg: 'حدث حطاء في الاتصال', msgNum: 2);
    }
  }

  Future<AddResponse> updateLevel(UpdateLevelRequest updateLevelRequest) async {
    try {
      final response =
          await BaseAPI.post(ApiUrl.saveLevel, updateLevelRequest.toJson());
      var addResponse = AddResponse.fromJson(response);
      return addResponse;
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR addLevel REPO');
      return AddResponse(msg: 'حدث حطاء في الاتصال', msgNum: 2);
    }
  }

  Future<AddResponse> addStage(AddStageRequest addLevelRequest) async {
    try {
      final response =
          await BaseAPI.post(ApiUrl.saveStage, addLevelRequest.toJson());
      var addResponse = AddResponse.fromJson(response);
      return addResponse;
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR addLevel REPO');
      return AddResponse(msg: 'حدث حطاء في الاتصال', msgNum: 2);
    }
  }

  Future<AddResponse> updateStage(UpdateStageRequest updateStageRequest) async {
    try {
      final response =
          await BaseAPI.post(ApiUrl.saveStage, updateStageRequest.toJson());
      var addResponse = AddResponse.fromJson(response);
      return addResponse;
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR addLevel REPO');
      return AddResponse(msg: 'حدث حطاء في الاتصال', msgNum: 2);
    }
  }

  Future<AddResponse> addTask(AddTaskRequest addTaskRequest) async {
    RegExp reg = RegExp(r'[a-z]');
    if (addTaskRequest.name!.contains(reg) ||
        addTaskRequest.info!.contains(reg)) {
      return AddResponse(
          msg: 'يجب ان يكون اسم المهمة والوصف باللغة العربية', msgNum: 3);
    } else {
      try {
        final response =
            await BaseAPI.post(ApiUrl.saveTask, addTaskRequest.toJson());
        var addResponse = AddResponse.fromJson(response);
        return addResponse;
      } catch (e) {
        secureLog(e.toString(), name: 'ERROR addLevel REPO');
        return AddResponse(msg: 'حدث حطاء في الاتصال', msgNum: 2);
      }
    }
  }

  Future<AddResponse> updateTask(UpdateTaskRequest updateTaskRequest) async {
    try {
      final response =
          await BaseAPI.post(ApiUrl.saveTask, updateTaskRequest.toJson());
      var addResponse = AddResponse.fromJson(response);
      return addResponse;
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR addLevel REPO');
      return AddResponse(msg: 'حدث حطاء في الاتصال', msgNum: 2);
    }
  }

  Future<ApiResponseModel> delete(String type, String id) async {
    try {
      final response = await BaseAPI.post(ApiUrl.delete, {type: id});
      var addResponse = ApiResponseModel.fromJson(response);
      return addResponse;
    } catch (e) {
      secureLog(e.toString(), name: 'ERROR addLevel REPO');
      return ApiResponseModel(msg: 'حدث حطاء في الاتصال', msgNum: 2);
    }
  }
}
