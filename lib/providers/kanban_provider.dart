import 'package:flutter/material.dart';
import 'package:kanban_board/view_model/kanban_view_model.dart';

class KanbanProvider extends ChangeNotifier {
  int? get dragPos => _dragPos;
  int? _dragPos;

  KanbanViewModel get kanbanViewModel => _kanbanViewModel;
  late KanbanViewModel _kanbanViewModel;

  void init(KanbanViewModel kanbanViewModel) {
    _kanbanViewModel = kanbanViewModel;
  }

  void onDrag(int? newPos) {
    _dragPos = newPos;
    notifyListeners();
  }
}
