import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/controllers/renter_add_update_card_controller.dart';
import 'package:renters_management_front_end/app/services/print/printing.dart';

import '../components/custom_text.dart';
import '../globals.dart';
import '../models/renter_model.dart';

class RenterPrintingController extends GetxController {
  List<Renter> renters = [];
  Rx<List<Widget>> years = Rx([]);
  RxList<String>? selectedYears = RxList();
  RxBool selectAll = false.obs;
  RxBool includeInstallment = false.obs;

  @override
  void onClose() {
    super.onClose();
    Get.delete<RenterAddUpdateCardController>(force: true);
  }

  @override
  void onInit() async {
    renters = Get.arguments['renters'];
    getYearsDropItemList();
    super.onInit();
  }

  void getYearsDropItemList() {
    years.value = [];
    for (Renter renter in renters) {
      if (renter.rentPayments?.keys != null) {
        renter.rentPayments?.keys.forEach((year) {
          years.value.add(Column(
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
        });
      }
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

  void includeInstallmentChange(bool? val) {
    includeInstallment.value = val ?? false;
  }

  void printing() {
    AppPrinting.printRenterDetailsPrintLayout(renters,
        includeInstallment: includeInstallment.value,
        selectedYears: selectedYears);
  }
}
