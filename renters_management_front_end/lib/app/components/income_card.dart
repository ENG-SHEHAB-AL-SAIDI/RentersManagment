// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/pop_up_cards/show_notes.dart';

import '../controllers/build_reports_controller.dart';
import '../controllers/show_notes_controller.dart';
import '../globals.dart';
import 'buttons.dart';
import 'custom_text.dart';

class IncomeCard extends GetView<BuildReportsController> {
  IncomeCard({
    super.key,
    this.initiallyExpanded = false,
  });

  double expansionTileChildrenFontSize = 12;
  Rx<Map<String, Row>> status = Rx({});
  bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    Color color1;
    Color color2;
    Color textColor;

    color1 = AppColors.inverseCardColor;
    color2 = AppColors.backColor;
    textColor = AppColors.mainTextColor;
    // if (type == 0) {
    //   color1 = AppColors.mainCardColor;
    //   color2 = AppColors.inverseCardColor;
    //   textColor = AppColors.secTextColor;
    // } else {
    //   color1 = AppColors.inverseCardColor;
    //   color2 = AppColors.backColor;
    //   textColor = AppColors.mainTextColor;
    // }
    return Obx(() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        decoration: BoxDecoration(
          color: color1,
          border: Border(
            top: BorderSide(color: color2, width: 5, strokeAlign: 1),
            bottom: BorderSide(color: color2, width: 5, strokeAlign: 1),
            right: BorderSide(color: color2, width: 5, strokeAlign: 1),
            left: BorderSide(color: color2, width: 5, strokeAlign: 1),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 5),
            )
          ],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SecText(
                            "Total incomes",
                            textColor: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SecText(
                            "${controller.statement?.totalIncomes?.value}",
                            textColor: textColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: color2,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: ExpansionTile(
                iconColor: color1,
                collapsedIconColor: color1,
                initiallyExpanded: initiallyExpanded,
                title: SecText(
                  "incomes Details",
                  textColor: color1,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                childrenPadding: const EdgeInsets.all(8),
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        Container(
                          height: 1,
                          width: ((Get.width - 45) * (1 / 4))*8,
                          color: AppColors.secTextColor,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: ((Get.width) * (1 / 4)),
                                child: SecText(
                                  "Date",
                                  textColor: color1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Utils.fontSizeScale(
                                      expansionTileChildrenFontSize),
                                )),
                            SizedBox(
                                width: ((Get.width ) * (1 / 4)),
                                child: SecText(
                                  "time",
                                  textColor: color1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Utils.fontSizeScale(
                                      expansionTileChildrenFontSize),
                                )),
                            SizedBox(
                                width: ((Get.width ) * (1 / 4)),
                                child: SecText(
                                  "Amount",
                                  textColor: color1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Utils.fontSizeScale(
                                      expansionTileChildrenFontSize),
                                )),
                            SizedBox(
                                width: ((Get.width ) * (1 / 4)),
                                child: SecText(
                                  "PaymentType",
                                  textColor: color1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Utils.fontSizeScale(
                                      expansionTileChildrenFontSize),
                                )),
                            SizedBox(
                                width: ((Get.width ) * (1 / 4)),
                                child: SecText(
                                  "PaymentID",
                                  textColor: color1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Utils.fontSizeScale(
                                      expansionTileChildrenFontSize),
                                )),
                            SizedBox(
                                width: ((Get.width ) * (1 / 4)),
                                child: SecText(
                                  "Description",
                                  textColor: color1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Utils.fontSizeScale(
                                      expansionTileChildrenFontSize),
                                )),
                            SizedBox(
                              width: ((Get.width) * (1 / 4)),
                            )
                          ],
                        ),
                        if (controller.statement?.incomes?.isEmpty ?? true) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SecText(
                                "Empty",
                                textColor: AppColors.inverseSecTextColor,
                              ),
                            ],
                          ),
                        ] else ...[
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            height: 1,
                            width: ((Get.width - 45) * (1 / 4))*8,
                            color: AppColors.secTextColor,
                          ),
                          for (int i = 0;
                          i < (controller.statement?.incomes?.length ?? 0);
                          i++) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: ((Get.width) * (1 / 4)),
                                    child: SecText(
                                      (controller.statement?.incomes?[i].date
                                          ?.value !=
                                          null)
                                          ? controller.dateFormat
                                          .format(DateTime.parse(controller
                                          .statement!
                                          .incomes![i]
                                          .date!
                                          .value))
                                          .toString()
                                          : "Unknown",
                                      textColor: color1,
                                      fontSize: Utils.fontSizeScale(
                                          expansionTileChildrenFontSize),
                                    )),
                                SizedBox(
                                    width: ((Get.width) * (1 / 4)),
                                    child: SecText(
                                      (controller.statement?.incomes?[i].date
                                          ?.value !=
                                          null)
                                          ? controller.timeFormat
                                          .format(DateTime.parse(controller
                                          .statement!
                                          .incomes![i]
                                          .date!
                                          .value))
                                          .toString()
                                          : "Unknown",
                                      textColor: color1,
                                      fontSize: Utils.fontSizeScale(
                                          expansionTileChildrenFontSize),
                                    )),
                                SizedBox(
                                    width: ((Get.width ) * (1 / 4)),
                                    child: SecText(
                                      "${controller.statement?.incomes?[i].amount?.value ?? "Unknown"}",
                                      textColor: color1,
                                      fontSize: Utils.fontSizeScale(
                                          expansionTileChildrenFontSize),
                                    )),
                                SizedBox(
                                    width: ((Get.width ) * (1 / 4)),
                                    child: SecText(
                                      controller.statement?.incomes?[i].paymentType?.value ?? "Unknown",
                                      textColor: color1,
                                      fontSize: Utils.fontSizeScale(
                                          expansionTileChildrenFontSize),
                                    )),
                                SizedBox(
                                    width: ((Get.width ) * (1 / 4)),
                                    child: SecText(
                                      controller.statement?.incomes?[i].paymentID?.value ?? "Unknown",
                                      textColor: color1,
                                      fontSize: Utils.fontSizeScale(
                                          expansionTileChildrenFontSize),
                                    )),
                                SizedBox(
                                  width: ((Get.width ) * (1 / 4)),
                                  child: TextButton(
                                    onPressed: () async {
                                      Get.put(ShowNotesController());
                                      await Get.dialog(const PopUpShowNotesCard(),
                                          arguments: {
                                            "notes": controller
                                                .statement
                                                ?.incomes?[i]
                                                .description
                                                ?.value ??
                                                "help",
                                            'other': "done",
                                          });
                                    },
                                    child: SecText(
                                      "show",
                                      textColor: color1,
                                      fontSize: Utils.fontSizeScale(
                                          expansionTileChildrenFontSize),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: ((Get.width ) * (1 / 4)),
                                  child: IconButton(
                                      onPressed: () {
                                        if (controller
                                            .statement?.incomes![i].id.value ==
                                            null) return;
                                        controller.deleteIncome((controller
                                            .statement!.incomes![i].id.value));
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: color1,
                                      )),
                                )
                              ],
                            ),
                            Container(
                              height: 1,
                              width: ((Get.width - 45) * (1 / 4))*8,
                              color: AppColors.secTextColor,
                            )
                          ],
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    onPress: controller.addIncome,
                    text: "Add income",
                    color: color1,
                    textColor: color2,
                    size: const Size(150, 40),
                  )
                ],
              ),
            )
          ],
        )));
  }
}

//
