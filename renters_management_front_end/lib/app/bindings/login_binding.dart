import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginViewBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }


}