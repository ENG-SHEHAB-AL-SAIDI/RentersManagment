import 'package:get/get_rx/src/rx_types/rx_types.dart';

class User {
  RxInt id;
  RxString? name;
  RxString? email;
  RxString? phone;
  RxString? profileImage;
  RxString? emailVerifiedAt;
  RxString? createdAt;
  RxString? updatedAt;

  User({
    required this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,

  });

  factory User.fromJson(Map<String,dynamic> json){
    return User(
      id: RxInt(json['id'] ?? 0),
      name: RxString(json['name'] ?? ""),
      email: RxString(json['email'] ?? ""),
      emailVerifiedAt: RxString(json['email_verified_at'] ?? ""),
      createdAt: RxString(json['created_at'] ?? ""),
      updatedAt: RxString(json['updated_at'] ?? ""),
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "id":id.value,
      "name":name?.value,
      "email":email?.value,
      "email_verified_at":emailVerifiedAt?.value,
      "created_at":createdAt?.value,
      "updated_at":updatedAt?.value,
    };
  }

}