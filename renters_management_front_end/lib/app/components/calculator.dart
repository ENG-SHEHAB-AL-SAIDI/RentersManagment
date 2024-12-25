import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/controllers/calculator_controller.dart';
import '../globals.dart';

class Calculator extends GetView<CalculatorController> {
  const Calculator({super.key});
  @override
  Widget build(BuildContext context) {
    return SimpleCalculator(
      value: controller.value,
      onChanged: controller.onChange,
      theme:  CalculatorThemeData(
        displayColor: AppColors.mainCardColor,
        commandColor: AppColors.inverseCardColor,
        expressionColor: AppColors.mainCardColor,
        operatorColor: AppColors.inverseCardColor,
      ),
    );
  }
}
