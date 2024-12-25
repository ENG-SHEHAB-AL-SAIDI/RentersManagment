import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:renters_management_front_end/app/models/renter_model.dart';
import 'package:renters_management_front_end/app/models/statement_model.dart';

class Build {
  RxInt id;
  RxInt? numRenters;
  RxDouble? totalRent;
  RxString? name;
  RxString? city;
  RxString? address;
  List<Renter>? renters;
  Map<String,List<Statement>>? statements;
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
    this.statements,
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
    Map<String,List<Statement>> statements = {};
    if((json["grouped_statements"]??[]).isNotEmpty){
      for (String key in json["grouped_statements"].keys) {
        List<Statement> statementsList = [];
        for(Map<String,dynamic> item in json["grouped_statements"][key]){
          statementsList.add(Statement.fromJson(item));
        }
        statements[key] = statementsList;
      }
    }
    return Build(
      id: RxInt(json['id'] ?? 0),
      numRenters: RxInt(json['renters_count'] ?? 0),
      totalRent: RxDouble( double.tryParse(json['total_rent'].toString())??0),
      name: RxString(json['name'] ?? "Unknown"),
      city: RxString(json['city'] ?? "Unknown"),
      renters: renters,
      statements: statements,
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

    Map<String,List<Map<String,dynamic>>> jsGroupedStatements = {};
      for (String key in (statements??{}).keys) {
        List<Map<String,dynamic>> statementsList = [];
        if (statements?[key] == null) continue;
        for(Statement item in statements![key]!){
          statementsList.add(item.toJson());
        }
        jsGroupedStatements[key] = statementsList;
      }
    return {
      'id': id.value,
      'renters_count': numRenters?.value,
      'total_rent':totalRent?.value,
      'name': name?.value,
      'city': city?.value,
      'address': address?.value,
      'renters':jsRenters,
      'grouped_statements':jsGroupedStatements,
      'deleted_at': deletedAt?.value,
      'created_at': createdAt?.value,
      'updated_at': updatedAt?.value,
    };
  }
}
