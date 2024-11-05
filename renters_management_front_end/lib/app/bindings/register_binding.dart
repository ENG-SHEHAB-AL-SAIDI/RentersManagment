import 'package:get/get.dart';
import '../controllers/register_controller.dart';

class RegisterViewBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<RegisterController>(RegisterController());
  }


}