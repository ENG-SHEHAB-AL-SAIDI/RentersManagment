
import 'package:get/get.dart';

class CalculatorController extends GetxController {
  double value = 0;
  void onChange(String? val1, double? val2, String? val3){
    value = val2??0;
  }
}
