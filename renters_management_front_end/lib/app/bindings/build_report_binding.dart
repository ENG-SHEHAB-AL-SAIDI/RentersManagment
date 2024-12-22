import 'package:get/get.dart';
import '../controllers/build_reports_controller.dart';


class BuildReportBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<BuildReportsController>(BuildReportsController());
  }


}