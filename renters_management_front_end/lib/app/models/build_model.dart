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
    List jsRenters = json['Build']['renters'];
    List<Renter> renters = [];
    if (jsRenters.isNotEmpty) {
      for (var renter in jsRenters) {
        renters.add(Renter.fromJson(renter));
      }
    }
    return Build(
      id: RxInt(json['Build']['id'] ?? 0),
      numRenters: RxInt(json['Build']['numRenters'] ?? 0),
      name: RxString(json['Build']['name'] ?? "Unknown"),
      city: RxString(json['Build']['city'] ?? "Unknown"),
      renters: renters,
      address: RxString(json['Build']['address'] ?? "Unknown"),
      deletedAt: RxString(json['Build']['deleted_at'] ?? "Unknown"),
      createdAt: RxString(json['Build']['created_at'] ?? "Unknown"),
      updatedAt: RxString(json['Build']['updated_at'] ?? "Unknown"),
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
      'numRenters': numRenters?.value,
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
