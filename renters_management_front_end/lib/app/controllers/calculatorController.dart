import 'package:get/get.dart';

class CalculatorController extends GetxController {
  double value = 0;

  void onChange(String? val1, double? val2, String? val3) {
    if (val1 == "=") {
      value = val2 ?? 0;
    }else if(val1 == "C"){
      value = 0;
    }
  }
}
