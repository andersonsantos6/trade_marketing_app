// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  Computed<bool>? _$isNullComputed;

  @override
  bool get isNull => (_$isNullComputed ??=
          Computed<bool>(() => super.isNull, name: 'HomeStoreBase.isNull'))
      .value;
  Computed<TaskEntity?>? _$selectedtaskComputed;

  @override
  TaskEntity? get selectedtask => (_$selectedtaskComputed ??=
          Computed<TaskEntity?>(() => super.selectedtask,
              name: 'HomeStoreBase.selectedtask'))
      .value;

  late final _$loggedUserAtom =
      Atom(name: 'HomeStoreBase.loggedUser', context: context);

  @override
  UserEntity? get loggedUser {
    _$loggedUserAtom.reportRead();
    return super.loggedUser;
  }

  @override
  set loggedUser(UserEntity? value) {
    _$loggedUserAtom.reportWrite(value, super.loggedUser, () {
      super.loggedUser = value;
    });
  }

  late final _$tasksAtom = Atom(name: 'HomeStoreBase.tasks', context: context);

  @override
  List<TaskEntity>? get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(List<TaskEntity>? value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  late final _$selectedTaskIdAtom =
      Atom(name: 'HomeStoreBase.selectedTaskId', context: context);

  @override
  int? get selectedTaskId {
    _$selectedTaskIdAtom.reportRead();
    return super.selectedTaskId;
  }

  @override
  set selectedTaskId(int? value) {
    _$selectedTaskIdAtom.reportWrite(value, super.selectedTaskId, () {
      super.selectedTaskId = value;
    });
  }

  late final _$listToDeleteTasksAtom =
      Atom(name: 'HomeStoreBase.listToDeleteTasks', context: context);

  @override
  List<TaskEntity> get listToDeleteTasks {
    _$listToDeleteTasksAtom.reportRead();
    return super.listToDeleteTasks;
  }

  @override
  set listToDeleteTasks(List<TaskEntity> value) {
    _$listToDeleteTasksAtom.reportWrite(value, super.listToDeleteTasks, () {
      super.listToDeleteTasks = value;
    });
  }

  late final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase', context: context);

  @override
  void setSelectedTaskId(int? id) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setSelectedTaskId');
    try {
      return super.setSelectedTaskId(id);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTaskToDelete(int index, bool value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setTaskToDelete');
    try {
      return super.setTaskToDelete(index, value);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTaskResponse(String? response, int taskIndex) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setTaskResponse');
    try {
      return super.setTaskResponse(response, taskIndex);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loggedUser: ${loggedUser},
tasks: ${tasks},
selectedTaskId: ${selectedTaskId},
listToDeleteTasks: ${listToDeleteTasks},
isNull: ${isNull},
selectedtask: ${selectedtask}
    ''';
  }
}
