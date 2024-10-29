import 'package:get/get.dart';
import 'package:renters_management_front_end/app/bindings/home_binding.dart';
import 'package:renters_management_front_end/app/bindings/renter_list_binding.dart';
import 'package:renters_management_front_end/app/views/build_reports_view/main_build_reports_view.dart';
import 'package:renters_management_front_end/app/views/home_view/main_home_view.dart';
import 'package:renters_management_front_end/app/views/login_view/main_login_view.dart';
import 'package:renters_management_front_end/app/views/renters_details_view/main_renters_details_view.dart';
import 'package:renters_management_front_end/app/views/renters_list_view/main_renters_list_view.dart';
import 'bindings/build_report_binding.dart';
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
      page: ()=>   const RentersStateView(),
      binding: RenterDetailsViewBinding(),
    ),
    GetPage(
      name: '/buildReports',
      page: ()=>   const BuildReportsView(),
      binding: BuildReportBinding(),
    ),
    // Add more routes here
  ];
}
