import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BuildReportsController extends GetxController {
  int buildId = -1;
  String selectedYear = '';
  String selectedMonth = '';
  Rx<List<DropdownMenuItem<String>>> years = Rx([]);

  @override
  void onInit() {
    buildId = Get.arguments["buildId"];
    super.onInit();
  }


  void more(String val) {
    if (val == "print") {
      print(val);
    }
  }
}
