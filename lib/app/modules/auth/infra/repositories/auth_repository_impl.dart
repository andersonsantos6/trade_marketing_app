import 'package:dartz/dartz.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/entities/task_entity.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/errors/auth_error.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:trade_marketing_app/app/modules/auth/infra/datasources/atuh_datasource_impl.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AtuhDatasourceImpl _datasourceImpl;

  AuthRepositoryImpl(this._datasourceImpl);
  @override
  Future<Either<AuthException, (List<TaskEntity>, UserEntity)>> login(
      {required String email, required String password}) async {
    try {
      final result =
          await _datasourceImpl.login(email: email, password: password);
      return Right(result);
    } catch (e) {
      return Left(
        AuthException(
          e.toString(),
        ),
      );
    }
  }
}
