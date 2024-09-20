import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './phone_renters_list_view.dart';


class RentersListView extends StatelessWidget {
  const RentersListView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    return Material(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth <= 768 && constraints.maxHeight <= 1025) {
            return  const PhoneRentersListView();
          } else {
            return  const Placeholder();
          }
        },
      ),
    );
  }
}







