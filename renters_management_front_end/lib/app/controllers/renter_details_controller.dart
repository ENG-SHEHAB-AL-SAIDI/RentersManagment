import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/pop_up_cards/add_phone_card.dart';
import 'package:renters_management_front_end/app/globals.dart';
import 'package:renters_management_front_end/app/models/result.dart';
import 'package:renters_management_front_end/app/services/renter_services.dart';

import '../components/custom_text.dart';
import '../components/pop_up_cards/add_and_update_renter_card.dart';
import '../components/pop_up_cards/alert_message_card.dart';
import '../models/renter_model.dart';

class RenterDetailsController extends GetxController {
  TextEditingController searchField = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
    phoneController.dispose();

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

  String? validatePhone(String? phone) {
    if (!GetUtils.isLengthEqualTo(phone, 0) &&
        !GetUtils.isLengthEqualTo(phone, 9)) {
      return "Number should be 9 digits";
    }
    else if ((renter?.phones!
        .contains(RxString(phoneController.text)) ??
        false)){
      return "this number already exist";
    }
    return null;
  }

  void getPhonesDropItemList() {
    phones.value = [];
    if (renter != null) {
      renter!.phones?.forEach((phone) {
        phones.value.add(DropdownMenuItem<String>(
          value: phone.value,
          child: SecText(phone.value, textColor: AppColors.mainTextColor),
        ));
      });
    }
    if(phones.value.isNotEmpty){
      phones.value.add(DropdownMenuItem<String>(
        value: "",
        child: Icon(Icons.add, color: AppColors.mainIconColor),
      ));
      selectedPhone.value = phones.value.first.value!;
    }else{
      selectedPhone.value = "";
    }
  }

  void changeSelectedPhone(value) {
    if (value != "") {
      selectedPhone.value = value;
    } else {
      if (kDebugMode) {
        selectedPhone.value = "";
        Get.dialog(const PopUpAddPhoneCard());
      }
    }
  }

  void getYearsDropItemList() {
    years.value = [];
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

  void addPhone()async {
    if (formKey.currentState?.validate() ?? false) {
      Result res =
          await RenterServices.renterAddPhone(buildId: buildId,
          data: {'phone': phoneController.text},
          renterId: renterId);
      if (res.statusCode == 200) {
        if (res.data) {
          Get.back();
          getPhonesDropItemList();
          phoneController.clear();
        }
      } else {
        Get.dialog(PopUpAlertCard(
            res.message ?? "error code:${res.statusCode}", Icons.warning));
      }
    }
    }

  void deletePhone()async {
    if(selectedPhone.value != ""){
    Result res =
    await RenterServices.renterDeletePhone(buildId: buildId,
        data: {'phone': selectedPhone.value},
        renterId: renterId);
    if (res.statusCode == 200) {
      if (res.data) {
        getPhonesDropItemList();
      }
    } else {
      Get.dialog(PopUpAlertCard(
          res.message ?? "error code:${res.statusCode}", Icons.warning));
    }
  }
  }

  void renterUpdate() async {
    Map<String, dynamic>? result =
    await Get.dialog(const PopUpIAddAndUpdateRenterCard(),arguments: {
      'mode': "Update",
      'data': {
        "name":renter?.name?.value??"",
        "rent":renter?.rent?.value.toString()??"",
        "activity":(renter?.jobDomain?.value == "Unknown".tr)?"":renter?.jobDomain?.value??"",
        "entryYear":(renter?.enterDate?.value == "Unknown".tr)?"":renter?.enterDate?.value??"",
        "phone":selectedPhone.value,
      }
    });
    if (result != null) {
      Result<Renter> res =
      await RenterServices.updateRenter(buildId: buildId,renterId: renterId, data: result);
      if (res.statusCode == 200) {
        if (res.data != null) {
          renter?.name?.value = res.data!.name!.value;
          renter?.rent?.value = res.data!.rent!.value;
          renter?.enterDate?.value = res.data!.enterDate!.value;
          renter?.jobDomain?.value = res.data!.jobDomain!.value;
          renter?.phones = res.data!.phones;
          getPhonesDropItemList();

        }
      } else {
        Get.dialog(PopUpAlertCard(
            res.message ?? "error code:${res.statusCode}", Icons.warning));
      }
    }
  }

  }
