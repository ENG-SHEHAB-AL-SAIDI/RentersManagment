import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/buttons.dart';
import 'package:renters_management_front_end/app/components/text_field.dart';

import '../../globals.dart';
import '../custom_text.dart';

class PopUpIAddAndUpdateRenterCard extends StatelessWidget {
  PopUpIAddAndUpdateRenterCard({this.mode="Add",this.data, super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController rentController = TextEditingController();
  TextEditingController activityController = TextEditingController();
  TextEditingController entryYearController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Map<String,String>? data;
  String mode;
  @override
  Widget build(BuildContext context) {
    if(data != null){
      nameController.text = data!["name"]??"";
      rentController.text = data!["rent"]??"";
      activityController.text = data!["activity"]??"";
      entryYearController.text = data!["entryYear"]??"";
    }
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
                              controller: nameController,
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
                              controller: rentController,
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
                              controller: activityController,
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
                              controller: activityController,
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
                              controller: phoneController,
                              width: (Get.width-12)*0.46,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomButton(
                              onPress: submit,
                              text: mode,
                            ),
                            CustomButton(
                              onPress: () => Get.back(result: null),
                              text: "Close",
                            ),
                          ],
                        )
                      ],
                    ))),
          ),
        ),
      ),
    );
  }

  void submit(){
    Map<String,dynamic> jsData = {
      "name":nameController.text,
      "rent":rentController.text,
      "job_domain":activityController.text,
      "enter_date":entryYearController.text,
      "phones": [
        phoneController.text
      ],
    };
    Get.back(result: jsData);
  }
}
