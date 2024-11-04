import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/custom_text.dart';

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
  FocusNode incomeFocus = FocusNode();
  RxInt? radioGroupValue = 0.obs;
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


  void changeRadioGroupValue(val){
    radioGroupValue?.value = val;
  }

  void showBottomSheet(){
    incomeFocus.requestFocus();
    Get.bottomSheet(Container(
      height: Get.height*0.6,
      width: Get.width,
      decoration: BoxDecoration(
          color: AppColors.backColor,
        borderRadius: BorderRadius.circular(32),
      ),
      padding: EdgeInsets.all(8),
      child: Column(children: [
        SecText("Statement",fontWeight: FontWeight.bold,),
        Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet,
                      size: 40,
                      color: AppColors.inverseIconColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SecText(
                      "Statement",
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                  width: Get.width*0.6,
                  child: DropdownMenu(
                      dropdownMenuEntries: [
                        DropdownMenuEntry<String>(
                            value: "income", label: 'Income')
                      ]),
                )
              ],
            ),
          ],
        ),

      ],),
    ));
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
    amountController.text = double.parse(amountController.text).toStringAsFixed(2);
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
