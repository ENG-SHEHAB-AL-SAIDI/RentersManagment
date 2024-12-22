import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:renters_management_front_end/app/views/build_reports_view/phone_build_reports_view.dart';


class BuildReportsView extends StatelessWidget {
  const BuildReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    return Material(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth <= 768 && constraints.maxHeight <= 1025) {
            return  PhoneBuildReportsView();
          } else {
            return  const Placeholder();
          }
        },
      ),
    );
  }
}
