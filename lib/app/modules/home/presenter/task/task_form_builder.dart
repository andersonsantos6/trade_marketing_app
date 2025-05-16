import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:trade_marketing_app/app/core/shared/text_form.dart';
import 'package:trade_marketing_app/app/core/types.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/entities/task_entity.dart';
import 'package:trade_marketing_app/app/modules/home/home_controller.dart';

class TaskFormBuilder extends StatefulWidget {
  const TaskFormBuilder({super.key});

  @override
  State<TaskFormBuilder> createState() => _TaskFormBuilderState();
}

class _TaskFormBuilderState extends State<TaskFormBuilder> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _controller = Modular.get<HomeController>();

  Widget _taskBuilderField() {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
            contentPadding: const EdgeInsets.all(10),
            title: const Text('Criar nova tarefa'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      readOnly: !isNewTask,
                      initialValue: taskName,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                      labelText: 'Nome da tarefa',
                      hintText: 'Informe o nome da tarefa',
                      onChanged: (v) {
                        taskName = v;
                      },
                    ),
                    CustomTextFormField(
                      readOnly: !isNewTask,
                      initialValue: taskDescription,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                      labelText: 'Descrição da tarefa',
                      hintText: 'Informe a descrição da tarefa',
                      onChanged: (v) {
                        taskDescription = v;
                      },
                    ),
                    CustomTextFormField(
                      initialValue: fieldName,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                      labelText: 'Nome do campo',
                      hintText: 'Informe o nome do campo',
                      onChanged: (v) {
                        fieldName = v;
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: FieldTaskType.values.map((e) {
                        return Expanded(
                          child: RadioListTile.adaptive(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(_getFieldType(e)),
                            value: e,
                            groupValue: fieldType,
                            onChanged: (v) {
                              setState(() {
                                fieldType = v!;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    CheckboxListTile(
                      title: const Text('Campo obrigatório'),
                      value: fieldIsRequired,
                      onChanged: (v) {
                        setState(() {
                          fieldIsRequired = v!;
                        });
                      },
                    ),
                    SizedBox(
                        height: 38,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              _formKey.currentState?.save();

                              if (isNewTask) {
                                currentTask = TaskEntity(
                                  taskName: taskName,
                                  id: Random().nextInt(100),
                                  description: taskDescription,
                                  fields: [
                                    FieldEntity(
                                      id: Random().nextInt(100),
                                      label: fieldName,
                                      response: null,
                                      fieldType: fieldType,
                                      required: fieldIsRequired,
                                    )
                                  ],
                                );
                              } else {
                                if (isEditQuestion) {
                                  final findIndex = currentTask?.fields
                                      ?.indexWhere((element) =>
                                          element.id == editinegFieldId);

                                  if (findIndex != null && findIndex != -1) {
                                    currentTask?.fields?[findIndex] =
                                        FieldEntity(
                                      label: fieldName,
                                      response: null,
                                      id: editinegFieldId,
                                      fieldType: fieldType,
                                      required: fieldIsRequired,
                                    );
                                  }
                                } else {
                                  currentTask?.fields?.add(
                                    FieldEntity(
                                      label: fieldName,
                                      id: Random().nextInt(100),
                                      fieldType: fieldType,
                                      required: fieldIsRequired,
                                    ),
                                  );
                                }
                              }

                              clearFields();
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            isEditQuestion ? 'Atualizar' : 'Criar',
                          ),
                        ))
                  ],
                ),
              ),
            ));
      },
    );
  }

  String _getFieldType(FieldTaskType? type) {
    switch (type) {
      case FieldTaskType.text:
        return 'Texto';
      case FieldTaskType.mask_price:
        return 'Valor';
      case FieldTaskType.mask_date:
        return 'Data';
      default:
        return '';
    }
  }

  FieldTaskType fieldType = FieldTaskType.text;
  String? fieldName;
  bool fieldIsRequired = false;

  String? taskName;
  String? taskDescription;
  TaskEntity? currentTask;

  bool get isNewTask => currentTask == null;
  bool get isEditQuestion => editinegFieldId != null;

  int? editinegFieldId;

  void clearFields() {
    setState(() {
      fieldName = null;
      editinegFieldId = null;
      fieldType = FieldTaskType.text;
      fieldIsRequired = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          clearFields();
          showDialog(
            context: context,
            builder: (context) {
              return _taskBuilderField();
            },
          );
        },
      ),
      appBar: AppBar(
        actions: [
          Visibility(
            visible: !isNewTask &&
                (currentTask?.fields != null &&
                    currentTask!.fields!.isNotEmpty),
            child: IconButton(
                onPressed: () async {
                  _controller.store.tasks = _controller.store.tasks
                      ?.followedBy([currentTask!]).toList();
                  await _controller.saveTasks();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.save)),
          ),
        ],
        automaticallyImplyLeading: true,
        title: Text(currentTask?.taskName ?? 'Task Form Builder'),
      ),
      body: Builder(builder: (context) {
        if (isNewTask) {
          return const Center(child: Text('Nenhuma tarefa criada'));
        }

        return ListView.builder(
          itemCount: currentTask?.fields?.length,
          itemBuilder: (context, index) {
            final item = currentTask?.fields?[index];
            return ListTile(
              trailing: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        editinegFieldId = item?.id;
                        fieldName = item?.label;
                        fieldType = item?.fieldType ?? FieldTaskType.text;
                        fieldIsRequired = item?.required ?? false;

                        showDialog(
                          context: context,
                          builder: (context) {
                            return _taskBuilderField();
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        currentTask?.fields?.removeAt(index);
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              title: Text(item?.label ?? ''),
              subtitle: Text(_getFieldType(item?.fieldType)),
            );
          },
        );
      }),
    );
  }
}
