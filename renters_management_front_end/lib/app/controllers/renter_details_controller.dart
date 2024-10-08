import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/globals.dart';
import 'package:renters_management_front_end/app/models/result.dart';
import 'package:renters_management_front_end/app/services/renter_services.dart';

import '../components/custom_text.dart';
import '../components/pop_up_cards/alert_message_card.dart';
import '../models/renter_model.dart';

class RenterDetailsController extends GetxController {
  TextEditingController searchField = TextEditingController();
  int renterId = -1;
  int buildId = -1;
  Renter? renter;
  RxBool loadingState = true.obs;
  RxString selectedPhone = ''.obs;
  RxString selectedYear = ''.obs;
  Rx<List<DropdownMenuItem<String>>> phones = Rx([]);
  Rx<List<DropdownMenuItem<String>>> years = Rx([]);

  @override
  void onClose() {
    searchField.dispose();
  }

  @override
  void onInit() async {
    buildId = Get.arguments['buildId'];
    renterId = Get.arguments['renterId'];

    Result<Renter> res = await RenterServices.fetchRenter(buildId, renterId);
    if (res.statusCode == 200 && res.data != null) {
      renter = res.data;
      print(renter?.rentPayments?[0]?[0].rentPaymentsInstallment);
    } else {
      Get.dialog(PopUpAlertCard(
          "fetch Renters field please check your connection", Icons.warning));
    }
    getPhonesDropItemList();
    getYearsDropItemList();
    loadingState.value = false;
    super.onInit();
  }

  @override
  Future<void> refresh() async {
    Result<Renter> res =
        await RenterServices.fetchRenter(buildId, renterId, hardFetch: true);
    if (res.statusCode == 200 && res.data != null) {
      renter = res.data;
    } else {
      Get.dialog(PopUpAlertCard(
          "fetch Renters field please check your connection", Icons.warning));
    }
  }

  void getPhonesDropItemList() {
    if (renter != null) {
      renter!.phones?.forEach((phone) {
        phones.value.add(DropdownMenuItem<String>(
          value: phone.value,
          child: SecText(phone.value, textColor: AppColors.mainTextColor),
        ));
      });
    }
    phones.value.add(DropdownMenuItem<String>(
      value: "",
      child: Icon(Icons.add, color: AppColors.mainIconColor),
    ));
    selectedPhone.value =
        (phones.value.isNotEmpty) ? phones.value.first.value ?? "" : "";
  }

  void changeSelectedPhone(value) {
    if (value != "") {
      selectedPhone.value = value;
    } else {
      if (kDebugMode) {
        print("tab");
      }
    }
  }

  void getYearsDropItemList() {
    if (renter != null && renter!.rentPayments?.keys != null) {
      renter!.rentPayments?.keys.forEach((year) {
        years.value.add(DropdownMenuItem<String>(
          value: year,
          child: SecText(year, textColor: AppColors.mainTextColor),
        ));
      });
    }
    years.value.add(DropdownMenuItem<String>(
      value: "",
      child: Icon(Icons.add, color: AppColors.mainIconColor),
    ));
    selectedYear.value =
        (years.value.isNotEmpty) ? years.value.first.value ?? "" : "";
  }

  void changeSelectedYear(value) {
    if (value != "") {
      selectedYear.value = value;
    } else {
      if (kDebugMode) {
        print("tab");
      }
    }
  }
}
