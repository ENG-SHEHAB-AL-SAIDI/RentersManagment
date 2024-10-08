import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/pop_up_cards/add_and_update_renter_card.dart';
import 'package:renters_management_front_end/app/controllers/renter_add_update_card_controller.dart';
import 'package:renters_management_front_end/app/models/result.dart';
import 'package:renters_management_front_end/app/services/renter_services.dart';

import '../components/pop_up_cards/alert_message_card.dart';
import '../components/pop_up_cards/delete_confirmation_message_card.dart';
import '../models/renter_model.dart';

class RenterListController extends GetxController {
  TextEditingController searchField = TextEditingController();
  int buildId = -1;
  Rx<List<Renter>> renters = Rx([]);

  @override
  void onClose() {
    searchField.dispose();
    super.onClose();
    Get.delete<RenterAddUpdateCardController>(force: true);
  }

  @override
  void onInit() async {
    buildId = Get.arguments['buildId'];
    Result<List<Renter>> res = await RenterServices.fetchRenters(buildId);
    if (res.statusCode == 200 && res.data != null) {
      renters.value = res.data!;
    } else {
      Get.dialog(PopUpAlertCard(
          "fetch Renters field please check your connection", Icons.warning));
    }
    super.onInit();
  }

  @override
  Future<void> refresh() async {
    Result<List<Renter>> res =
        await RenterServices.fetchRenters(buildId, hardFetch: true);
    if (res.statusCode == 200 && res.data != null) {
      renters.value = res.data!;
    } else {
      Get.dialog(PopUpAlertCard(
          "fetch Renters field please check your connection", Icons.warning));
    }
  }


  void searching(String? text) async {
    if (text == null || text == '') {
      Result<List<Renter>> res = await RenterServices.fetchRenters(buildId);
      if (res.statusCode == 200 && res.data != null) {
        renters.value = res.data!;
      } else {
        Get.dialog(PopUpAlertCard(
            "fetch Renters field please check your connection", Icons.warning));
      }
    } else {
      List<Renter> matchRenters = [];
      for (Renter item in renters.value) {
        if (item.name?.contains(text) ?? false) {
          matchRenters.add(item);
        }
        renters.value = matchRenters;
      }
    }
  }

  void rentersDetailsRoute(int index) {
    Get.toNamed("/rentersDetails", arguments: {
      'buildId': buildId,
      'renterId': renters.value[index].id.value
    });
  }

  void delete(int id) async {
    bool result = await Get.dialog(PopUpMessageCard(
        "did you sure want delete this renter that will delete all data relative to it."));
    if (result) {
      Result res =
          await RenterServices.deleteRenter(buildId: buildId, renterId: id);
      if (res.statusCode == 200) {
        renters.refresh();
      } else {
        Get.dialog(PopUpAlertCard(
            res.message ?? "error code:${res.statusCode}", Icons.warning));
      }
    }
  }

  void add() async {
    Map<String, dynamic>? result =
        await Get.dialog(const PopUpIAddAndUpdateRenterCard(),arguments: {
          'mode': "Add",
          'data': null
        });
    if (result != null) {
      Result res =
          await RenterServices.storeRenter(buildId: buildId, data: result);
      if (res.statusCode == 200) {
        if (res.data != null) {
          renters.refresh();
        }
      } else {
        Get.dialog(PopUpAlertCard(
            res.message ?? "error code:${res.statusCode}", Icons.warning));
      }
    }
  }

  void changeLang(String lang) {
    Get.updateLocale(Locale(lang));
  }
}
