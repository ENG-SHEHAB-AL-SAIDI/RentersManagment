import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../globals.dart';

class InstallmentAddController extends GetxController {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode dateFocus = FocusNode();
  FocusNode timeFocus = FocusNode();
  FocusNode amountFocus = FocusNode();
  FocusNode noteFocus = FocusNode();
  double remainAmount = 0;



  @override
  void onInit() {
    super.onInit();
    remainAmount = Get.arguments['amount'];
    dateController.text = DateTime.now().toString().split(" ")[0];
    timeController.text = formatTimeOfDay(TimeOfDay.now());

  }
  @override
  void onClose() {
    dateController.dispose();
    timeController.dispose();
    amountController.dispose();
    noteController.dispose();
    dateFocus.dispose();
    timeFocus.dispose();
    amountFocus.dispose();
    noteFocus.dispose();
  }


  String formatTimeOfDay(TimeOfDay time) {
    final hours = time.hourOfPeriod.toString().padLeft(2, '0'); // 12-hour format
    final minutes = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM'; // AM/PM
    return '$hours:$minutes $period';
  }

  String? validateDate(String? date) {
    if (date == "" || date == null) {
      return "required name";
    }
    return null;
  }


  String? validateTime(String? time) {
    if (time == "" || time == null) {
      return "required name";
    }
    return null;
  }

  String? validateAmount(String? amount) {
    if (amount == "" || amount == null) {
      return "required Rent";
    } else if (!GetUtils.isNum(amount)) {
      return "amount most be number";
    }else if (double.parse(amount)>remainAmount){
      return "amount most be equal or\n less than remain amount";
    }
    return null;
  }


  void datePiker(BuildContext context) async {
    DateTime? pikeDate = await showDatePicker(
      context: context,
      builder:
          (BuildContext context, Widget? child) {
        return Theme(
            data: ThemeData().copyWith(
              colorScheme: ColorScheme.dark(
                primary: AppColors.inverseCardColor,
                onPrimary: AppColors.mainCardColor,
                surface: AppColors.mainCardColor,
                onSurface: AppColors.inverseCardColor,
              ),),
            child: child!);
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pikeDate != null) {
      dateController.text =
      pikeDate.toString().split(" ")[0];
    }
  }
  void timePiker(BuildContext context) async {
    TimeOfDay? pikeTime = await showTimePicker(
      context: context,
      builder:
          (BuildContext context, Widget? child) {
        return Theme(
            data: ThemeData().copyWith(
              colorScheme: ColorScheme.dark(
                primary: AppColors.inverseCardColor,
                onPrimary: AppColors.mainCardColor,
                surface: AppColors.mainCardColor,
                onSurface: AppColors.inverseCardColor,
              ),),
            child: child!);
      },
      initialTime: TimeOfDay.now(),

    );
    if (pikeTime != null) {
      timeController.text =
          formatTimeOfDay(pikeTime);
    }
  }

  void submit() {
    Map<String, dynamic> jsData = {};
    if (formKey.currentState!.validate()) {
      (dateController.text.isNotEmpty && dateController.text != "Unknown".tr)
          ? jsData["date"] = dateController.text
          : null;
      (timeController.text.isNotEmpty && timeController.text != "Unknown".tr)
          ? jsData["time"] = timeController.text
          : null;
      (amountController.text.isNotEmpty && amountController.text != "Unknown".tr)
          ? jsData["amount"] = amountController.text
          : null;
      (noteController.text.isNotEmpty && noteController.text != "Unknown".tr)
          ? jsData["note"] = noteController.text
          : null;
      Get.back(result: jsData);
    }
  }

}
