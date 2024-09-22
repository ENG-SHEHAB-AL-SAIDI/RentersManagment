import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:renters_management_front_end/app/views/renters_details_view/phone_renters_details_view.dart';



class RentersStateView extends StatelessWidget {
  const RentersStateView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    return Material(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth <= 768 && constraints.maxHeight <= 1025) {
            return  PhoneRentersDetailsView();
          } else {
            return  const Placeholder();
          }
        },
      ),
    );
  }
}