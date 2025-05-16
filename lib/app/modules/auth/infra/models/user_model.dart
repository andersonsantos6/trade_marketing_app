import 'dart:convert';

import 'package:trade_marketing_app/app/core/types.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:collection/collection.dart';

class UserModel extends UserEntity {
  @override
  String? email;
  @override
  String? password;
  @override
  String? name;
  @override
  Profile? profile;

  UserModel({
    this.email,
    this.password,
    this.name,
    this.profile,
  });

  factory UserModel.fromMap(dynamic json) {
    return UserModel(
      email: json['email'],
      password: json['password'],
      name: json['name'],
      profile: Profile.values.firstWhereOrNull(
              (e) => (json['profile'] as String?)?.toLowerCase() == e.name) ??
          Profile.unknown,
    );
  }
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      email: entity.email,
      password: entity.password,
      name: entity.name,
      profile: entity.profile,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'profile': profile?.name,
    };
  }
}
