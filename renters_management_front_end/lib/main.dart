import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './app/localization/languages.dart';
import './app/routes.dart';
import 'app/services/http_provider/http_provider.dart';

void main() async{
  await HttpProvider.init(baseUrl:"https://rentersmanagement.helioho.st/api/");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetPlatform.isIOS
        //IOS UI
        ? GetCupertinoApp(
            title: "Renters Management",
            initialRoute: "/login",
            translations: Languages(),
            locale: Get.deviceLocale,
            fallbackLocale: const Locale('en'),
            getPages: AppRoutes.routes,
            debugShowCheckedModeBanner: false,
          )
        // Android and web UI
        : GetMaterialApp(
            title: "Renters Management",
            initialRoute: "/login",
            translations: Languages(),
            locale: Get.deviceLocale,
            fallbackLocale: const Locale('en'),
            getPages: AppRoutes.routes,
            debugShowCheckedModeBanner: false,
          );

  }
}
