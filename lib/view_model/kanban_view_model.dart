import 'package:kanban_board/enums/kanban_enum.dart';
import 'package:kanban_board/view_model/task_view_model.dart';

class KanbanViewModel {
  final int id;
  final KanbanEnum kanbanEnum;
  final List<TaskViewModel> items;

  KanbanViewModel({
    required this.id,
    required this.kanbanEnum,
    required this.items,
  });

  factory KanbanViewModel.fromJson(Map<String, dynamic> json) {
    var jsonItems =
        json.containsKey("items") ? json['items'] as List<dynamic> : [];

    TaskViewModel convert(dynamic e) {
      return TaskViewModel.fromJson(
        Map<String, dynamic>.from(e as Map<Object?, Object?>),
      );
    }
    var newItems = jsonItems.map((e) => convert(e)).toList();
    var kanbanEnum = (json['kanbanEnum'] as int);
    if(kanbanEnum < 0){
      kanbanEnum = 0;
    }else if(kanbanEnum >= KanbanEnum.values.length){
      kanbanEnum = KanbanEnum.values.length - 1;
    }

    return KanbanViewModel(
      id: json['id'] as int,
      kanbanEnum: KanbanEnum.values[kanbanEnum],
      items: newItems,
    );
  }

  Map<String, dynamic> toJson() {
    var result = <String, dynamic>{};

    result.addAll({
      'id': id,
      'kanbanEnum': kanbanEnum.index,
      "items": items.map((e) => e.toJson()).toList(),
    });
    return result;
  }
}
