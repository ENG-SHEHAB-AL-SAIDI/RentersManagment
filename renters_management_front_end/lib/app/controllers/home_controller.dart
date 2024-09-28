import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/pop_up_cards/alert_message_card.dart';
import 'package:renters_management_front_end/app/models/result.dart';
import 'package:renters_management_front_end/app/services/build_services.dart';

import '../models/build_model.dart';

class HomeController extends GetxController {
  // TextEditingController search = TextEditingController();
  Rx<List<Build>?> builds = Rx([]);


  @override
  void onInit() async{
    Result<List<Build>> res = await BuildServices.fetchBuilds();
    if(res.statusCode == 200 && res.data != null){
      builds.value = res.data;
    }else{
      Get.dialog(PopUpAlertCard("fetch Builds field please check your connection", Icons.warning));
    }
    super.onInit();
  }


  @override
  Future<void> refresh() async{
    Result<List<Build>> res = await BuildServices.fetchBuilds(hardFetch: true);
    if(res.statusCode == 200 && res.data != null){
      builds.value = res.data;
    }else{
      Get.dialog(PopUpAlertCard("fetch Builds field please check your connection", Icons.warning));
    }
    super.refresh();
  }

}
