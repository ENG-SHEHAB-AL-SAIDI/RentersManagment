import 'package:get/get_rx/src/rx_types/rx_types.dart';
class User {
  RxInt id;
  RxString? name ;
  RxString? email ;
  RxString? phone;
  RxString? profileImage;
  RxString? emailVerifiedAt;
  RxString? createdAt;
  RxString? updatedAt;

  User({
    required this.id,
    this.name,
    this.email,
    this.phone,
    this.profileImage,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,

  });

}