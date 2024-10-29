import 'package:get/get.dart';
import 'package:renters_management_front_end/app/controllers/buildr_reports_controller.dart';


class BuildReportBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<BuildReportsController>(BuildReportsController());
  }


}