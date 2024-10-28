import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:renters_management_front_end/app/components/pop_up_cards/add_installment.dart';
import 'package:renters_management_front_end/app/components/pop_up_cards/add_phone_card.dart';
import 'package:renters_management_front_end/app/components/pop_up_cards/add_year.dart';
import 'package:renters_management_front_end/app/components/pop_up_cards/renter_print_setting_card.dart';
import 'package:renters_management_front_end/app/controllers/show_notes_controller.dart';
import 'package:renters_management_front_end/app/globals.dart';
import 'package:renters_management_front_end/app/models/rent_payments_model.dart';
import 'package:renters_management_front_end/app/models/result.dart';
import 'package:renters_management_front_end/app/services/print/printing.dart';
import 'package:renters_management_front_end/app/services/renter_services.dart';
import 'package:renters_management_front_end/app/services/rentpayment_services.dart';
import 'package:renters_management_front_end/app/services/year_services.dart';

import '../components/custom_text.dart';
import '../components/pop_up_cards/add_and_update_renter_card.dart';
import '../components/pop_up_cards/alert_message_card.dart';
import '../components/pop_up_cards/delete_confirmation_message_card.dart';
import '../models/renter_model.dart';
import 'installment_add_controller.dart';

class RenterDetailsController extends GetxController {
  TextEditingController searchField = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int renterId = -1;
  int buildId = -1;
  Renter? renter;
  RxBool loadingState = true.obs;
  RxString selectedPhone = ''.obs;
  RxString selectedYear = ''.obs;
  Rx<List<DropdownMenuItem<String>>> phones = Rx([]);
  Rx<List<DropdownMenuItem<String>>> years = Rx([]);
  DateFormat dateFormat = DateFormat("yyyy-dd-MM");
  DateFormat timeFormat = DateFormat("hh:mm a");
  DateFormat dateTimeFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  // DateTime dateTime = format.parse(dateString);

