import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:renters_management_front_end/app/components/pop_up_cards/add_expens.dart';
import 'package:renters_management_front_end/app/models/statement_model.dart';
import 'package:renters_management_front_end/app/services/build_services.dart';
import 'package:renters_management_front_end/app/services/print/printing.dart';
import 'package:renters_management_front_end/app/services/statement_services.dart';

import '../components/pop_up_cards/add_income.dart';
import '../components/pop_up_cards/alert_message_card.dart';
import '../components/pop_up_cards/delete_confirmation_message_card.dart';
import '../globals.dart';
import '../models/build_model.dart';
import '../models/rent_payments_model.dart';
import '../models/renter_model.dart';
import '../models/result.dart';

class BuildReportsController extends GetxController {
  int buildId = -1;
  String selectedYear = '';
  String selectedMonth = '';
  String year = "";
  int month = -1;
  Statement? statement;

  RxBool isLoad = true.obs;
  DateFormat dateFormat = DateFormat("yyyy-dd-MM");
  DateFormat timeFormat = DateFormat("hh:mm a");
  DateFormat dateTimeFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  RxString paymentType = "cash".obs;
  TextEditingController paymentIdController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode dateFocus = FocusNode();
  FocusNode timeFocus = FocusNode();
  FocusNode amountFocus = FocusNode();
  FocusNode paymentIbFocus = FocusNode();
  FocusNode noteFocus = FocusNode();
  FocusNode incomeFocus = FocusNode();

  RxDouble monthTotalRent = 0.0.obs;
  RxInt rentersCount = 0.obs;

  RxDouble payedTotalRent = 0.0.obs;
  RxInt payedRentersCount = 0.obs;
  List<int> payedRentersIds = [];

  RxDouble partiallyPayedTotalRent = 0.0.obs;
  RxInt partiallyPayedRentersCount = 0.obs;
  List<int> partiallyPayedRentersIds = [];

  RxDouble notPayedTotalRent = 0.0.obs;
  RxInt notPayedRentersCount = 0.obs;
  List<int> notPayedRentersIds = [];

  @override
  void onInit() async {
    buildId = Get.arguments["buildId"];
    year = Get.arguments["year"];
    month = Get.arguments["month"];
    statement = await StatementServices.fetchStatementsByMonth(
            buildId, year, month.toString())
        .then((val) => val.data);
    calcBuildStatement();
    isLoad.value = false;
    super.onInit();
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
    super.onClose();
  }

  @override
  void refresh() {
    isLoad.value = true;
    calcBuildStatement();
    isLoad.value = false;
  }

