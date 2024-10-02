import 'package:get/get.dart';
import '../controllers/renter_details_controller.dart';

class RenterDetailsViewBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<RenterDetailsController>(RenterDetailsController());
  }


}