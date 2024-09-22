import 'package:get/get.dart';
import 'package:renters_management_front_end/app/controllers/home_controller.dart';
import '../controllers/login_controller.dart';

class HomeViewBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
  }


}