import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/buttons.dart';
import 'package:renters_management_front_end/app/components/text_field.dart';
import 'package:renters_management_front_end/app/controllers/renter_details_controller.dart';
import '../../globals.dart';
import '../custom_text.dart';

class PopUpAddPhoneCard extends GetView<RenterDetailsController> {
  const PopUpAddPhoneCard({super.key});



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: "PopUpAddPhoneCard",
          child: Material(
            color: AppColors.mainCardColor,
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
                side: BorderSide(
                  color: AppColors.inverseCardColor,
                  width: 3,

                )
            ),
            child: SizedBox(
                height: Get.height * 0.3,
                width: Get.width,
                child: SafeArea(
                    minimum: const EdgeInsets.all(12),
                    child: Form(
                      key: controller.formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SecText("Add Phone",
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone_android,
                                    size: 40,
                                    color: AppColors.inverseIconColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SecText("Phone", ),
                                ],
                              ),
                              CustomTextFormField(
                                controller: controller.phoneController,
                                keyboardType: TextInputType.phone,
                                validator: controller.validatePhone,
                                labelText: "Phone",
                                onFieldSubmitted: (e) {
                                  Get.back();
                                  controller.addPhone();
                                },
                                width: (Get.width-12)*0.46,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton(
                                onPress: controller.addPhone,
                                text: "Add",
                              ),
                              CustomButton(
                                onPress: () {
                                  controller.phoneController.clear();
                                  Get.back(result: null);
                                  },
                                text: "Close",
                              ),
                            ],
                          )
                        ],
                      ),
                    ))),
          ),
        ),
      ),
    );
  }


}
