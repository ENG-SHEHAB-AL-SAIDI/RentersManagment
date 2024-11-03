import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/services/build_services.dart';

import '../components/custom_text.dart';

class BuildReportsListController extends GetxController {
  int buildId = -1;
  RxString selectedYear = ''.obs;
  Rx<List<DropdownMenuItem<String>>> years = Rx([]);

  @override
  void onInit() {
    buildId = Get.arguments["buildId"];
    getYearsDropItemList();
    super.onInit();
  }

  void getYearsDropItemList() async {
    List<String> buildYears = await BuildServices.getBuildYears(buildId);
    years.value = [];
    for (String year in buildYears) {
      years.value.add(DropdownMenuItem<String>(
        value: year,
        child: MainText(year,fontSize: 18,),
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
      print(val);
    }
  }

  void routeReportView(int month){
    Get.toNamed("/buildReports",arguments: {
      "buildId":buildId,
      "year":selectedYear.value,
      "month":month,

    });
  }
}
