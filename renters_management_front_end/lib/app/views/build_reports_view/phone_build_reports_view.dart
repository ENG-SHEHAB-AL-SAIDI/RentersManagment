import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/expens_card.dart';
import 'package:renters_management_front_end/app/components/income_card.dart';
import 'package:renters_management_front_end/app/components/statement_card.dart';

import '../../components/custom_text.dart';
import '../../controllers/build_reports_controller.dart';
import '../../globals.dart';

class PhoneBuildReportsView extends GetView<BuildReportsController> {
  PhoneBuildReportsView({super.key});

  final Map<String, String> _months = {
    '1': 'January',
    '2': 'February',
    '3': 'March',
    '4': 'April',
    '5': 'May',
    '6': 'June',
    '7': 'July',
    '8': 'August',
    '9': 'September',
    '10': 'October',
    '11': 'November',
    '12': 'December'
  };
  double expansionTileChildrenFontSize = 12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.inverseCardColor,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_outlined,
              color: AppColors.mainIconColor,
            )),
        title: MainText(
          "${_months[controller.month.toString()]} Statement",
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: controller.more,
            color: AppColors.inverseCardColor,
            itemBuilder: (ctx) => [
              PopupMenuItem(
                  value: "print",
                  child: SecText(
                    "Print",
                    textColor: AppColors.mainTextColor,
                  )),
            ],
            child:
                Icon(Icons.more_vert_outlined, color: AppColors.mainTextColor),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Obx(() => (controller.isLoad.value)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: AppColors.backColor,
              height: Get.height,
              padding: EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainText(
                      "Statement Col",
                      textColor: AppColors.inverseSecTextColor,
                      fontSize: 18,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Obx(() => StatementCard(
                          monthTotalRent: controller.monthTotalRent.value,
                          rentersCount: controller.rentersCount.value,
                          payedTotalRent: controller.payedTotalRent.value,
                          payedRentersCount: controller.payedRentersCount.value,
                          partiallyPayedTotalRent:
                              controller.partiallyPayedTotalRent.value,
                          partiallyPayedRentersCount:
                              controller.partiallyPayedRentersCount.value,
                          notPayedTotalRent: controller.notPayedTotalRent.value,
                          notPayedRentersCount:
                              controller.notPayedRentersCount.value,
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    IncomeCard(),
                    ExpensCard(),
                  ],
                ),
              ))),
    );
  }
}
