import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Build {
  RxInt id;
  RxString? name;

  RxString? city;

  RxString? address;
  RxString? deletedAt;
  RxString? createdAt;
  RxString? updatedAt;

  Build({
    required this.id,
    this.name,
    this.city,
    this.address,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Build.fromJson(Map<String, dynamic> json) {
    return Build(
      id: RxInt(json['id'] ?? 0),
      name: RxString(json['name'] ?? ""),
      city: RxString(json['city'] ?? ""),
      address: RxString(json['address'] ?? ""),
      deletedAt: RxString(json['deleted_at'] ?? ""),
      createdAt: RxString(json['created_at'] ?? ""),
      updatedAt: RxString(json['updated_at'] ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.value,
      'name': name?.value,
      'city': city?.value,
      'address': address?.value,
      'deleted_at': deletedAt?.value,
      'created_at': createdAt?.value,
      'updated_at': updatedAt?.value,
    };
  }
}
