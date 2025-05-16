import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/entities/task_entity.dart';
import 'package:trade_marketing_app/app/modules/home/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeController = Modular.get<HomeController>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeController.store.loggedUser = Modular.args.data['user'];
      _homeController.store.tasks = Modular.args.data['tasks'];
    });
    // TODO: implement initState
    super.initState();
  }

  Future<void> _showDeleteDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir tarefas selecionadas'),
          content: const Text('Todas as tarefas selecionadas serão excluídas'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await _homeController.deleteSelectedTasks();
                setState(() {});
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTaskStatus(
    List<FieldEntity> fields,
  ) {
    // Verifica se todos os campos estão preenchidos
    // Se todos os campos estiverem preenchidos, retorna 'Concluído'
    // Caso contrário, retorna 'Pendente'

    // Verifica se todos os campos OBRIGATÓRIOS estão preenchidos
    bool isComplete = fields
        .where((field) =>
            field.required == true) // Filtra apenas campos obrigatórios
        .every((field) =>
            field.response != null &&
            field.response!.isNotEmpty); // Verifica se TODOS estão preenchidos

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: isComplete ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isComplete ? 'Concluído' : 'Pendente',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildTaskItem(int index, TaskEntity? task) {
    return ListTile(
      key: ValueKey(task?.id),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/home/task-form/${task?.id}/',
        );

        _homeController.store.setSelectedTaskId(task?.id);
      },
      trailing: Observer(builder: (context) {
        return _buildTaskStatus(task?.fields ?? []);
      }),
      leading: Observer(builder: (_) {
        bool canDelete = task?.fields
                ?.where((field) =>
                    field.required == true) // Filtra apenas campos obrigatórios
                .every((field) =>
                    field.response != null && field.response!.isNotEmpty) ??
            false;
        return Checkbox(
            value: task?.isSelected ?? false,
            onChanged: canDelete
                ? (value) {
                    setState(() {
                      //seleciona a tarefa baseado no index da lista
                      _homeController.store
                          .setTaskToDelete(index, value ?? false);
                    });
                  }
                : null);
      }),
      title: Text(task?.taskName ?? ''),
      subtitle: Text(task?.description ?? ''),
    );
  }

  Future<void> _setAll() async {
    for (var task in _homeController.store.tasks!) {
      bool canDelete = task.fields
              ?.where((field) =>
                  field.required == true) // Filtra apenas campos obrigatórios
              .every((field) =>
                  field.response != null && field.response!.isNotEmpty) ??
          false;

      task.isSelected = canDelete;
    }
    _homeController.store.listToDeleteTasks =
        _homeController.store.tasks!.where((task) => task.isSelected).toList();
    setState(() {});
  }

  Future<void> _unselectAll() async {
    for (var task in _homeController.store.tasks!) {
      if (task.isSelected) {
        task.isSelected = false;
      }
    }
    _homeController.store.listToDeleteTasks =
        _homeController.store.tasks!.where((task) => task.isSelected).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/home/task-builder/');
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.select_all),
            onPressed: () {
              _setAll();
            },
          ),
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              _unselectAll();
            },
          ),
          Observer(
            builder: (context) {
              if (_homeController.store.listToDeleteTasks.isNotEmpty) {
                return IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: _showDeleteDialog,
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
        title: Observer(builder: (_) {
          return Text(
              _homeController.store.loggedUser?.name ?? 'Nome não encontrado');
        }),
        centerTitle: true,
      ),
      body: Observer(builder: (_) {
        return ListView.builder(
          itemCount: _homeController.store.tasks?.length ?? 0,
          itemBuilder: (context, index) {
            final task = _homeController.store.tasks?[index];
            return _buildTaskItem(index, task);
          },
        );
      }),
    );
  }
}
