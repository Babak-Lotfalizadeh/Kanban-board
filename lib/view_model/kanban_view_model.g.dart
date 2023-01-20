// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanban_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KanbanViewModel _$KanbanViewModelFromJson(Map<String, dynamic> json) =>
    KanbanViewModel(
      id: json['id'] as int,
      kanbanEnum: $enumDecode(_$KanbanEnumEnumMap, json['kanbanEnum']),
      items: (json['items'] as List<dynamic>)
          .map((e) => TaskViewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$KanbanViewModelToJson(KanbanViewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kanbanEnum': _$KanbanEnumEnumMap[instance.kanbanEnum]!,
      'items': instance.items,
    };

const _$KanbanEnumEnumMap = {
  KanbanEnum.todo: 'todo',
  KanbanEnum.inProgress: 'inProgress',
  KanbanEnum.don: 'don',
};
