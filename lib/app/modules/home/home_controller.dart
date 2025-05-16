import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:trade_marketing_app/app/core/toast.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/entities/task_entity.dart';
import 'package:trade_marketing_app/app/modules/auth/infra/services/storage_service_impl.dart';
import 'package:trade_marketing_app/app/modules/home/home_store.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final HomeStore _homeStore;
  final StorageServiceImpl _storageServiceImpl;

  _HomeControllerBase(this._homeStore, this._storageServiceImpl);

  @computed
  HomeStore get store => _homeStore;

  @action
  Future<void> deleteSelectedTasks() async {
    if (_homeStore.listToDeleteTasks.isNotEmpty) {
      for (var task in _homeStore.listToDeleteTasks) {
        _homeStore.tasks?.remove(task);
      }
      _homeStore.listToDeleteTasks.clear();
    }
    showToast(
        type: ToastType.success,
        title: 'Sucesso!',
        description: 'Sucesso ao deletar as tarefas selecionadas');
    await saveTasks();
  }

  @action
  Future<void> fetchSavedItems() async {
    final tasks = await _storageServiceImpl.getData('tasks');
    store.tasks = (tasks as List).map((e) => TaskEntity.fromMap(e)).toList();
  }

  @action
  Future<void> saveTasks() async {
    await _storageServiceImpl.saveData(
        'tasks', _homeStore.tasks?.map((e) => e.toMap()).toList());

    showToast(
        type: ToastType.success,
        title: 'Sucesso!',
        description: 'Sucesso ao salvar as tarefas');
  }
}
