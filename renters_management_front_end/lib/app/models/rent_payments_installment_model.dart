import 'package:get/get_rx/src/rx_types/rx_types.dart';

class RentPaymentsInstallment {
  RxInt id;
  RxDouble? amount;
  RxString? date;
  RxString? notes;
  RxString? deletedAt;
  RxString? createdAt;
  RxString? updatedAt;

  RentPaymentsInstallment({
    required this.id,
    this.amount,
    this.date,
    this.notes,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory RentPaymentsInstallment.fromJson(Map<String, dynamic> json) {
    return RentPaymentsInstallment(
      id: RxInt(json['id'] ?? 0),
      amount: RxDouble(double.tryParse(json['amount'].toString()) ?? 0.0),
      date: RxString(json["date"]),
      notes: RxString(json["notes"] ?? ""),
      updatedAt: RxString(json['deleted_at'] ?? "Unknown"),
      createdAt: RxString(json['created_at'] ?? "Unknown"),
      deletedAt: RxString(json['updated_at'] ?? "Unknown"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.value,
      "amount": amount?.value,
      "date": date?.value,
      "notes": notes?.value,
      "updated_at": updatedAt?.value,
      "created_at": createdAt?.value,
      "deleted_at": deletedAt?.value,
    };
  }
}
