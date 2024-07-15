import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/models/api/http_provider.dart';
import './app/localization/languages.dart';
import './app/routes.dart';
import 'app/models/api/api_end_points.dart';

void main() async{
  HttpProvider.init(baseUrl:EndPoints.baseUrl);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetPlatform.isIOS
        //IOS UI
        ? GetCupertinoApp(
            title: "StudentServices",
            initialRoute: "/login",
            translations: Languages(),
            locale: Get.deviceLocale,
            fallbackLocale: const Locale('en'),
            getPages: AppRoutes.routes,
            debugShowCheckedModeBanner: false,
          )
        // Android and web UI
        : GetMaterialApp(
            title: "StudentServices",
            initialRoute: "/login",
            translations: Languages(),
            locale: Get.deviceLocale,
            fallbackLocale: const Locale('en'),
            getPages: AppRoutes.routes,
            debugShowCheckedModeBanner: false,
          );

  }
}
