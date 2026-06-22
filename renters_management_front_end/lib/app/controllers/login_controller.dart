import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/bindings/register_binding.dart';
import 'package:renters_management_front_end/app/models/result.dart';
import '../repositories/user_repository.dart';
import '../views/login_view/register_view.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode idFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  RxString filedMessage = "password or id is wrong".obs;
  String logWith = "ID";
  RxBool logging = false.obs;
  RxBool loggingFiled = false.obs;
  RxBool rememberMe = false.obs;
  RxDouble heightScale = 0.65.obs;

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    idFocus.dispose();
    passwordFocus.dispose();
  }

  @override
  void onInit() async {
    if (Get.parameters.keys.contains('demoMode') &&
        Get.parameters['demoMode'] == 'true') {
      email.text = "test@gmail.com";
      password.text = "12345678";
      await onLogin();
    }
    Result res = await UserServices.fetchUser(hardFetch: true);
    if (res.statusCode == 200) {
      Get.offNamed("/home");
    }
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

  void toggleRememberMe(bool? val) {
    rememberMe.value = val ?? false;
  }

  Future<void> onLogin() async {
    logging.value = true;
    if (formKey.currentState!.validate()) {
      Result res = await UserServices.userLogin(email.text, password.text,
          rememberMe: rememberMe.value);
      if (res.statusCode == 200) {
        Get.offNamed("/home");
      } else if (res.statusCode == 900) {
        filedMessage.value =
            "no internet connection \n please check your connection ";
        loggingFiled.value = true;
      } else if (res.statusCode == 401) {
        filedMessage.value = "password or id is wrong";
        loggingFiled.value = true;
      } else if (res.statusCode == 404) {
        filedMessage.value = "no such user exist";
        loggingFiled.value = true;
      } else {
        filedMessage.value =
            "something get wrong \n please check your connection ";
        loggingFiled.value = true;
      }
    }
    logging.value = false;
  }

  void registerRoute() {
    Get.to(() => PhoneRegisterView(), binding: RegisterViewBinding());
  }

  void changeLang(String lang) {
    Get.updateLocale(Locale(lang));
  }
}
