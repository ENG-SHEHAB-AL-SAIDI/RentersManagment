import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/buttons.dart';
import 'package:renters_management_front_end/app/components/text_field.dart';

import '../../controllers/installment_add_controller.dart';
import '../../globals.dart';
import '../custom_text.dart';

class PopUpAddInstallmentCard extends GetView<InstallmentAddController> {
  const PopUpAddInstallmentCard({super.key});

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
                )),
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
                              fontWeight: FontWeight.bold, fontSize: 20),
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
                                  SecText("Date"),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                              CustomTextFormField(
                                controller: controller.dateController,
                                validator: controller.validateDate,
                                labelText: 'Date'.tr,
                                focusNode: controller.dateFocus,
                                readOnly: true,
                                onTap: ()=>controller.datePiker(context),
                                onFieldSubmitted: (e) {
                                  controller.timeFocus.requestFocus();
                                },
                                width: (Get.width - 12) * 0.46,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 40,
                                    color: AppColors.inverseIconColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SecText("Time"),
                                ],
                              ),
                              CustomTextFormField(
                                controller: controller.timeController,
                                keyboardType: TextInputType.number,
                                validator: controller.validateTime,
                                labelText: "Time",
                                focusNode: controller.timeFocus,
                                readOnly: true,
                                onTap: ()=>controller.timePiker(context),
                                onFieldSubmitted: (e) {
                                  controller.amountFocus.requestFocus();
                                },
                                width: (Get.width - 12) * 0.46,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.monetization_on_rounded,
                                    size: 40,
                                    color: AppColors.inverseIconColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SecText("Amount"),
                                ],
                              ),
                              CustomTextFormField(
                                controller: controller.amountController,
                                keyboardType: TextInputType.number,
                                validator: controller.validateAmount,
                                labelText: "Amount",
                                focusNode: controller.amountFocus,
                                onFieldSubmitted: (e) {
                                  controller.noteFocus.requestFocus();
                                },
                                width: (Get.width - 12) * 0.46,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.note_alt_sharp,
                                    size: 40,
                                    color: AppColors.inverseIconColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SecText(
                                    "Note",
                                  ),
                                ],
                              ),
                              CustomTextFormField(
                                controller: controller.noteController,
                                labelText: "Note",
                                focusNode: controller.noteFocus,
                                onFieldSubmitted: (e) {
                                  controller.noteFocus.unfocus();
                                  controller.submit();
                                },
                                width: (Get.width - 12) * 0.46,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton(
                                onPress: controller.submit,
                                text: "Add",
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
