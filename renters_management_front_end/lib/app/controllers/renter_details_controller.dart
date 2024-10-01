// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:renters_management_front_end/app/models/result.dart';
// import 'package:renters_management_front_end/app/services/renter_services.dart';
//
// import '../components/pop_up_cards/alert_message_card.dart';
// import '../models/renter_model.dart';
//
// class RenterListController extends GetxController {
//   TextEditingController searchField = TextEditingController();
//   int renterId = -1;
//   Renter? renter ;
//
//   @override
//   void onClose() {
//     searchField.dispose();
//   }
//
//   @override
//   void onInit() async {
//     renterId = Get.arguments['renterId'];
//     Result<List<Renter>> res = await RenterServices.fetchRenters(buildId);
//     if (res.statusCode == 200 && res.data != null) {
//
//     }else{
//       Get.dialog(PopUpAlertCard("fetch Renters field please check your connection", Icons.warning));
//     }
//     super.onInit();
//   }
//
//   @override
//   Future<void> refresh()async{
//     Result<List<Renter>> res = await RenterServices.fetchRenters(buildId,hardFetch: true);
//     if (res.statusCode == 200 && res.data != null) {
//       renters.value = res.data;
//     }else{
//       Get.dialog(PopUpAlertCard("fetch Renters field please check your connection", Icons.warning));
//     }
//
//   }
//
//   void searching(String? text) async{
//     if(text == null || text == ''){
//       Result<List<Renter>> res = await RenterServices.fetchRenters(buildId);
//       if (res.statusCode == 200 && res.data != null) {
//         renters.value = res.data;
//       }else{
//         Get.dialog(PopUpAlertCard("fetch Renters field please check your connection", Icons.warning));
//       }
//     }else{
//       List<Renter> matchRenters = [];
//       for(Renter item in renters.value??[]){
//         if(item.name?.contains(text)??false){
//           matchRenters.add(item);
//         }
//         renters.value = matchRenters;
//       }
//     }
//
//   }
//   void changeLang(String lang) {
//     Get.updateLocale(Locale(lang));
//   }
//
// }
