import 'package:flutter_modular/flutter_modular.dart';
import 'package:trade_marketing_app/app/modules/auth/auth_module.dart';
import 'package:trade_marketing_app/app/modules/home/home_controller.dart';
import 'package:trade_marketing_app/app/modules/home/presenter/task/task_form.dart';
import 'package:trade_marketing_app/app/modules/home/presenter/task/task_form_builder.dart';
import 'home_store.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    //store
    i.addLazySingleton(HomeStore.new);

    //controller
    i.addLazySingleton(HomeController.new);
  }

/*  @override
 final List<ModularRoute> routes = [
   ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
 ]; */

  @override
  void routes(r) {
    r.child(
      Modular.initialRoute,
      child: (context) => const HomePage(),
    );
    r.child('/task-form/:id/', child: (context) {
      int? id = int.tryParse(r.args.params['id']);
      return TaskForm(taskId: id);
    });

    r.child(
      '/task-builder/',
      child: (context) {
        return const TaskFormBuilder();
      },
    );
  }

  @override
  List<Module> get imports => [AuthModule()];
}
