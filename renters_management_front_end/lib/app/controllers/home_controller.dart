import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/models/result.dart';
import 'package:renters_management_front_end/app/services/build_services.dart';
import 'package:renters_management_front_end/app/services/user_services.dart';

import '../models/build_model.dart';

class HomeController extends GetxController {
  // TextEditingController search = TextEditingController();
  Rx<List<Build>?> builds = Rx([]);


  @override
  void onInit() async{
    Result<List<Build>> res = await BuildServices.fetchBuilds();
    if(res.statusCode == 200 && res.data != null){
      builds.value = res.data;
    }
    super.onInit();
  }

}
