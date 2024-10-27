import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/buttons.dart';

import '../../controllers/renter_printing_controller.dart';
import '../../globals.dart';
import '../custom_text.dart';

class PopUpRenterPrintSettingCard extends GetView<RenterPrintingController> {
  const PopUpRenterPrintSettingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: "PopUpRenterPrintSettingCard",
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SecText("Print Renter",
                            fontWeight: FontWeight.bold, fontSize: 20),
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            SecText("Years to include"),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            height: Get.height * 0.26,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.inverseCardColor,
                                  // Border color
                                  width: 2, // Border width
                                ),
                                borderRadius: BorderRadius.circular(24)),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Obx(() => Checkbox(
                                      value: controller.selectAll.value,
                                      onChanged: controller.selectAllChange)),
                                  title: SecText(
                                    "select all",
                                    textColor: AppColors.secTextColor,
                                    textAlign: TextAlign.start,
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                ),
                                Divider(),
                                Expanded(
                                  child: ListView(
                                    children: controller.years.value,
                                  ),
                                )
                              ],
                            )),
                        ListTile(
                          leading: Obx(() => Checkbox(
                              value: controller.includeInstallment.value,
                              onChanged: controller.includeInstallmentChange)),
                          title: SecText(
                            "include installments",
                            textColor: AppColors.secTextColor,
                            textAlign: TextAlign.start,
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomButton(
                              onPress: controller.printing,
                              text: "Print",
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
}