  formatTimeOfDay(TimeOfDay time) {
    final hours =
        time.hourOfPeriod.toString().padLeft(2, '0'); // 12-hour format
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
      return "required Amount";
    } else if (!GetUtils.isNum(amount)) {
      return "amount most be number";
    }
    return null;
  }

  void datePiker(BuildContext context) async {
    DateTime? pikeDate = await showDatePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
            data: ThemeData().copyWith(
              colorScheme: ColorScheme.dark(
                primary: AppColors.inverseCardColor,
                onPrimary: AppColors.mainCardColor,
                surface: AppColors.mainCardColor,
                onSurface: AppColors.inverseCardColor,
              ),
            ),
            child: child!);
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pikeDate != null) {
      dateController.text = pikeDate.toString().split(" ")[0];
    }
  }

  void timePiker(BuildContext context) async {
    TimeOfDay? pikeTime = await showTimePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
            data: ThemeData().copyWith(
              colorScheme: ColorScheme.dark(
                primary: AppColors.inverseCardColor,
                onPrimary: AppColors.mainCardColor,
                surface: AppColors.mainCardColor,
                onSurface: AppColors.inverseCardColor,
              ),
            ),
            child: child!);
      },
      initialTime: TimeOfDay.now(),
    );
    if (pikeTime != null) {
      timeController.text = formatTimeOfDay(pikeTime);
    }
  }

  void clear() {
    dateController.clear();
    timeController.clear();
    amountController.clear();
    noteController.clear();
  }

  void more(String val) async {
    if (val == "print") {
      await AppPrinting.printSingleStatementPrintLayout(
          statement,
          await BuildServices.fetchBuild(id: buildId)
              .then((e) => e.data?.name?.value ?? ""));
    }
  }

  void calcBuildStatement() async {
    Build? build =
        await BuildServices.fetchBuild(id: buildId).then((res) => res.data);
    for (Renter renter in (build?.renters ?? [])) {
      for (RentPayment rentPayment in renter.rentPayments?[year] ?? []) {
        if (rentPayment.month?.value == month.toString() &&
            rentPayment.state?.value != "excluded") {
          monthTotalRent.value += renter.rent?.value ?? 0;
          rentersCount.value += 1;
          if (rentPayment.state?.value == "payed") {
            payedTotalRent.value += renter.rent?.value ?? 0;
            payedRentersCount.value += 1;
            payedRentersIds.add(renter.id.value);
          } else if (rentPayment.state?.value == "partially_payed") {
            partiallyPayedTotalRent.value +=
                rentPayment.payedAmount?.value ?? 0;
            partiallyPayedRentersCount.value++;
            partiallyPayedRentersIds.add(renter.id.value);
          } else if (rentPayment.state?.value == "not_payed") {
            notPayedTotalRent.value += rentPayment.remainAmount?.value ?? 0;
            notPayedRentersCount.value++;
            notPayedRentersIds.add(renter.id.value);
          }
        }
      }
    }
  }

  void incomeSubmit() {
    Map<String, dynamic> jsData = {};
    if (formKey.currentState!.validate()) {
      amountController.text =
          double.parse(amountController.text).toStringAsFixed(2);

      (dateController.text.isNotEmpty && dateController.text != "Unknown".tr)
          ? jsData["date"] = dateController.text
          : null;
      (timeController.text.isNotEmpty && timeController.text != "Unknown".tr)
          ? jsData["time"] = timeController.text
          : null;
      jsData["payment_type"] = (paymentType.value == "part from trans")
          ? "part_from_trans"
          : paymentType.value;
      (paymentIdController.text.isNotEmpty &&
              paymentIdController.text != "Unknown".tr)
          ? jsData["payment_id"] = paymentIdController.text
          : null;
      (amountController.text.isNotEmpty &&
              amountController.text != "Unknown".tr)
          ? jsData["amount"] = amountController.text
          : null;
      (noteController.text.isNotEmpty && noteController.text != "Unknown".tr)
          ? jsData["note"] = noteController.text
          : null;
       Get.back(result: jsData);
      clear();
    }
  }

  void addIncome() async {
    dateController.text = DateTime.now().toString().split(" ")[0];
    timeController.text = formatTimeOfDay(TimeOfDay.now());
    if (statement == null) {
      return;
    }
    Map<String, dynamic>? result = await Get.dialog(
      const PopUpAddIncomeCard(),
    );
    if (result != null) {
      DateTime time = timeFormat.parse(result["time"]);
      DateTime date = dateFormat.parse(result["date"]);
      DateTime dateTime = DateTime(
          date.year, date.month, date.day, time.hour, time.minute, time.second);
      Result res = await StatementServices.statementAddIncome(
          buildId: buildId,
          statementId: statement!.id.value,
          data: {
            "date": dateTimeFormat.format(dateTime),
            "amount": double.parse(result["amount"]),
            "payment_type": result["payment_type"],
            "payment_id": result["payment_id"],
            "describe": result["note"],
          });
      if (res.statusCode == 200) {
        if (res.data != null) {
          statement?.totalIncomes?.refresh();
        }
      } else {
        Get.dialog(PopUpAlertCard(
            "${res.message ?? ""}\n error code:${res.statusCode}",
            Icons.warning));
      }
    }
  }

  void deleteIncome(int incomeId) async {
    bool conf = await Get.dialog(
        PopUpMessageCard("did you sure want delete this income "));
    if (conf == true) {
      Result res = await StatementServices.statementDeleteIncome(
          buildId: buildId,
          statementId: statement!.id.value,
          incomeId: incomeId);
      if (res.statusCode == 200) {
        if (res.data != null) {
          statement?.totalIncomes?.refresh();
        }
      } else {
        Get.dialog(PopUpAlertCard(
            "${res.message ?? ""}\n error code:${res.statusCode}",
            Icons.warning));
      }
    }
  }

  void updateIncome(int incomeId, Map<String, dynamic> data) async {
    Result res = await StatementServices.statementUpdateIncome(
        buildId: buildId,
        statementId: statement!.id.value,
        incomeId: incomeId,
        data: data);
    if (res.statusCode == 200) {
      if (res.data != null) {
        statement?.totalIncomes?.refresh();
      }
    } else {
      Get.dialog(PopUpAlertCard(
          "${res.message ?? ""}\n error code:${res.statusCode}",
          Icons.warning));
    }
  }

  void expensSubmit() {
    Map<String, dynamic> jsData = {};
    if (formKey.currentState!.validate()) {
      amountController.text =
          double.parse(amountController.text).toStringAsFixed(2);

      (dateController.text.isNotEmpty && dateController.text != "Unknown".tr)
          ? jsData["date"] = dateController.text
          : null;


      (timeController.text.isNotEmpty && timeController.text != "Unknown".tr)
          ? jsData["time"] = timeController.text
          : null;


      (amountController.text.isNotEmpty &&
              amountController.text != "Unknown".tr)
          ? jsData["amount"] = amountController.text
          : null;


      (noteController.text.isNotEmpty && noteController.text != "Unknown".tr)
          ? jsData["note"] = noteController.text
          : null;
      Get.back(result: jsData);
      clear();
    }
  }

  Future<void> addExpens() async {
    dateController.text = DateTime.now().toString().split(" ")[0];
    timeController.text = formatTimeOfDay(TimeOfDay.now());
    if (statement == null) {
      return;
    }
    Map<String, dynamic>? result = await Get.dialog(
      const PopUpAddExpensCard(),
    );
    if (result != null) {
      DateTime time = timeFormat.parse(result["time"]);
      DateTime date = dateFormat.parse(result["date"]);
      DateTime dateTime = DateTime(
          date.year, date.month, date.day, time.hour, time.minute, time.second);
      Result res = await StatementServices.statementAddExpens(
          buildId: buildId,
          statementId: statement!.id.value,
          data: {
            "date": dateTimeFormat.format(dateTime),
            "amount": double.parse(result["amount"]),
            "describe": result["note"]
          });
      if (res.statusCode == 200) {
        if (res.data != null) {
          statement?.totalExpenses?.refresh();
        }
      } else {
        Get.dialog(PopUpAlertCard(
            "${res.message ?? ""}\n error code:${res.statusCode}",
            Icons.warning));
      }
    }
  }

  void deleteExpens(int expensId) async {
    bool conf = await Get.dialog(
        PopUpMessageCard("did you sure want delete this expens "));
    if (conf == true) {
      Result res = await StatementServices.statementDeleteExpens(
          buildId: buildId,
          statementId: statement!.id.value,
          expensId: expensId);
      if (res.statusCode == 200) {
        if (res.data != null) {
          statement?.totalExpenses?.refresh();
        }
      } else {
        Get.dialog(PopUpAlertCard(
            "${res.message ?? ""}\n error code:${res.statusCode}",
            Icons.warning));
      }
    }
  }

  void updateExpens(int expensId, Map<String, dynamic> data) async {
    Result res = await StatementServices.statementUpdateExpens(
        buildId: buildId,
        statementId: statement!.id.value,
        expensId: expensId,
        data: data);
    if (res.statusCode == 200) {
      if (res.data != null) {
        statement?.totalExpenses?.refresh();
      }
    } else {
      Get.dialog(PopUpAlertCard(
          "${res.message ?? ""}\n error code:${res.statusCode}",
          Icons.warning));
    }
  }

  void routeToRenterList(String listType) {
    List<int>? rentersIds;
    switch (listType) {
      case "Fully Payed":
        rentersIds = payedRentersIds;
        break;
      case "Partially Payed":
        rentersIds = partiallyPayedRentersIds;
        break;
      case "Not Payed":
        rentersIds = notPayedRentersIds;
        break;
    }

    Get.toNamed("/rentersList", arguments: {
      'buildId': buildId,
      "rentersIds": rentersIds,
      "title": "$listType Renters"
    });
  }
}
