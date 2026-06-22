import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './phones_login_view.dart';
import './web_login_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    return Material(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth <= 768) {
            return  PhoneLoginView();
          } else {
            return  WebLoginView();
          }
        },
      ),
    );
  }
}
