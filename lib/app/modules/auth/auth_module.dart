import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:trade_marketing_app/app/modules/auth/auth_controller.dart';
import 'package:trade_marketing_app/app/modules/auth/auth_page.dart';
import 'package:trade_marketing_app/app/modules/auth/auth_store.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/usecases/login.dart';
import 'package:trade_marketing_app/app/modules/auth/infra/datasources/atuh_datasource_impl.dart';
import 'package:trade_marketing_app/app/modules/auth/infra/repositories/auth_repository_impl.dart';
import 'package:trade_marketing_app/app/modules/auth/infra/services/storage_service_impl.dart';

class AuthModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<Box>(() => Hive.box('authBox'));
    i.addLazySingleton(StorageServiceImpl.new);
    //controllers
    i.addLazySingleton(AuthController.new);

    //stores
    i.addLazySingleton(AuthStore.new);

    //repo
    i.addLazySingleton(AuthRepositoryImpl.new);

    //datasource
    i.addLazySingleton(AtuhDatasourceImpl.new);

    //usecases
    i.addLazySingleton(LoginUseCaseImpl.new);

    //i.addLazySingleton(HomeStore.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const AuthPage(),
    );
  }
}
