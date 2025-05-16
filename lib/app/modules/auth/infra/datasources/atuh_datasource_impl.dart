import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:trade_marketing_app/app/core/mocks.dart';
import 'package:trade_marketing_app/app/core/types.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/entities/task_entity.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/errors/auth_error.dart';
import 'package:trade_marketing_app/app/modules/auth/external/datasources/auth_datasource.dart';
import 'package:http/http.dart' as http;
import 'package:trade_marketing_app/app/modules/auth/infra/models/user_model.dart';
import 'package:collection/collection.dart';

class AtuhDatasourceImpl implements AuthDatasource {
  @override
  Future<(List<TaskEntity>, UserEntity)> login(
      {required String email, required String password}) async {
    final uri = Uri.parse('https://apimw.sistemagiv.com.br/TestMobile/auth');
    final response = await http.post(uri,
        body: jsonEncode({
          'user': email,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        });

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final body = jsonDecode(utf8.decode(response.bodyBytes));

      bool success = body['success'] == true;

      if (!success) {
        String? msg = body['message'];
        throw AuthException(msg ?? 'Erro ao fazer login');
      }

      final userBody = body['user'];
      final user = UserModel.fromMap(userBody);

      final tasksBody = body['tasks'] as List;

      final tasks = tasksBody.map((task) {
        return TaskEntity(
          id: task['id'],
          taskName: task['task_name'],
          description: task['description'],
          fields: (task['fields'] as List).map((field) {
            return FieldEntity(
              id: field['id'],
              label: field['label'],
              required: field['required'],
              fieldType: FieldTaskType.values.firstWhereOrNull((e) =>
                  e.name == (field['field_type'] as String?)?.toLowerCase()),
            );
          }).toList(),
        );
      }).toList();

      return (tasks, user);
    } else {
      const Map<String, dynamic> body = Mocks.loginResult;

      /*    bool success = body['success'] == true;

      if (!success) {
        String? msg = body['message'];
        throw AuthException(msg ?? 'Erro ao fazer login');
      }
 */
      final userBody = body['user'];
      final user = UserModel.fromMap(userBody);

      final tasksBody = userBody['tasks'] as List;

      final tasks = tasksBody.map((task) {
        return TaskEntity(
          id: task['id'],
          taskName: task['task_name'],
          description: task['description'],
          fields: (task['fields'] as List).map((field) {
            return FieldEntity(
              id: field['id'],
              label: field['label'],
              required: field['required'],
              fieldType: FieldTaskType.values.firstWhereOrNull((e) =>
                  e.name == (field['field_type'] as String?)?.toLowerCase()),
            );
          }).toList(),
        );
      }).toList();
      log('retornando mock');
      return (tasks, user);

      /*  String? msg = jsonDecode(utf8.decode(response.bodyBytes))['message'];
      throw AuthException(msg ?? 'Erro ao fazer login'); */
    }
  }
}
