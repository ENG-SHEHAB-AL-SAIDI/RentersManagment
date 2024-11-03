// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/pop_up_cards/show_notes.dart';
import 'package:renters_management_front_end/app/controllers/renter_details_controller.dart';
import 'package:renters_management_front_end/app/models/rent_payments_model.dart';
import '../globals.dart';
import 'buttons.dart';
import 'custom_text.dart';
enum IncomeOutcomeCardType {
    income,
   outcome
}

class IncomeOutcomeCard extends StatelessWidget {
  IncomeOutcomeCardType type;

  IncomeOutcomeCard({
    super.key,
    required this.type,
    this.initiallyExpanded = false,
  });

  double expansionTileChildrenFontSize = 12;
  Rx<Map<String,Row>> status = Rx({});
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
    return Container(
        margin: const EdgeInsets.symmetric(horizontal:4,vertical: 16),
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
                            "Total ${(type == IncomeOutcomeCardType.income)?"incomes":"outcomes"}:",
                            textColor: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SecText(
                            "0",
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
                  "${(type == IncomeOutcomeCardType.income)?"incomes":"outcomes"} Details",
                  textColor: color1,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                childrenPadding: const EdgeInsets.all(8),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: ((Get.width-60) * (1 / 5)),
                          child: SecText(
                            "Date",
                            textColor: color1,
                            fontSize:
                            Utils.fontSizeScale(expansionTileChildrenFontSize),
                            textAlign: TextAlign.start,
                          )),
                      SizedBox(
                          width: ((Get.width-60) * (1 / 5)),
                          child: SecText(
                            "time",
                            textColor: color1,
                            fontSize:
                            Utils.fontSizeScale(expansionTileChildrenFontSize),
                            textAlign: TextAlign.start,
                          )),
                      SizedBox(
                          width: ((Get.width-60) * (1 / 5)),
                          child: SecText(
                            "Amount",
                            textColor: color1,
                            fontSize:
                            Utils.fontSizeScale(expansionTileChildrenFontSize),
                            textAlign: TextAlign.start,
                          )),
                      SizedBox(
                          width: ((Get.width-60) * (1 / 5)),
                          child:  SecText(
                            "Note",
                            textColor: color1,
                            fontSize:
                            Utils.fontSizeScale(expansionTileChildrenFontSize),
                            // textAlign: TextAlign.start,
                          )),
                      SizedBox(
                        width: ((Get.width-60) * (1 / 5)),
                      )
                    ],
                  ),
                  const Divider(),

                  const SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    onPress:(){},
                    text: "Add ${(type == IncomeOutcomeCardType.income)?"income":"outcome"}",
                    color: color1,
                    textColor: color2,
                    size: const Size(150, 40),
                  )
                ],
              ),
            )
          ],
        ));
  }
}


//
// if (rentPayment?.rentPaymentsInstallment?.isEmpty ??
// true) ...[
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// SecText(
// "Empty",
// textColor: AppColors.inverseSecTextColor,
// ),
// ],
// ),
// ] else ...[
// for (int i = 0;
// i < (rentPayment?.rentPaymentsInstallment?.length ?? 0);
// i++) ...[
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// SizedBox(
// width: ((Get.width-45) * (1 / 5)),
// child:SecText(
// (rentPayment?.rentPaymentsInstallment?[i].date
//     ?.value !=
// null)
// ? controller.dateFormat
//     .format(DateTime.parse(rentPayment!
//     .rentPaymentsInstallment![i]
//     .date!
//     .value))
//     .toString()
//     : "Unknown",
// textColor: color1,
// fontSize: Utils.fontSizeScale(
// expansionTileChildrenFontSize),
// textAlign: TextAlign.start,
// )),
// SizedBox(
// width: ((Get.width-45) * (1 / 5)),
// child:SecText(
// (rentPayment?.rentPaymentsInstallment?[i].date
//     ?.value !=
// null)
// ? controller.timeFormat
//     .format(DateTime.parse(rentPayment!
//     .rentPaymentsInstallment![i]
//     .date!
//     .value))
//     .toString()
//     : "Unknown",
// textColor: color1,
// fontSize: Utils.fontSizeScale(
// expansionTileChildrenFontSize),
// textAlign: TextAlign.start,
// )),
// SizedBox(
// width: ((Get.width-45) * (1 / 5)),
// child: SecText(
// "${rentPayment?.rentPaymentsInstallment?[i].amount?.value ?? "Unknown"}",
// textColor: color1,
// fontSize: Utils.fontSizeScale(
// expansionTileChildrenFontSize),
// textAlign: TextAlign.start,
// )),
// SizedBox(
// width: ((Get.width-45) * (1 / 5)),
// child: TextButton(
// onPressed:()async{
// await Get.dialog(const PopUpShowNotesCard(),arguments: {
// "notes":rentPayment?.rentPaymentsInstallment?[i].notes?.value??"help",
// 'other':"done",
// });
// },
// child: SecText(
// "show",
// textColor: color1,
// fontSize: Utils.fontSizeScale(
// expansionTileChildrenFontSize),
// textAlign: TextAlign.start,
// ),
// ),
// ),
// SizedBox(
// width: ((Get.width-45) * (1 / 5)),
// child: IconButton(
// onPressed: ()=>controller.deleteInstallment(rentPayment?.id.value,rentPayment?.rentPaymentsInstallment?[i].id.value),
// icon: Icon(
// Icons.delete,
// color: color1,
// )),
// )
// ],
// ),
// const Divider(),
// ],
// ],