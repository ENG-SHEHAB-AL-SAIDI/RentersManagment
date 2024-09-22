import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/models/result.dart';
import 'package:renters_management_front_end/app/services/renter_services.dart';

import '../models/renter_model.dart';

class RenterListController extends GetxController {
  TextEditingController search = TextEditingController();
  int buildId = -1;
  Rx<List<Renter>?> renters = Rx([]);

  @override
  void onClose() {
    search.dispose();
  }

  @override
  void onInit() async {
    buildId = Get.arguments['buildId'];
    Result<List<Renter>> res = await RenterServices.fetchRenters(buildId);
    if (res.statusCode == 200 && res.data != null) {
      renters.value = res.data;
    }
    super.onInit();
  }

  void changeLang(String lang) {
    Get.updateLocale(Locale(lang));
  }
}
