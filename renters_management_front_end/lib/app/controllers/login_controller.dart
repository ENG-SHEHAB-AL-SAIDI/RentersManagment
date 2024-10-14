import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/models/result.dart';
import 'package:renters_management_front_end/app/services/user_services.dart';

class LoginController extends GetxController {
  TextEditingController id = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode idFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  RxString filedMessage = "password or id is wrong".obs;
  String logWith = "ID";
  RxBool logging = false.obs;
  RxBool loggingFiled = false.obs;
  RxDouble heightScale = 0.6.obs;

  @override
  void onClose() {
    id.dispose();
    password.dispose();
    idFocus.dispose();
    passwordFocus.dispose();
  }

  @override
  void onInit() {
    id.text = "shehab8@gmail.com";
    password.text = "12345678";
    super.onInit();
  }

  String? validateID(String? id) {
    bool valid = false;
    if (id == "" || id == null) {
      return "required ID";
    } else if (GetUtils.isNumericOnly(id)) {
      logWith = "ID";
      valid = true;
    } else if (GetUtils.isEmail(id)) {
      logWith = "Email";
      valid = true;
    }
    return (valid) ? null : "Invalid ID";
  }

  String? validatePassword(String? password) {
    if (GetUtils.isNullOrBlank(password ?? "") == null) {
      return "Password required";
    } else if (password!.length < 8) {
      return "Password must be at least 8 characters  long";
    } else {
      return null;
    }
  }

  void forgotPassword() {
    Get.toNamed("/forgotPassword");
  }

  Future<void> onLogin() async {
    loggingFiled.value = true;
    if (formKey.currentState!.validate()) {
      logging.value = true;
      Result res = await UserServices.userLogin(id.text, password.text);
      if (res.statusCode == 200) {
        Get.offNamed("/home");
      } else if (res.statusCode == 900) {
        filedMessage.value =
            "no internet connection \n please check your connection ";
      } else if (res.statusCode == 401) {
        filedMessage.value = "password or id is wrong";
      } else {
        filedMessage.value =
            "something get wrong \n please check your connection ";
      }
    }
    logging.value = false;
  }

  void changeLang(String lang) {
    Get.updateLocale(Locale(lang));
  }
}
