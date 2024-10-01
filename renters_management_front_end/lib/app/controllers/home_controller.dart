import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/pop_up_cards/alert_message_card.dart';
import 'package:renters_management_front_end/app/models/result.dart';
import 'package:renters_management_front_end/app/services/build_services.dart';

import '../components/pop_up_cards/delete_confirmation_message_card.dart';
import '../components/pop_up_cards/update_build_card.dart';
import '../models/build_model.dart';

class HomeController extends GetxController {
  // TextEditingController search = TextEditingController();
  Rx<List<Build>?> builds = Rx([]);
  RxBool lodeState = true.obs;
  RxString errorMessage = "No Builds yet\n add some ".obs;

  @override
  void onInit() async{
    Result<List<Build>> res = await BuildServices.fetchBuilds();
    if(res.statusCode == 200 && res.data != null){
      builds.value = res.data;
      if (builds.value == []){
        errorMessage.value = "No Builds yet\n add some ";
      }
    }else{
      errorMessage.value = "can't fetch builds \n place check your connection";
      Get.dialog(PopUpAlertCard("fetch Builds field please check your connection", Icons.warning));
    }

    lodeState.value = false;
    super.onInit();
  }


  @override
  Future<void> refresh() async{
    lodeState.value = true;
    Result<List<Build>> res = await BuildServices.fetchBuilds(hardFetch: true);
    if(res.statusCode == 200 && res.data != null){
      builds.value = res.data;
    }else{
      Get.dialog(PopUpAlertCard("fetch Builds field please check your connection", Icons.warning));
    }
    lodeState.value = false;
    super.refresh();
  }

  void edit(int i) {
    Get.dialog(const PopUpIUpdateBuildCard());
  }

  void delete(int i) {
    Get.dialog(PopUpMessageCard(
        "did you sure want delete this build that will delete all data relative to it."));
  }

  void rentersListRoute(int id) {
    Get.toNamed("/rentersList", arguments: {'buildId':id});
  }

  void buildReportRoute(int id) {
    Get.toNamed("/buildReports",  arguments: {'buildId':id});
  }

}
