import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/models/result.dart';
import 'package:renters_management_front_end/app/services/renter_services.dart';

import '../components/pop_up_cards/alert_message_card.dart';
import '../models/renter_model.dart';

class RenterDetailsController extends GetxController {
  TextEditingController searchField = TextEditingController();
  int renterId = -1;
  int buildId = -1;
  Renter? renter;

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
}
