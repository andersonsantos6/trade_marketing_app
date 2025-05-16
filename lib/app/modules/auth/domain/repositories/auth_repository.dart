import 'package:dartz/dartz.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/entities/task_entity.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/errors/auth_error.dart';

abstract class AuthRepository {
  //usuario retornado com mais dados completos,

  Future<Either<AuthException, (List<TaskEntity> tasks, UserEntity user)>>
      login({
    required String email,
    required String password,
  });
}
