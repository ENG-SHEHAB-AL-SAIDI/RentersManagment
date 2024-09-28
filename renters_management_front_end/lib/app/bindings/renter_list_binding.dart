import 'package:get/get.dart';
import 'package:renters_management_front_end/app/controllers/renter_list_controller.dart';

class RenterListViewBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<RenterListController>(RenterListController());
  }


}