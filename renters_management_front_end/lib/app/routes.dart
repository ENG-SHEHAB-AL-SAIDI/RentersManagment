import 'package:get/get.dart';
import 'package:renters_management_front_end/app/views/login_view/main_login_view.dart';
import 'bindings/login_binding.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/login',
      page: ()=>  const LoginPage(),
      binding: LoginViewBinding(),
    ),
    // Add more routes here
  ];
}
