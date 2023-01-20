// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskViewModel _$TaskViewModelFromJson(Map<String, dynamic> json) =>
    TaskViewModel(
      id: json['id'] as String,
      title: json['title'] as String,
      order: json['order'] as int,
      description: json['description'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
    );

Map<String, dynamic> _$TaskViewModelToJson(TaskViewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'order': instance.order,
      'description': instance.description,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };
