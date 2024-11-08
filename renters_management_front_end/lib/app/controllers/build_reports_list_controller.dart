import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/pop_up_cards/statement_print_setting_card.dart';
import 'package:renters_management_front_end/app/services/build_services.dart';
import 'package:renters_management_front_end/app/services/print/printing.dart';
import 'package:renters_management_front_end/app/services/statement_services.dart';

import '../components/custom_text.dart';
import '../globals.dart';
import '../models/statement_model.dart';
import 'build_reports_controller.dart';

class BuildReportsListController extends GetxController {
  int buildId = -1;
  RxString selectedYear = ''.obs;
  Rx<List<DropdownMenuItem<String>>> years = Rx([]);
  Rx<List<Widget>> printYears = Rx([]);
  RxList<String>? selectedYears = RxList();
  RxBool selectAll = false.obs;

  @override
  void onInit() async{
    buildId = await Get.arguments["buildId"];
     getYearsDropItemList();
    super.onInit();
  }

  void getYearsDropItemList() async {
    List<String> buildYears = await BuildServices.getBuildYears(buildId);
    years.value = [];
    for (String year in buildYears) {
      years.value.add(DropdownMenuItem<String>(
        value: year,
        child: MainText(
          year,
          fontSize: 18,
        ),
      ));

      printYears.value.add(Column(
        children: [
          ListTile(
            leading: Obx(() => Checkbox(
              value: (selectAll.value) ||
                  (selectedYears?.contains(year) ?? false),
              onChanged: (value) {
                if (value == true) {
                  selectedYears?.addIf(
                      ((selectedYears?.contains(year)??false) == false), year);
                } else {
                  selectedYears?.remove(year);
                }
              },
            )),
            title: SecText(
              year,
              textColor: AppColors.secTextColor,
              textAlign: TextAlign.start,
            ),
          ),
          Divider(),
        ],
      ));
    }
    selectedYear.value =
        (years.value.isNotEmpty) ? years.value.first.value ?? "" : "";
  }

  void changeSelectedYear(value) {
    if (value != "") {
      selectedYear.value = value;
    }
  }

  void more(String val) {
    if (val == "print") {
      Get.dialog(PopUpStatementPrintSettingCard());
    }
  }

  void selectAllChange(bool? val) {
    if (val == true) {
      selectAll.value = true;
      selectedYears = null;
    } else {
      selectAll.value = false;
      selectedYears = RxList();
    }
  }

  void printing() async {
    BuildReportsController controller =  Get.put<BuildReportsController>(BuildReportsController());
    controller.buildId = buildId;

    List<Statement> statements = [];
    Map<String, List<Statement>> res =
        await StatementServices.fetchStatements(buildId)
            .then((e) => e.data ?? {});
    for (String key in selectedYears??[]) {
      if (res[key] != null) {
        for (Statement statement in res[key]!) {
          statements.add(statement);
        }
      }
    }
    await AppPrinting.printStatementsPrintLayout(
        statements,
        await BuildServices.fetchBuild(id: buildId)
            .then((e) => e.data?.name?.value ?? ""));

    Get.delete<BuildReportsController>();
  }

  void routeReportView(int month) {
    Get.toNamed("/buildReports", arguments: {
      "buildId": buildId,
      "year": selectedYear.value,
      "month": month,
    });
  }
}
