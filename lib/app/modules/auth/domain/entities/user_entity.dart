// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:trade_marketing_app/app/core/types.dart';

class UserEntity {
  String? email;
  String? password;
  String? name;
  Profile? profile;
  UserEntity({
    this.email,
    this.password,
    this.name,
    this.profile,
  });
}