  @override
  void onClose() {
    searchField.dispose();
    phoneController.dispose();
    yearController.dispose();
    Get.delete<InstallmentAddController>(force: true);
    Get.delete<ShowNotesController>(force: true);
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
    } else if ((renter?.phones!.contains(RxString(phoneController.text)) ??
        false)) {
      return "this number already exist";
    }
    return null;
  }

  String? validateYear(String? year) {
    if ((renter?.rentPayments!.containsKey(year) ??
        false)) {
      return "this year already exist";
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
    if (phones.value.isNotEmpty) {
      phones.value.add(DropdownMenuItem<String>(
        value: "",
        child: Icon(Icons.add, color: AppColors.mainIconColor),
      ));
      selectedPhone.value = phones.value.first.value!;
    } else {
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
      Get.dialog(const PopUpAddYearCard());
    }
  }

  void addPhone() async {
    if (formKey.currentState?.validate() ?? false) {
      Result res = await RenterServices.renterAddPhone(
          buildId: buildId,
          data: {'phone': phoneController.text},
          renterId: renterId);
      if (res.statusCode == 200) {
        if (res.data) {
          Get.back();
          getPhonesDropItemList();
          selectedPhone.value = phoneController.text;
          phoneController.clear();
        }
      } else {
        Get.dialog(PopUpAlertCard(
            "${res.message ?? ""}\n error code:${res.statusCode}",
            Icons.warning));
      }
    }
  }

  void deletePhone() async {
    if (selectedPhone.value != "") {
      Result res = await RenterServices.renterDeletePhone(
          buildId: buildId,
          data: {'phone': selectedPhone.value},
          renterId: renterId);
      if (res.statusCode == 200) {
        if (res.data) {
          getPhonesDropItemList();
        }
      } else {
        Get.dialog(PopUpAlertCard(
            "${res.message ?? ""}\n error code:${res.statusCode}",
            Icons.warning));
      }
    }
  }

  void addYear() async {
    if (formKey.currentState?.validate() ?? false) {
      Result res = await YearServices.addYearToRenter(
          buildId: buildId,
          renterId: renterId,
          data: {"year": yearController.text},);

      if (res.statusCode == 200) {
        if (res.data) {
          Get.back();
          getYearsDropItemList();
          selectedYear.value = yearController.text;
          yearController.clear();
        }
      } else {
        Get.dialog(PopUpAlertCard(
            "${res.message ?? ""}\n error code:${res.statusCode}",
            Icons.warning));
      }
    }
  }

  void deleteYear() async {
    if (selectedYear.value != "") {
      Result res = await YearServices.deleteYearFromRenter(
          buildId: buildId,
          data: {"year": selectedYear.value},
          renterId: renterId);
      if (res.statusCode == 200) {
        if (res.data) {
          getYearsDropItemList();
        }
      } else {
        Get.dialog(PopUpAlertCard(
            "${res.message ?? ""}\n error code:${res.statusCode}",
            Icons.warning));
      }
    }
  }

  void addInstallment(int? paymentId, double? amount) async {
    if (paymentId == null || amount == null) {
      return;
    }
    Map<String, dynamic>? result = await Get.dialog(
        const PopUpAddInstallmentCard(),
        arguments: {"amount": amount});
    if (result != null) {
      DateTime time = timeFormat.parse(result["time"]);
      DateTime date = dateFormat.parse(result["date"]);
      DateTime dateTime = DateTime(
          date.year, date.month, date.day, time.hour, time.minute, time.second);
      Result res = await RentPaymentServices.rentPaymentAddInstallment(
          buildId: buildId,
          renterId: renterId,
          rentPaymentId: paymentId,
          data: {
            "date": dateTimeFormat.format(dateTime),
            "amount": double.parse(result["amount"]),
            "note": result["note"]
          });
      if (res.statusCode == 200) {
        if (res.data != null) {
          renter?.rentPayments?.refresh();
        }
      } else {
        Get.dialog(PopUpAlertCard(
            "${res.message ?? ""}\n error code:${res.statusCode}",
            Icons.warning));
      }
    }
  }

  void deleteInstallment(int? paymentId, int? installmentId) async {
    if (paymentId == null || installmentId == null) {
      return;
    }
    bool result = await Get.dialog(
        PopUpMessageCard("did you sure want delete this Installment."));
    if (result) {
      Result res = await RentPaymentServices.rentPaymentDeleteInstallment(
          buildId: buildId,
          renterId: renterId,
          rentPaymentId: paymentId,
          installmentId: installmentId);

      if (res.statusCode == 200) {
        if (res.data != null) {
          renter?.rentPayments?.refresh();
        }
      } else {
        Get.dialog(PopUpAlertCard(
            "${res.message ?? ""}\n error code:${res.statusCode}",
            Icons.warning));
      }
    }
  }

  void renterUpdate() async {
    Map<String, dynamic>? result =
        await Get.dialog(const PopUpIAddAndUpdateRenterCard(), arguments: {
      'mode': "Update",
      'data': {
        "name": renter?.name?.value ?? "",
        "rent": renter?.rent?.value.toString() ?? "",
        "activity": (renter?.jobDomain?.value == "Unknown".tr)
            ? ""
            : renter?.jobDomain?.value ?? "",
        "entryYear": (renter?.enterDate?.value == "Unknown".tr)
            ? ""
            : renter?.enterDate?.value ?? "",
        "phone": selectedPhone.value,
      }
    });
    if (result != null) {
      Result<Renter> res = await RenterServices.updateRenter(
          buildId: buildId, renterId: renterId, data: result);
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
            "${res.message ?? ""}\n error code:${res.statusCode}",
            Icons.warning));
      }
    }
  }

  void more(String val) {
    if (val == "edit") {
      renterUpdate();
    } else if (val == "print") {
      if(renter == null){
        return;
      }
      Get.dialog(PopUpRenterPrintSettingCard(),arguments: {
        "renters":[renter!]
      });
    }
  }

  void paymentMore(String val, RentPayment rentPayment) {
    if (val == "clear") {
      if (kDebugMode) {
        print("clear");
      }
    } else if (val == "print") {
      AppPrinting.printSingleRentPaymentPrintLayout(
          rentPayment, renter?.name?.value ?? "", renter?.rent?.value ?? 0);
    }
  }
}
