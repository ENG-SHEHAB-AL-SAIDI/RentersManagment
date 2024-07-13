import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/buttons.dart';
import 'package:renters_management_front_end/app/components/text_field.dart';

import '../../globals.dart';
import '../custom_text.dart';

class PopUpIAddBuildCard extends StatelessWidget {
  const PopUpIAddBuildCard({super.key});

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
                height: Get.height * 0.4,
                width: Get.width,
                child: SafeArea(
                    minimum: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SecText("Add Build",
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.home_work_sharp,
                                  size: 40,
                                  color: AppColors.inverseIconColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SecText("Build Name"),
                                const SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                            CustomTextFormField(
                              width: (Get.width-12)*0.46,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(
                                Icons.location_city,
                                size: 40,
                                color: AppColors.inverseIconColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SecText("City"),
                            ],),
                            CustomTextFormField(
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
                                  Icons.approval,
                                  size: 40,
                                  color: AppColors.inverseIconColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SecText(" Address", ),
                              ],
                            ),
                            CustomTextFormField(
                              width: (Get.width-12)*0.46,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomButton(
                              onPress: update,
                              text: "Add",
                            ),
                            CustomButton(
                              onPress: () => Get.back(),
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

  void update() {}
}
