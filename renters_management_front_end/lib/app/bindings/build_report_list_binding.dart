import 'package:get/get.dart';
import 'package:renters_management_front_end/app/controllers/build_reports_list_controller.dart';


class BuildReportListBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<BuildReportsListController>(BuildReportsListController());
  }


}