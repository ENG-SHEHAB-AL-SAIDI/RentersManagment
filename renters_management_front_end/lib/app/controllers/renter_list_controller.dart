import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/models/result.dart';
import 'package:renters_management_front_end/app/services/user_services.dart';

class LoginController extends GetxController {
  TextEditingController search = TextEditingController();
  RxBool logging = false.obs;
  RxBool loggingFiled = false.obs;
  RxDouble heightScale = 0.6.obs;


  @override
  void onClose() {
    search.dispose();

  }


  void forgotPassword(){
    Get.toNamed("/forgotPassword");
  }


  void changeLang(String lang){
    Get.updateLocale(Locale(lang));
  }
}
