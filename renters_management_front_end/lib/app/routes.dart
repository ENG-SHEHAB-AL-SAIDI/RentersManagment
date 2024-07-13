import 'package:get/get.dart';
import 'package:renters_management_front_end/app/views/home_view/main_home_view.dart';
import 'package:renters_management_front_end/app/views/login_view/main_login_view.dart';
import 'package:renters_management_front_end/app/views/renters_state_view/main_renters_state_view.dart';
import 'bindings/login_binding.dart';

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
      binding: LoginViewBinding(),
    ),
    GetPage(
      name: '/rentersState',
      page: ()=>   const RentersStateView(),
      //binding: LoginViewBinding(),
    ),
    GetPage(
      name: '/buildReports',
      page: ()=>   const RentersStateView(),
      //binding: LoginViewBinding(),
    ),
    // Add more routes here
  ];
}
