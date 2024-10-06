import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:renters_management_front_end/app/models/renter_model.dart';

class Build {
  RxInt id;
  RxInt? numRenters;
  RxDouble? totalRent;
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
    this.totalRent,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Build.fromJson(Map<String, dynamic> json ) {
    List jsRenters = json['renters'];
    List<Renter> renters = [];
    if (jsRenters.isNotEmpty) {
      for (var renter in jsRenters) {
        renters.add(Renter.fromJson(renter));
      }
    }
    return Build(
      id: RxInt(json['id'] ?? 0),
      numRenters: RxInt(json['renters_count'] ?? 0),
      totalRent: RxDouble( double.parse(json['total_rent'].toStringAsFixed(5))),
      name: RxString(json['name'] ?? "Unknown"),
      city: RxString(json['city'] ?? "Unknown"),
      renters: renters,
      address: RxString(json['address'] ?? "Unknown"),
      deletedAt: RxString(json['deleted_at'] ?? "Unknown"),
      createdAt: RxString(json['created_at'] ?? "Unknown"),
      updatedAt: RxString(json['updated_at'] ?? "Unknown"),
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic> > jsRenters = [];
    for(Renter renter in renters??[]){
      jsRenters.add(renter.toJson());
    }
     renters?.forEach((element) => element.toJson,);
    return {
      'id': id.value,
      'renters_count': numRenters?.value,
      'total_rent':totalRent?.value,
      'name': name?.value,
      'city': city?.value,
      'address': address?.value,
      'renters':jsRenters,
      'deleted_at': deletedAt?.value,
      'created_at': createdAt?.value,
      'updated_at': updatedAt?.value,
    };
  }
}
