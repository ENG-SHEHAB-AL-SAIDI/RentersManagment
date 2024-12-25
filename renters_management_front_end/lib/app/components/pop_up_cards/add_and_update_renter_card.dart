import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/buttons.dart';
import 'package:renters_management_front_end/app/components/text_field.dart';
import '../../controllers/renter_add_update_card_controller.dart';
import '../../globals.dart';
import '../custom_text.dart';

class PopUpIAddAndUpdateRenterCard extends GetView<RenterAddUpdateCardController> {
  const PopUpIAddAndUpdateRenterCard({super.key});



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: "PopUpInsertCard",
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
                height: Get.height * 0.6,
                width: Get.width,
                child: SafeArea(
                    minimum: const EdgeInsets.all(12),
                    child: Form(
                      key: controller.formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SecText("Add Renter",
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 40,
                                    color: AppColors.inverseIconColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SecText("Name"),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                              CustomTextFormField(
                                controller: controller.nameController,
                                validator:controller.validateName,
                                labelText: 'name'.tr,
                                focusNode: controller.nameFocus,
                                  onFieldSubmitted: (e) {
                                  controller.rentFocus.requestFocus();
                                  },
                                width: (Get.width-12)*0.46,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Icon(
                                  Icons.monetization_on_rounded,
                                  size: 40,
                                  color: AppColors.inverseIconColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SecText("Rent"),
                              ],),
                              CustomTextFormField(
                                controller: controller.rentController,
                                keyboardType: TextInputType.number,
                                validator: controller.validateRent,
                                labelText: "Rent",
                                focusNode: controller.rentFocus,
                                onFieldSubmitted: (e) {
                                  controller.activityFocus.requestFocus();
                                },
                                width: (Get.width-12)*0.46,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.work_outline_rounded,
                                    size: 40,
                                    color: AppColors.inverseIconColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SecText("Activity", ),
                                ],
                              ),
                              CustomTextFormField(
                                controller: controller.activityController,
                                labelText: "Activity",
                                focusNode: controller.activityFocus,
                                onFieldSubmitted: (e) {
                                  controller.entryYearFocus.requestFocus();
                                },
                                width: (Get.width-12)*0.46,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.date_range,
                                    size: 40,
                                    color: AppColors.inverseIconColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SecText("Entry Year", ),
                                ],
                              ),
                              CustomTextFormField(
                                controller: controller.entryYearController,
                                validator: controller.validateEntryYear,
                                keyboardType: TextInputType.datetime,
                                labelText: "Entry Year",
                                focusNode: controller.entryYearFocus,
                                onFieldSubmitted: (e) {
                                  controller.phoneFocus.requestFocus();
                                },
                                width: (Get.width-12)*0.46,
                              ),
                            ],
                          ),
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
                                focusNode: controller.phoneFocus,
                                onFieldSubmitted: (e) {
                                  controller.phoneFocus.unfocus();
                                  controller.submit();
                                },
                                width: (Get.width-12)*0.46,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton(
                                onPress: controller.submit,
                                text: controller.mode.value,
                              ),
                              CustomButton(
                                onPress: () => Get.back(result: null),
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
