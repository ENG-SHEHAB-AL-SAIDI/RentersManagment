import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/models/result.dart';

import '../repositories/user_repository.dart';


class RegisterController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode passwordConfirmationFocus = FocusNode();
  RxString filedMessage = "password or id is wrong".obs;
  String logWith = "ID";
  RxBool registering = false.obs;
  RxBool registerFiled = false.obs;

  @override
  void onClose() {
    name.dispose();
    email.dispose();
    password.dispose();
    passwordConfirmation.dispose();
    nameFocus.dispose();
    passwordFocus.dispose();
  }



  String? validateName(String? name) {
    if (name == "" || name == null) {
      return "required name";
    } else if (!GetUtils.isUsername(name)) {
      return "invalid name";

    }
    return  null ;
  }

  String? validateEmail(String? id) {
    if (id == "" || id == null) {
      return "required ID";
    } else if (!GetUtils.isEmail(id)) {
      return "Invalid email";
    }
    return null;
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

  String? validatePasswordConfirmation(String? password) {
    if (this.password.text != password) {
      return "Password Confirmation must be match password";
    } else {
      return null;
    }
  }

  void forgotPassword() {
    Get.toNamed("/forgotPassword");
  }

  Future<void> register() async {
    registering.value = true;
    if (formKey.currentState!.validate()) {
      Result res = await UserServices.userRegister(name.text, email.text,password.text,passwordConfirmation.text);
      if (res.statusCode == 200) {
        Get.offNamed("/home");
      } else if (res.statusCode == 900) {
        filedMessage.value =
        "no internet connection \n please check your connection ";
        registerFiled.value = true;
      } else {
        filedMessage.value =
        "something get wrong \n please check your connection ";
        registerFiled.value = true;
      }
    }
    registering.value = false;
  }

  void changeLang(String lang) {
    Get.updateLocale(Locale(lang));
  }
}
