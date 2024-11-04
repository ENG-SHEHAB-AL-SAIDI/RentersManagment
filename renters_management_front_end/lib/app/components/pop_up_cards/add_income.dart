import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/buttons.dart';
import 'package:renters_management_front_end/app/components/text_field.dart';
import 'package:renters_management_front_end/app/controllers/build_reports_controller.dart';

import '../../globals.dart';
import '../custom_text.dart';

class PopUpAddIncomeCard extends GetView<BuildReportsController> {
  const PopUpAddIncomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Center(
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
                          SecText("Add Income",
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
                                onTap: () => controller.datePiker(context),
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
                                onTap: () => controller.timePiker(context),
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
                                    Icons.monetization_on_rounded,
                                    size: 40,
                                    color: AppColors.inverseIconColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SecText("Payment Type"),
                                ],
                              ),
                              Expanded(child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(24)
                                ),
                                child: Center(
                                  child: DropdownButton<String>(
                                    value: controller.paymentType.value,
                                    icon: Icon(Icons.arrow_drop_down_sharp,
                                        color: AppColors.inverseCardColor),
                                    underline: const SizedBox(),
                                    dropdownColor: AppColors.mainCardColor,
                                    onChanged: (val) {
                                      controller.paymentType.value = val ?? "cash";
                                      if(controller.paymentType.value != "cash" ){
                                        controller.paymentIbFocus.requestFocus();
                                      }
                                    },
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: "cash",
                                        child:  Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SecText("cash",),
                                            Icon(Icons.attach_money,
                                                color: AppColors.inverseCardColor)
                                          ],
                                        ),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "trans",
                                        child: Expanded(child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SecText("trans"),
                                            Icon(Icons.payment,
                                                color: AppColors.inverseCardColor)
                                          ],
                                        ),),
                                      ),
                                      DropdownMenuItem<String>(
                                          value: "part from trans",
                                          child: Expanded(child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SecText("part from trans"),
                                              Icon(Icons.payments,
                                                  color: AppColors.inverseCardColor)
                                            ],
                                          ),)
                                      )
                                    ],
                                  ),
                                ),))
                            ],
                          ),
                          if(controller.paymentType.value != "cash")...[
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
                                    SecText("Payment ID"),
                                  ],
                                ),
                                CustomTextFormField(
                                  controller: controller.paymentIdController,
                                  keyboardType: TextInputType.number,
                                  labelText: "Payment ID",
                                  focusNode: controller.paymentIbFocus,
                                  onFieldSubmitted: (e) {
                                    controller.noteFocus.requestFocus();
                                  },
                                  width: (Get.width - 12) * 0.46,
                                ),
                              ],
                            ),
                          ],
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
                                    "Description",
                                  ),
                                ],
                              ),
                              CustomTextFormField(
                                controller: controller.noteController,
                                labelText: "Description",
                                keyboardType: TextInputType.text,
                                focusNode: controller.noteFocus,
                                onFieldSubmitted: (e) {
                                  controller.noteFocus.unfocus();
                                  controller.expensSubmit();
                                },
                                width: (Get.width - 12) * 0.46,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton(
                                onPress: controller.incomeSubmit,
                                text: "Add",
                              ),
                              CustomButton(
                                onPress: () {
                                  Get.back(result: null);
                                  controller.clear();
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
    ));
  }
}
