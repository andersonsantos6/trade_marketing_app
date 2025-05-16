import 'package:flutter_modular/flutter_modular.dart';
import 'package:trade_marketing_app/app/modules/auth/auth_module.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module('/home/', module: HomeModule());
    r.module('/', module: AuthModule());
  }
}
