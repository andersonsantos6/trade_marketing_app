// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthController on _AuthControllerBase, Store {
  Computed<AuthStore>? _$authStoreComputed;

  @override
  AuthStore get authStore =>
      (_$authStoreComputed ??= Computed<AuthStore>(() => super.authStore,
              name: '_AuthControllerBase.authStore'))
          .value;

  late final _$fetchStorageDataAsyncAction =
      AsyncAction('_AuthControllerBase.fetchStorageData', context: context);

  @override
  Future<void> fetchStorageData(BuildContext context) {
    return _$fetchStorageDataAsyncAction
        .run(() => super.fetchStorageData(context));
  }

  late final _$loginAsyncAction =
      AsyncAction('_AuthControllerBase.login', context: context);

  @override
  Future<void> login(BuildContext context) {
    return _$loginAsyncAction.run(() => super.login(context));
  }

  @override
  String toString() {
    return '''
authStore: ${authStore}
    ''';
  }
}
