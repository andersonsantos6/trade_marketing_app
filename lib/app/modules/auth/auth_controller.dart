import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:trade_marketing_app/app/core/toast.dart';
import 'package:trade_marketing_app/app/core/types.dart';
import 'package:trade_marketing_app/app/modules/auth/auth_store.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/entities/task_entity.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/usecases/login.dart';
import 'package:trade_marketing_app/app/modules/auth/infra/models/user_model.dart';
import 'package:trade_marketing_app/app/modules/auth/infra/services/storage_service_impl.dart';
import 'package:collection/collection.dart';
part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  final AuthStore _authStore;

  final LoginUseCaseImpl _loginUseCaseImpl;
  final StorageServiceImpl _storageServiceImpl;

  _AuthControllerBase(
      this._authStore, this._loginUseCaseImpl, this._storageServiceImpl);

  @computed
  AuthStore get authStore => _authStore;

  @action
  Future<void> fetchStorageData(BuildContext context) async {
    log('Obtendo dados do storage...');
    try {
      final userMap = await _storageServiceImpl.getData('user');
      final tasksMap = await _storageServiceImpl.getData('tasks');

      log('User: $userMap');
      log('Tasks: $tasksMap');

      if (userMap != null && tasksMap != null) {
        final user = UserModel.fromMap(userMap);
        final tasks =
            (tasksMap as List).map((e) => TaskEntity.fromMap(e)).toList();
        Navigator.of(context).pushNamed(
          '/home/',
          arguments: {
            'tasks': tasks,
            'user': user,
          },
        );
      }
    } catch (e) {
      showToast(
          type: ToastType.error,
          title: 'Erro!',
          description:
              'Ocorreu um erro ao obter os dados do storage ${e.toString()}');
    }
  }

  @action
  Future<void> login(BuildContext context) async {
    final result = await _loginUseCaseImpl(
      email: _authStore.email ?? '',
      password: _authStore.password ?? '',
    );

    result.fold(
      (l) async {
        showToast(
            type: ToastType.info,
            title: 'Atenção!',
            description:
                'Ocorreu um erro ao se conectar com servidor ${l.message ?? ''}');
        await fetchStorageData(context);
        log(l.message ?? '');
      },
      (data) async {
        // Handle success
        showToast(
            type: ToastType.success,
            title: 'Sucesso!',
            description: 'Login realizado com sucesso!');

        log('${data.$1.map((e) => e.toMap())}');
        log('${UserModel.fromEntity(data.$2).toMap()}');
        await _storageServiceImpl.saveData(
            'user', UserModel.fromEntity(data.$2).toMap());

        await _storageServiceImpl.saveData(
            'tasks', data.$1.map((e) => e.toMap()).toList());

        /*      final userMap = await _storageServiceImpl.getData('user');
        final tasksMap = await _storageServiceImpl.getData('tasks');

        log('User: $userMap');
        log('Tasks: $tasksMap');

        final tasks =
            (tasksMap as List).map((e) => TaskEntity.fromMap(e)).toList();
        final user = data.$2; */

        Navigator.of(context).pushNamed(
          '/home/',
          arguments: {
            'tasks': data.$1,
            'user': data.$2,
          },
        );
      },
    );
  }
}
