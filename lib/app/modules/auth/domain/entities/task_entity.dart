import 'dart:convert';
import 'package:collection/collection.dart';

import 'package:trade_marketing_app/app/core/types.dart';

class TaskEntity {
  int? id;
  bool isSelected;
  String? taskName;
  String? description;
  List<FieldEntity>? fields;
  TaskEntity({
    this.id,
    this.isSelected = false,
    this.taskName,
    this.description,
    this.fields,
  });

  void setSelected(bool value) {
    isSelected = value;
  }

  factory TaskEntity.fromMap(dynamic map) {
    return TaskEntity(
      id: map['id'] != null ? map['id'] as int : null,
      taskName: map['task_name'] != null ? map['task_name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      fields: map['fields'] != null
          ? List<FieldEntity>.from(
              (map['fields'] as List<dynamic>).map<FieldEntity?>(
                (x) => FieldEntity.fromMap(x as dynamic),
              ),
            )
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task_name': taskName,
      'description': description,
      'fields': fields?.map((x) => x.toMap()).toList(),
    };
  }

  factory TaskEntity.fromJson(String source) =>
      TaskEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}

class FieldEntity {
  int? id;
  String? label;
  bool? required;
  String? response;
  FieldTaskType? fieldType;

  FieldEntity({
    this.id,
    this.label,
    this.response,
    this.required,
    this.fieldType,
  });

  void setResponse(String? value) {
    response = value;
  }

  factory FieldEntity.fromMap(dynamic map) {
    return FieldEntity(
      response: map['response'] != null ? map['response'] as String : null,
      id: map['id'] != null ? map['id'] as int : null,
      label: map['label'] != null ? map['label'] as String : null,
      required: map['required'] != null ? map['required'] as bool : null,
      fieldType: FieldTaskType.values.firstWhereOrNull(
          (e) => e.name == (map['field_type'] as String?)?.toLowerCase()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'required': required,
      if (response != null) 'response': response,
      'field_type': fieldType?.name,
    };
  }

  factory FieldEntity.fromJson(String source) =>
      FieldEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
