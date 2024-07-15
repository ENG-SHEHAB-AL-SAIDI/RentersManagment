import 'package:get/get_rx/src/rx_types/rx_types.dart';
class Build {
  RxInt id;
  RxString? name ;
  RxString? city ;
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

}