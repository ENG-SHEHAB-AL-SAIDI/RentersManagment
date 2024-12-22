import 'package:get/get.dart';
import '../controllers/installment_add_controller.dart';
import '../controllers/renter_details_controller.dart';

class RenterDetailsViewBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<RenterDetailsController>(RenterDetailsController());
    Get.lazyPut<InstallmentAddController>(()=>InstallmentAddController(),fenix: true,);
  }


}