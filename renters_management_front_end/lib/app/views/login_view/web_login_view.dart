// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/buttons.dart';
import '../../components/custom_text.dart';
import '../../components/text_field.dart';
import '../../controllers/login_controller.dart';
import '../../globals.dart';

class WebLoginView extends GetView<LoginController> {
  WebLoginView({
    super.key,
  });

  double height = Get.height;
  double width = Get.width;

  List<PopupMenuItem<String>> menuItems = [
    PopupMenuItem<String>(value: "en", child: SecText("En")),
    PopupMenuItem<String>(value: "ar", child: SecText("Ar")),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          child: Image.asset("assets/images/renters_management_background.jpeg",
              fit: BoxFit.fill),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height*0.4,
              ),
              Container(
                  width: width * 0.35,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.backColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Form(
                    key: controller.formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width * 0.35 * 0.2,
                            ),
                            MainText('login'.tr,
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                                textColor: AppColors.secTextColor),
                            PopupMenuButton<String>(
                              initialValue: Get.locale?.languageCode.toString(),
                              itemBuilder: (BuildContext context) => menuItems,
                              onSelected: (lang) {
                                controller.changeLang(lang);
                              },
                              child: Row(
                                children:
                                    (Get.locale?.languageCode.toString() ==
                                            "en")
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
                          height: height * 0.6 * 0.1,
                        ),
                        CustomTextFormField(
                          controller: controller.email,
                          validator: (id) => controller.validateID(id),
                          labelText: 'id'.tr,
                          icon: Icons.account_circle_outlined,
                        ),
                        SizedBox(
                          height: height * 0.6 * 0.05,
                        ),
                        CustomTextFormField(
                            controller: controller.password,
                            validator: (pwd) =>
                                controller.validatePassword(pwd),
                            labelText: 'password'.tr,
                            icon: Icons.key_sharp,
                            isPassword: true,
                            onFieldSubmitted: (e) {
                              controller.onLogin();
                            }),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: TextButton(
                            onPressed: () => controller.forgotPassword,
                            child: SecText(
                              "forgotPassword?".tr,
                              textColor: AppColors.linkTextColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.6 * 0.1,
                        ),
                        Obx(() => (controller.logging.value)
                            ? CustomButton(
                                onPress: controller.onLogin,
                                text: 'logging',
                                icon: CircularProgressIndicator(
                                  color: AppColors.backColor,
                                ),
                                size: Size(width * 0.8, 40),
                              )
                            : CustomButton(
                                onPress: controller.onLogin,
                                text: 'login'.tr,
                                icon: (Get.locale.toString() == "en_US")
                                    ? Icon(
                                        Icons.login,
                                        color: AppColors.mainTextColor,
                                      )
                                    : RotatedBox(
                                        quarterTurns: 2,
                                        child: Icon(Icons.login,
                                            color: AppColors.mainTextColor)),
                                size: Size(width * 0.8, 40),
                              )),

                      ],
                    ),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
