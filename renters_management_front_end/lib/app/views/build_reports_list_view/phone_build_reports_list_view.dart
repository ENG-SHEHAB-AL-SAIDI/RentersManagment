import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/custom_text.dart';
import '../../controllers/build_reports_list_controller.dart';
import '../../globals.dart';

class PhoneBuildReportsListView extends GetView<BuildReportsListController> {
  PhoneBuildReportsListView({super.key});

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
          title: MainText("Build Report"),
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
              child: Icon(Icons.more_vert_outlined,
                  color: AppColors.mainTextColor),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: Container(
          color: AppColors.backColor,
          padding: EdgeInsets.all(16),
          child: Obx(() => Column(
                children: [
                  Card(
                    color: AppColors.inverseCardColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MainText(
                          "Select Year",
                          fontSize: 18,
                        ),
                        DropdownButton<String>(
                          value: controller.selectedYear.value,
                          elevation: 6,
                          icon: Icon(Icons.arrow_drop_down_sharp,
                              color: AppColors.mainIconColor),
                          underline: const SizedBox(),
                          dropdownColor: AppColors.inverseCardColor,
                          onChanged: controller.changeSelectedYear,
                          items: controller.years.value,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: 24,
                          itemBuilder: (BuildContext ctx, int i) {
                            final index = (i ~/ 2) + 1;
                            if (i.isOdd) {
                              return  Divider(
                                color: AppColors.inverseSecTextColor,
                              );
                            }
                            return SizedBox(
                              height: (Get.height*0.58)/12,
                              child: ListTile(
                                  contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 4,vertical: 0),
                                  leading: CircleAvatar(
                                    backgroundColor: AppColors.inverseIconColor,
                                    radius: 16,
                                    child: MainText(
                                      "$index",
                                      textAlign: TextAlign.start,fontSize: 16,
                                    ),
                                  ),
                                  title: MainText(
                                    "${_months[index.toString()]} Statement",
                                    textColor: AppColors.inverseMainTextColor,
                                    textAlign: TextAlign.start,
                                    fontSize: 18,
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppColors.inverseIconColor,
                                  ),
                                  onTap: ()=>controller.routeReportView(index)),
                            );
                          }))
                ],
              )),
        ));
  }
}
