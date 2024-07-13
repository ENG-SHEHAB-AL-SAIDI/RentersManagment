import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:renters_management_front_end/app/views/home_view/phone_home_view.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    return Material(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth <= 768 && constraints.maxHeight <= 1025) {
            return   PhoneHomeView();
          } else {
            return  const Placeholder();
          }
        },
      ),
    );
  }
}
