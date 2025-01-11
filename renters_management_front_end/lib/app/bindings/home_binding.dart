import 'package:get/get.dart';
import 'package:renters_management_front_end/app/controllers/calculator_controller.dart';
import 'package:renters_management_front_end/app/controllers/home_controller.dart';


class HomeViewBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
    Get.put<CalculatorController>(CalculatorController(),permanent: true);
  }


}