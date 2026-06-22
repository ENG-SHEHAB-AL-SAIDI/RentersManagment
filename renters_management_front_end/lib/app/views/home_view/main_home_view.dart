import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:renters_management_front_end/app/globals.dart';
import 'package:renters_management_front_end/app/views/home_view/phone_home_view.dart';

import 'desktop_home_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Material(
      color: AppColors.backColor,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth <= 768) {
            return PhoneHomeView();
          } else {
            return DeskTopHomeView();
          }
        },
      ),
    );
  }
}
