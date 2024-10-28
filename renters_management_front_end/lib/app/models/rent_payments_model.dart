import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:renters_management_front_end/app/models/rent_payments_installment_model.dart';

class RentPayment {
  RxInt id;
  RxDouble? payedAmount;
  RxDouble? remainAmount;
  RxString? year;
  RxString? month;
  RxString? state;
  List<RentPaymentsInstallment>? rentPaymentsInstallment;
  RxString? deletedAt;
  RxString? createdAt;
  RxString? updatedAt;

  RentPayment({
    required this.id,
    this.year,
    this.month,
    this.state,
    this.payedAmount,
    this.remainAmount,
    this.rentPaymentsInstallment,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory RentPayment.fromJson(Map<String, dynamic> json) {
    List rentPaymentsInstallmentsJs = json['rent_payments_installments']??[];
    List<RentPaymentsInstallment> rentPaymentsInstallment = [];
    if (rentPaymentsInstallmentsJs.isNotEmpty) {
      for (var rentPaymentsInstallmentJs in rentPaymentsInstallmentsJs) {
        rentPaymentsInstallment.add(RentPaymentsInstallment.fromJson(rentPaymentsInstallmentJs));
      }
    }
    return RentPayment(
      id: RxInt(json['id'] ?? 0),
      year: RxString(json['year'] ?? "Unknown"),
      month: RxString(json['month']??"Unknown"),
      state: RxString(json["state"]),
      remainAmount: RxDouble(json['remain_amount'].toDouble() ?? 0.0),
      payedAmount: RxDouble(json['payed_amount'].toDouble() ?? 0.0),
      rentPaymentsInstallment: rentPaymentsInstallment,
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
      "state": state?.value,
      "PayedAmount": payedAmount?.value,
      "remainAmount": remainAmount?.value,
      "deleted_at": deletedAt?.value,
      "created_at": createdAt?.value,
      "updated_at": updatedAt?.value,
    };

  }
}

