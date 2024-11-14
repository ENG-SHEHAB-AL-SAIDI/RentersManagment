import 'package:get/get.dart';
import 'package:renters_management_front_end/app/controllers/calculatorController.dart';
import 'package:renters_management_front_end/app/controllers/home_controller.dart';


class HomeViewBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
    Get.lazyPut<CalculatorController>(()=>CalculatorController());
  }


}