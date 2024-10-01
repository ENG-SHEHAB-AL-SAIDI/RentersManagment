import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/models/result.dart';
import 'package:renters_management_front_end/app/services/renter_services.dart';

import '../components/pop_up_cards/alert_message_card.dart';
import '../components/pop_up_cards/delete_confirmation_message_card.dart';
import '../models/renter_model.dart';

class RenterListController extends GetxController {
  TextEditingController searchField = TextEditingController();
  int buildId = -1;
  Rx<List<Renter>?> renters = Rx([]);

  @override
  void onClose() {
    searchField.dispose();
  }

  @override
  void onInit() async {
    buildId = Get.arguments['buildId'];
    Result<List<Renter>> res = await RenterServices.fetchRenters(buildId);
    if (res.statusCode == 200 && res.data != null) {
      renters.value = res.data;
    }else{
      Get.dialog(PopUpAlertCard("fetch Renters field please check your connection", Icons.warning));
    }
    super.onInit();
  }

  @override
  Future<void> refresh()async{
    Result<List<Renter>> res = await RenterServices.fetchRenters(buildId,hardFetch: true);
    if (res.statusCode == 200 && res.data != null) {
      renters.value = res.data;
    }else{
      Get.dialog(PopUpAlertCard("fetch Renters field please check your connection", Icons.warning));
    }

  }

  void searching(String? text) async{
    if(text == null || text == ''){
      Result<List<Renter>> res = await RenterServices.fetchRenters(buildId);
      if (res.statusCode == 200 && res.data != null) {
        renters.value = res.data;
      }else{
        Get.dialog(PopUpAlertCard("fetch Renters field please check your connection", Icons.warning));
      }
    }else{
      List<Renter> matchRenters = [];
      for(Renter item in renters.value??[]){
        if(item.name?.contains(text)??false){
          matchRenters.add(item);
        }
        renters.value = matchRenters;
      }
    }

  }

  void rentersDetailsRoute(int index) {
    Get.toNamed("/rentersDetails", arguments: {'renterId':renters.value?[index].id.value});
  }

  void delete() {
    Get.dialog(PopUpMessageCard(
        "did you sure want delete this renter that will delete all data relative to it."));
  }

  void changeLang(String lang) {
    Get.updateLocale(Locale(lang));
  }

}
