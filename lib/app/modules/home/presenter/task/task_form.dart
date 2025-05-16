import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:trade_marketing_app/app/core/consts.dart';
import 'package:trade_marketing_app/app/core/shared/text_form.dart';
import 'package:trade_marketing_app/app/core/types.dart';
import 'package:trade_marketing_app/app/modules/auth/domain/entities/task_entity.dart';
import 'package:trade_marketing_app/app/modules/home/home_controller.dart';
import 'package:collection/collection.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key, this.taskId});
  final int? taskId;
  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _homeController = Modular.get<HomeController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget buildTaskFields() {
    if (_homeController.store.selectedtask?.fields != null &&
        _homeController.store.selectedtask!.fields!.isNotEmpty) {
      return Form(
        key: _formKey,
        child: ListView.builder(
          itemCount: _homeController.store.selectedtask?.fields?.length ?? 0,
          itemBuilder: (context, index) {
            final item = _homeController.store.selectedtask?.fields?[index];

            String? _validateField(String? value) {
              switch (item?.fieldType) {
                case FieldTaskType.text:
                  if (item?.required == true) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                  }

                  return null;

                case FieldTaskType.mask_price:
                  if (item?.required == true) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }

                    double? price;

                    try {
                      price = UtilBrasilFields.converterMoedaParaDouble(value);
                    } catch (e) {
                      price = null;
                    }

                    if (price == null || price == 0) {
                      return 'Valor inválido';
                    }
                  }
                  return null;

                case FieldTaskType.mask_date:
                  if (item?.required == true) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    DateTime? date;
                    try {
                      date = DateFormat('dd/MM/yyyy').parseStrict(value);
                    } catch (e) {
                      date = null;
                    }

                    if (date == null) {
                      return 'Data inválida';
                    }
                  }
                  return null;

                default:
                  return null;
              }
            }

            if (item?.fieldType == FieldTaskType.mask_date) {
              return CustomTextFormField(
                initialValue: item?.response,
                validator: _validateField,
                onSaved: (response) {
                  _homeController.store.setTaskResponse(response, index);
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter()
                ],
                labelText: '${item?.label}',
                hintText: '${item?.label}',
                prefixIcon: const Icon(Icons.date_range),
              );
            } else if (item?.fieldType == FieldTaskType.text) {
              return CustomTextFormField(
                initialValue: item?.response,
                onSaved: (response) {
                  _homeController.store.setTaskResponse(response, index);
                },
                validator: _validateField,
                labelText: '${item?.label}',
                hintText: '${item?.label}',
                prefixIcon: const Icon(Icons.text_fields),
              );
            } else if (item?.fieldType == FieldTaskType.mask_price) {
              return CustomTextFormField(
                initialValue: item?.response,
                validator: _validateField,
                onSaved: (response) {
                  _homeController.store.setTaskResponse(response, index);
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CentavosInputFormatter(casasDecimais: 2, moeda: true)
                ],
                labelText: '${item?.label}',
                suffixIcon: const Icon(Icons.monetization_on),
                hintText: '${item?.label}',
                prefixIcon: const Icon(Icons.monetization_on),
              );
            }

            return SizedBox.fromSize();
          },
        ),
      );
    }

    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Observer(builder: (_) {
          return Text(_homeController.store.selectedtask?.taskName ?? '');
        }),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: defaultPadding),
            Observer(builder: (_) {
              return Text(
                  _homeController.store.selectedtask?.description ?? '');
            }),
            const SizedBox(height: defaultPadding),
            Expanded(child: buildTaskFields()),
            const SizedBox(height: defaultPadding),
            SizedBox(
              height: 38,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                    bool? isValid = _formKey.currentState?.validate();

                    if (isValid == true) {
                      _formKey.currentState?.save();
                      await _homeController.saveTasks();
                      await _homeController.fetchSavedItems();

                      Navigator.pop(context);

                      //enviar respostas
                    }
                  },
                  child: const Text('Salvar')),
            )
          ],
        ),
      ),
    );
  }
}
