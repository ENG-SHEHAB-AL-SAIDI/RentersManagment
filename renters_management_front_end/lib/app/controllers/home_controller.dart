import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/pop_up_cards/alert_message_card.dart';
import 'package:renters_management_front_end/app/models/result.dart';
import 'package:renters_management_front_end/app/services/build_services.dart';

import '../components/pop_up_cards/add_and_update_build_card.dart';
import '../components/pop_up_cards/delete_confirmation_message_card.dart';
import '../models/build_model.dart';
import '../models/user_model.dart';
import '../services/user_services.dart';

class HomeController extends GetxController {
  Rx<List<Build>> builds = Rx([]);
  RxBool lodeState = true.obs;
  RxString errorMessage = "No Builds yet\n add some ".obs;
  ScrollController scrollController = ScrollController();
  User? user ;

  @override
  void onInit() async {
    Result res1 = await UserServices.fetchUser();
    user = res1.data;

    Result<List<Build>> res = await BuildServices.fetchBuilds();
    if (res.statusCode == 200 && res.data != null) {
      if (res.data != null) {
        builds.value = res.data!;
      } else {
        errorMessage.value = "No Builds yet\n add some ";
      }
      if (builds.value == []) {
        errorMessage.value = "No Builds yet\n add some ";
      }
    } else {
      errorMessage.value = "can't fetch builds \n place check your connection";
      Get.dialog(PopUpAlertCard(
          "fetch Builds field please check your connection \n error code:${res.statusCode}", Icons.warning));
    }

    lodeState.value = false;
    super.onInit();
  }

  @override
  Future<void> refresh() async {
    if (kDebugMode) {
      print("init");
    }
    lodeState.value = true;
    Result<List<Build>> res = await BuildServices.fetchBuilds(hardFetch: true);
    if (res.statusCode == 200) {
      if (res.data != null) {
        builds.value = res.data!;
      } else {
        errorMessage.value = "No Builds yet\n add some ";
      }
    } else if (res.statusCode == 100) {
      Result<List<Build>> res =
          await BuildServices.fetchBuilds(hardFetch: true);
      if (res.statusCode == 200) {
        if (res.data != null) {
          builds.value = res.data!;
        } else {
          errorMessage.value = "No Builds yet\n add some ";
        }
      }
    } else {
      errorMessage.value = "can't fetch builds \n place check your connection";
      Get.dialog(PopUpAlertCard(
          "fetch Builds field please check your connection", Icons.warning));
    }

    lodeState.value = false;
    super.refresh();
  }

  void add() async{
    Map<String,dynamic>? result = await Get.dialog(PopUpIAddAndUpdateBuildCard());
    if(result!=null){
      Result res = await BuildServices.storeBuild(data: result);
      if (res.statusCode == 200) {
        if (res.data != null) {
          builds.refresh();
          scrollController.animateTo(scrollController.position.maxScrollExtent+500,
            duration: Duration(milliseconds:300 ), // Adjust duration as needed
            curve: Curves.easeOut,          // Adjust curve for scroll animation
          );
        }
      } else {
        Get.dialog(PopUpAlertCard(
            res.message??"error code:${res.statusCode}",
            Icons.warning));
      }
    }
  }


  void edit(int id) async{
    Build build = builds.value.firstWhere((element)=>element.id.value == id);
    Map<String,dynamic>? result = await Get.dialog(PopUpIAddAndUpdateBuildCard(mode: "Update",data: {
      "buildName":build.name?.value??"",
      "city":build.city?.value??"",
      "address":build.address?.value??"",

    },));
    if(result!=null){
      Result res = await BuildServices.updateBuild(id: id,data: result);
      if (res.statusCode == 200) {
        if (res.data != null){
          builds.refresh();
        }
      } else {
        Get.dialog(PopUpAlertCard(
            res.message??"error code:${res.statusCode}",
            Icons.warning));
      }
    }
  }

  void delete(int id) async {
    bool res = await Get.dialog(PopUpMessageCard(
        "did you sure want delete this build that will delete all data relative to it."));
    if (res) {
      Result res = await BuildServices.deleteBuild(id: id);
      if (res.statusCode == 200) {
        builds.refresh();
      }else{
        Get.dialog(PopUpAlertCard(
            res.message??"error ${res.statusCode}",
            Icons.warning));
      }
      if (kDebugMode) {
        print(res.statusCode);
      }
    }
  }

  void rentersListRoute(int id) async {
    await Get.toNamed("/rentersList", arguments: {'buildId': id});
    builds.value.firstWhere((e)=>e.id.value==id).numRenters?.refresh();
  }

  void buildReportRoute(int id) {
    Get.toNamed("/buildReportsList", arguments: {'buildId': id});

  }
}
