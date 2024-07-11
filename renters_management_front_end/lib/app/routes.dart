import 'package:get/get.dart';
import './views/login_view.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/login',
      page: ()=> const LoginView()
    ),
    // Add more routes here
  ];
}
