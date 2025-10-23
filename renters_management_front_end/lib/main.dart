import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/globals.dart';
import './app/localization/languages.dart';
import './app/routes.dart';
import 'app/services/http_provider/http_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpProvider.init(baseUrl: "https://rentersmanagement.helioho.st/api/");
  // await HttpProvider.init(baseUrl:"http://192.168.0.31:8000/api/");
  await AppFonts.loadFonts();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Renters Management",
      initialRoute: "/login",
      translations: Languages(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en'),
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Arial',
        textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Arial'),
        useMaterial3: true, // optional
      ),

    );
  }
}
