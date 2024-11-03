import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:renters_management_front_end/app/models/rent_payments_model.dart';

class Renter {
  RxInt id;
  RxString? name;
  RxDouble? rent;
  RxString? jobDomain;
  RxString? enterDate;
  List<RxString>? phones;
  RxMap<String,List<RentPayment>>? rentPayments;
  RxString? deletedAt;
  RxString? createdAt;
  RxString? updatedAt;

  Renter({
    required this.id,
    this.name,
    this.rent,
    this.jobDomain,
    this.enterDate,
    this.phones,
    this.rentPayments,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Renter.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> phones = [];
    if((json["renter_phones"]??[]).isNotEmpty){
      for (var item in json["renter_phones"]) {
      if (item != []) {
        phones.add(item);
      }
    }
    }
    Map<String,List<RentPayment>> rentPayments = {};
    if((json["grouped_rent_payments"]??[]).isNotEmpty){
    for (var key in json["grouped_rent_payments"].keys) {
      List<RentPayment> rentPaymentsItems = [];
      for(Map<String,dynamic> item in json["grouped_rent_payments"][key]){
        rentPaymentsItems.add(RentPayment.fromJson(item));
      }
      rentPayments[key] = rentPaymentsItems;
    }
    }

    return Renter(
      id: RxInt(json['id'] ?? 0),
      name: RxString(json['name'] ?? "Unknown"),
      rent: RxDouble(double.parse(json['rent'].toString()) ?? 0.0),
      jobDomain: RxString(json['job_domain'] ?? "Unknown"),
      enterDate: RxString(json['enter_date'] ?? "Unknown"),
      phones: List<RxString>.generate(
          phones.length, (i) => RxString(phones[i]["phone"].toString())),
      rentPayments: RxMap<String,List<RentPayment>>(rentPayments),
      updatedAt: RxString(json['deleted_at'] ?? "Unknown"),
      createdAt: RxString(json['created_at'] ?? "Unknown"),
      deletedAt: RxString(json['updated_at'] ?? "Unknown"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.value,
      'name': name?.value,
      'rent': rent?.value,
      'job_domain': jobDomain?.value,
      'enter_date': enterDate?.value,
      'deleted_at': deletedAt?.value,
      'created_at': createdAt?.value,
      'updated_at': updatedAt?.value,
    };
  }
}

//
// {
// "message": "update successful",
// "renter": {
// "id": 1,
// "name": "renter2",
// "rent": 100000,
// "job_bomain": null,
// "enter_date": "2000-10-1",
// "deleted_at": null,
// "created_at": "2024-09-21T01:15:00.000000Z",
// "updated_at": "2024-09-21T02:20:42.000000Z",
// "build_id": 1,
// "renter_phones": [
// {
// "phone": 123456787,
// "deleted_at": null,
// "created_at": "2024-09-21T02:18:19.000000Z",
// "updated_at": "2024-09-21T02:18:19.000000Z",
// "renter_id": 1
// },
// {
// "phone": 987654321,
// "deleted_at": null,
// "created_at": "2024-09-21T02:18:19.000000Z",
// "updated_at": "2024-09-21T02:18:19.000000Z",
// "renter_id": 1
// },
// {
// "phone": 987654391,
// "deleted_at": null,
// "created_at": "2024-09-21T02:20:42.000000Z",
// "updated_at": "2024-09-21T02:20:42.000000Z",
// "renter_id": 1
// }
// ]
// }
// }
