import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            return  const Placeholder();
          } else {
            return  const Placeholder();
          }
        },
      ),
    );
  }
}
