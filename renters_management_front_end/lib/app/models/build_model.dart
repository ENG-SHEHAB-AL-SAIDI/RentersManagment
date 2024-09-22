import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:renters_management_front_end/app/models/renter_model.dart';

class Build {
  RxInt id;
  RxInt? numRenters;
  RxString? name;
  RxString? city;
  RxString? address;
  List<Renter>? renters;
  RxString? deletedAt;
  RxString? createdAt;
  RxString? updatedAt;

  Build({
    required this.id,
    this.numRenters,
    this.name,
    this.city,
    this.address,
    this.renters,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Build.fromJson(Map<String, dynamic> json) {
    return Build(
      id: RxInt(json['id'] ?? 0),
      numRenters: RxInt(json['numRenters']??0),
      name: RxString(json['name'] ?? "Unknown"),
      city: RxString(json['city'] ?? "Unknown"),
      address: RxString(json['address'] ?? "Unknown"),
      deletedAt: RxString(json['deleted_at'] ?? "Unknown"),
      createdAt: RxString(json['created_at'] ?? "Unknown"),
      updatedAt: RxString(json['updated_at'] ?? "Unknown"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.value,
      'numRenters': numRenters?.value,
      'name': name?.value,
      'city': city?.value,
      'address': address?.value,
      'deleted_at': deletedAt?.value,
      'created_at': createdAt?.value,
      'updated_at': updatedAt?.value,
    };
  }
}
