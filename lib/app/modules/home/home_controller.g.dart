// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on _HomeControllerBase, Store {
  Computed<HomeStore>? _$storeComputed;

  @override
  HomeStore get store =>
      (_$storeComputed ??= Computed<HomeStore>(() => super.store,
              name: '_HomeControllerBase.store'))
          .value;

  late final _$deleteSelectedTasksAsyncAction =
      AsyncAction('_HomeControllerBase.deleteSelectedTasks', context: context);

  @override
  Future<void> deleteSelectedTasks() {
    return _$deleteSelectedTasksAsyncAction
        .run(() => super.deleteSelectedTasks());
  }

  late final _$fetchSavedItemsAsyncAction =
      AsyncAction('_HomeControllerBase.fetchSavedItems', context: context);

  @override
  Future<void> fetchSavedItems() {
    return _$fetchSavedItemsAsyncAction.run(() => super.fetchSavedItems());
  }

  late final _$saveTasksAsyncAction =
      AsyncAction('_HomeControllerBase.saveTasks', context: context);

  @override
  Future<void> saveTasks() {
    return _$saveTasksAsyncAction.run(() => super.saveTasks());
  }

  @override
  String toString() {
    return '''
store: ${store}
    ''';
  }
}
