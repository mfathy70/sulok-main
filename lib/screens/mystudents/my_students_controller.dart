import 'package:get/get.dart';
import 'package:sulok/helper/custom/custom_loading.dart';
import 'package:sulok/screens/mystudents/my_students_repo.dart';

class MyStudentsController extends GetxController {
  MyStudentsRepo myStudentsRepo = MyStudentsRepo();

  activeStudent(String id) async{
    loading();
    await myStudentsRepo.activeOrDeActive(active: true, id: id);
    update();
    closeLoading();
  }

  deActiveStudent(String id) async{
    loading();
    await myStudentsRepo.activeOrDeActive(active: false, id: id);
    update();
    closeLoading();
  }
}
