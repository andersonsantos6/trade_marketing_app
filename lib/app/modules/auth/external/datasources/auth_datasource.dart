import 'package:trade_marketing_app/app/modules/auth/domain/entities/task_entity.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/entities/user_entity.dart';

abstract class AuthDatasource {
  Future<(List<TaskEntity> tasks, UserEntity user)> login({
    required String email,
    required String password,
  });
}
