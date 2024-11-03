import 'package:flutter/material.dart';
import 'package:renters_management_front_end/app/components/custom_text.dart';

import '../globals.dart';

class StatementCard extends StatelessWidget {
  StatementCard(
      {required this.monthTotalRent,
      required this.rentersCount,
      required this.payedTotalRent,
      required this.payedRentersCount,
        required this.notPayedTotalRent,
        required this.notPayedRentersCount,
      required this.partiallyPayedTotalRent,
      required this.partiallyPayedRentersCount,
      super.key});

  double monthTotalRent;
  double payedTotalRent;
  double partiallyPayedTotalRent;
  double notPayedTotalRent;
  int notPayedRentersCount;
  int rentersCount;
  int payedRentersCount;
  int partiallyPayedRentersCount;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        decoration: BoxDecoration(
          color: AppColors.inverseCardColor,
          border: Border(
            top: BorderSide(
                color: AppColors.backColor, width: 5, strokeAlign: 1),
            bottom: BorderSide(
                color: AppColors.backColor, width: 5, strokeAlign: 1),
            right: BorderSide(
                color: AppColors.backColor, width: 5, strokeAlign: 1),
            left: BorderSide(
                color: AppColors.backColor, width: 5, strokeAlign: 1),
          ),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38,
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 5),
                blurStyle: BlurStyle.outer)
          ],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            MainText(
              "Total ",
              fontSize: 16,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      MainText(
                        "Total Amount:  ",
                        fontSize: 16,
                      ),
                      SecText("$monthTotalRent",
                          textColor: AppColors.mainTextColor)
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      MainText(
                        "No.Renters:  ",
                        fontSize: 16,
                      ),
                      SecText("$rentersCount",
                          textColor: AppColors.mainTextColor)
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
            Divider(),
            MainText(
              "Fully Payed",
              fontSize: 16,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      MainText(
                        "Total Amount:  ",
                        fontSize: 16,
                      ),
                      SecText("$payedTotalRent",
                          textColor: AppColors.mainTextColor)
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      MainText(
                        "No.Renters:  ",
                        fontSize: 16,
                      ),
                      SecText("$payedRentersCount",
                          textColor: AppColors.mainTextColor)
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
            Divider(),
            MainText(
              "Partially Payed",
              fontSize: 16,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      MainText(
                        "Total Amount:  ",
                        fontSize: 16,
                      ),
                      SecText("$partiallyPayedTotalRent",
                          textColor: AppColors.mainTextColor)
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      MainText(
                        "No.Renters:  ",
                        fontSize: 16,
                      ),
                      SecText("$partiallyPayedRentersCount",
                          textColor: AppColors.mainTextColor)
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
            Divider(),

            MainText(
              "Not Payed",
              fontSize: 16,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      MainText(
                        "Total Amount:  ",
                        fontSize: 16,
                      ),
                      SecText("$notPayedTotalRent",
                          textColor: AppColors.mainTextColor)
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      MainText(
                        "No.Renters:  ",
                        fontSize: 16,
                      ),
                      SecText("$notPayedRentersCount",
                          textColor: AppColors.mainTextColor)
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
            Divider(),

            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainText(
                  "Total Payed Amount:  ",
                  fontSize: 16,
                ),
                SecText((payedTotalRent+partiallyPayedTotalRent).toStringAsFixed(2),
                    textColor: AppColors.mainTextColor)
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainText(
                  "Total Remain Amount:  ",
                  fontSize: 16,
                ),
                SecText((monthTotalRent-(payedTotalRent+partiallyPayedTotalRent)).toStringAsFixed(2),
                    textColor: AppColors.mainTextColor)
              ],
            ),
          ],
        ));
  }
}
