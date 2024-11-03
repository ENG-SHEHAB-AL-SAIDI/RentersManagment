import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:renters_management_front_end/app/models/expens_model.dart';
import 'package:renters_management_front_end/app/models/income_model.dart';
import 'package:renters_management_front_end/app/models/rent_payments_installment_model.dart';

class Statement {
  RxInt id;
  RxDouble? totalIncomes;
  RxDouble? totalExpenses;
  RxString? year;
  RxString? month;
  List<Income>? incomes;
  List<Expens>? expenses;
  RxString? deletedAt;
  RxString? createdAt;
  RxString? updatedAt;

  Statement({
    required this.id,
    this.year,
    this.month,
    this.totalIncomes,
    this.totalExpenses,
    this.incomes,
    this.expenses,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Statement.fromJson(Map<String, dynamic> json) {
    List<Income> incomes = [];
    List<Expens> expenses = [];
    if ((json["incomes"]??[]).isNotEmpty) {
      for (var income in json["incomes"]) {
        incomes.add(Income.fromJson(income));
      }
    }
    if ((json["expenses"]??[]).isNotEmpty) {
      for (var expens in json["expenses"]) {
        expenses.add(Expens.fromJson(expens));
      }
    }
    return Statement(
      id: RxInt(json['id'] ?? 0),
      year: RxString(json['year'] ?? "Unknown"),
      month: RxString(json['month']??"Unknown"),
      totalIncomes: RxDouble(double.tryParse(json['TotalIncomes'].toString()) ?? 0.0),
      totalExpenses: RxDouble(double.tryParse(json['TotalExpenses'].toString()) ?? 0.0),
      incomes: incomes,
      expenses: expenses,
      updatedAt: RxString(json['deleted_at'] ?? "Unknown"),
      createdAt: RxString(json['created_at'] ?? "Unknown"),
      deletedAt: RxString(json['updated_at'] ?? "Unknown"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.value,
      "year": year?.value,
      "month": month?.value,
      "TotalIncomes": totalIncomes?.value,
      "TotalExpenses": totalExpenses?.value,
      "deleted_at": deletedAt?.value,
      "created_at": createdAt?.value,
      "updated_at": updatedAt?.value,
    };

  }
}

