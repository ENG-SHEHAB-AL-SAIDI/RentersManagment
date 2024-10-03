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
  Rx<List<DropdownMenuItem<String>>> phones = Rx([]);

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
    } else {
      Get.dialog(PopUpAlertCard(
          "fetch Renters field please check your connection", Icons.warning));
    }
    getPhonesDropItemList();
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
    selectedPhone.value = phones.value.first.value ?? "";
  }

  void changeSelectedPhone(value){
    selectedPhone.value = value;
  }


  void getYearsDropItemList() {
    if (renter != null) {
      renter!.phones?.forEach((phone) {
        phones.value.add(DropdownMenuItem<String>(
          value: phone.value,
          child: SecText(phone.value, textColor: AppColors.mainTextColor),
        ));
      });
    }
    selectedPhone.value = phones.value.first.value ?? "";
  }

  void changeSelectedYear(value){
    selectedPhone.value = value;
  }
// void setYearlist() {
//   if (widget.name.isNotEmpty) {
//     year = [];
//     DataCollection.rentersInfo[widget.name]!.year!.keys.map((element) {
//       year.add(DropdownMenuItem<String>(
//           value: element.toString(),
//           child: SecText(element.toString(),
//               color: AppColors.mainTextColor)));
//     }).toList();
//     if (year.isNotEmpty) {
//       if (widget.selectedYear != "") {
//         print(year[1].value);
//         selectYear = widget.selectedYear;
//       } else
//         selectYear = year[0].value;
//     } else
//       selectYear = null;
//   }
// }
}
