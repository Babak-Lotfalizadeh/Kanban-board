// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:kanban_board/enums/kanban_enum.dart';
import 'package:kanban_board/view_model/task_view_model.dart';

part 'kanban_view_model.g.dart';

@JsonSerializable()
class KanbanViewModel {
  final int id;
  final KanbanEnum kanbanEnum;
  final List<TaskViewModel> items;

  KanbanViewModel({
    required this.id,
    required this.kanbanEnum,
    required this.items,
  });

  factory KanbanViewModel.fromJson(Map<String, dynamic> json) =>
      _$KanbanViewModelFromJson(json);

  Map<String, dynamic> toJson() => _$KanbanViewModelToJson(this);
}
