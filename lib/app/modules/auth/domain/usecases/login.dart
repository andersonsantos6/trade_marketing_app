import 'package:dartz/dartz.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/entities/task_entity.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/errors/auth_error.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:trade_marketing_app/app/modules/auth/infra/repositories/auth_repository_impl.dart';

abstract class LoginUseCase {
  Future<Either<AuthException, (List<TaskEntity>, UserEntity user)>> call({
    required String email,
    required String password,
  });
}

class LoginUseCaseImpl implements LoginUseCase {
  final AuthRepositoryImpl _repository;

  LoginUseCaseImpl(this._repository);

  @override
  Future<Either<AuthException, (List<TaskEntity>, UserEntity user)>> call({
    required String email,
    required String password,
  }) async {
    return await _repository.login(email: email, password: password);
  }
}
