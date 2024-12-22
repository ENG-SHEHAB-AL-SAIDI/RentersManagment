// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/controllers/register_controller.dart';

import '../../components/buttons.dart';
import '../../components/custom_text.dart';
import '../../components/text_field.dart';
import '../../globals.dart';

class PhoneRegisterView extends GetView<RegisterController> {
  PhoneRegisterView({
    super.key,
  });

  double height = Get.height;
  double width = Get.width;
  RxBool state = true.obs;

  List<PopupMenuItem<String>> menuItems = [
    PopupMenuItem<String>(value: "en", child: SecText("En")),
    PopupMenuItem<String>(value: "ar", child: SecText("Ar")),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.backColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Form(
            key: controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width * 0.35 * 0.2,
                    ),
                    MainText('Register'.tr,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        textColor: Colors.black),
                    PopupMenuButton<String>(
                      initialValue: Get.locale?.languageCode.toString(),
                      itemBuilder: (BuildContext context) => menuItems,
                      color: AppColors.backColor,
                      onSelected: (lang) {
                        controller.changeLang(lang);
                      },
                      child: Row(
                        children: (Get.locale?.languageCode.toString() == "en")
                            ? [
                                const Icon(Icons.language),
                                SecText("En"),
                              ]
                            : [
                                SecText("Ar"),
                                const Icon(Icons.language),
                              ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                CustomTextFormField(
                  controller: controller.name,
                  validator: controller.validateName,
                  labelText: 'first name'.tr,
                  icon: Icons.person,
                  focusNode: controller.nameFocus,
                  onFieldSubmitted: (e) {
                    controller.nameFocus.unfocus();
                    controller.emailFocus.requestFocus();
                  },
                ),
                SizedBox(
                  height: height * 0.6 * 0.05,
                ),
                CustomTextFormField(
                  controller: controller.email,
                  validator: controller.validateEmail,
                  labelText: 'Email'.tr,
                  icon: Icons.email,
                  focusNode: controller.emailFocus,
                  onFieldSubmitted: (e) {
                    controller.emailFocus.unfocus();
                    controller.passwordFocus.requestFocus();
                  },
                ),
                SizedBox(
                  height: height * 0.6 * 0.05,
                ),
                CustomTextFormField(
                  controller: controller.password,
                  validator: controller.validatePassword,
                  labelText: 'password'.tr,
                  icon: Icons.lock,
                  isPassword: true,
                  focusNode: controller.passwordFocus,
                  onFieldSubmitted: (str) {
                    controller.passwordConfirmationFocus.requestFocus();
                  },
                ),
                SizedBox(
                  height: height * 0.6 * 0.05,
                ),
                CustomTextFormField(
                  controller: controller.passwordConfirmation,
                  validator: controller.validatePasswordConfirmation,
                  labelText: 'password Confirmation'.tr,
                  icon: Icons.lock_outline,
                  isPassword: true,
                  focusNode: controller.passwordConfirmationFocus,
                  onFieldSubmitted: (str) {
                    controller.register();
                  },
                ),
                Obx(
                  () => (controller.registerFiled.value)
                      ? Column(
                          children: [
                            SecText(
                              "Register Filed",
                              textColor: Colors.redAccent,
                            ),
                            SecText(
                              controller.filedMessage.value,
                              textColor: Colors.redAccent,
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                          ],
                        )
                      : SizedBox(),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Obx(
                  () => (controller.registering.value)
                      ? CustomButton(
                          onPress: controller.register,
                          text: 'Registering'.tr,
                          icon: SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: AppColors.backColor,
                            ),
                          ),
                          size: Size(width * 0.8, 50),
                        )
                      : CustomButton(
                          onPress: controller.register,
                          text: 'Register'.tr,
                          icon: Icon(
                            Icons.person_add,
                            color: AppColors.mainTextColor,
                          ),
                          size: Size(width * 0.8, 50)),
                )
              ],
            ),
          )),
    );
  }
}
