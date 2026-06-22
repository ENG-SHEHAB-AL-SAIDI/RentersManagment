import 'package:get/get.dart';
import 'package:renters_management_front_end/app/bindings/home_binding.dart';
import 'package:renters_management_front_end/app/bindings/renter_list_binding.dart';
import 'package:renters_management_front_end/app/views/build_reports_list_view/build_reports_list_view.dart';
import 'package:renters_management_front_end/app/views/build_reports_view/build_reports_view.dart';
import 'package:renters_management_front_end/app/views/home_view/main_home_view.dart';
import 'package:renters_management_front_end/app/views/login_view/main_login_view.dart';
import 'package:renters_management_front_end/app/views/renters_details_view/renters_details_view.dart';
import 'package:renters_management_front_end/app/views/renters_list_view/renters_list_view.dart';
import 'bindings/build_report_binding.dart';
import 'bindings/build_report_list_binding.dart';
import 'bindings/login_binding.dart';
import 'bindings/renter_details_binding.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/login',

      page: ()=>  const LoginPage(),
      binding: LoginViewBinding(),
    ),
    GetPage(
      name: '/demo',
      parameters: {'demoMode':'true'},
      page: ()=>  const LoginPage(),
      binding: LoginViewBinding(),
    ),
    GetPage(
      name: '/home',
      page: ()=>   const HomeView(),
      binding: HomeViewBinding(),
    ),
    GetPage(
      name: '/rentersList',
      page: ()=>   const RentersListView(),
      binding: RenterListViewBinding(),
    ),
    GetPage(
      name: '/rentersDetails',
      page: ()=>   RentersDetailsView(),
      binding: RenterDetailsViewBinding(),
    ),
    GetPage(
      name: '/buildReportsList',
      page: ()=>    BuildReportsListView(),
      binding: BuildReportListBinding(),
    ),

    GetPage(
      name: '/buildReports',
      page: ()=>    BuildReportsView(),
      binding: BuildReportBinding(),
    ),
    // Add more routes here
  ];
}
