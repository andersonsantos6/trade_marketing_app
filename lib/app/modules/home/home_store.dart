import 'dart:developer';

import 'package:mobx/mobx.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/entities/task_entity.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/entities/user_entity.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  @observable
  UserEntity? loggedUser;

  @observable
  List<TaskEntity>? tasks;

  @observable
  int? selectedTaskId;

  @computed
  bool get isNull => selectedTaskId == null;

  @action
  void setSelectedTaskId(int? id) {
    selectedTaskId = id;
  }

  @action
  void setTaskToDelete(int index, bool value) {
    tasks?[index].isSelected = value;
    listToDeleteTasks = tasks!.where((task) => task.isSelected).toList();
  }

  @observable
  List<TaskEntity> listToDeleteTasks = ObservableList.of([]);

  @computed
  TaskEntity? get selectedtask => selectedTaskId != null
      ? tasks?.firstWhere((task) => task.id == selectedTaskId)
      : null;

  @action
  void setTaskResponse(String? response, int taskIndex) {
    selectedtask?.fields?[taskIndex].setResponse(response);
  }
}
