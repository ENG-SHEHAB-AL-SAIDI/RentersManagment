import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Expens {
  RxInt id;
  RxDouble? amount;
  RxString? date;
  RxString? description;
  RxString? deletedAt;
  RxString? createdAt;
  RxString? updatedAt;

  Expens({
    required this.id,
    this.amount,
    this.date,
    this.description,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Expens.fromJson(Map<String, dynamic> json) {
    return Expens(
      id: RxInt(json['id'] ?? 0),
      amount: RxDouble(double.tryParse(json['amount'].toString()) ?? 0.0),
      date: RxString(json["date"]),
      description: RxString(json["describe"] ?? ""),
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
      "describe": description?.value,
      "updated_at": updatedAt?.value,
      "created_at": createdAt?.value,
      "deleted_at": deletedAt?.value,
    };
  }
}
