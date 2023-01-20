import 'package:kanban_board/view_model/kanban_view_model.dart';

class UserDataViewModel {
  final List<KanbanViewModel> items;

  UserDataViewModel({
    required this.items,
  });

  factory UserDataViewModel.fromJson(Map<String, dynamic> json) {
    var jsonItems =
    json.containsKey("items") ? json['items'] as List<dynamic> : [];

    KanbanViewModel convert(dynamic e) {
      return KanbanViewModel.fromJson(
        Map<String, dynamic>.from(e as Map<Object?, Object?>),
      );
    }

    var newItems = jsonItems.map((e) => convert(e)).toList();

    return UserDataViewModel(
      items: newItems,
    );
  }

  Map<String, dynamic> toJson() {
    var result = <String, dynamic>{};

    result.addAll({
      "items": items.map((e) => e.toJson()).toList(),
    });
    return result;
  }
}
