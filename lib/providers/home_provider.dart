import 'package:flutter/material.dart';
import 'package:kanban_board/enums/kanban_enum.dart';
import 'package:kanban_board/firebase/firebase_authentication_service.dart';
import 'package:kanban_board/firebase/firebase_database_service.dart';
import 'package:kanban_board/view_model/kanban_view_model.dart';
import 'package:kanban_board/view_model/task_view_model.dart';
import 'package:uuid/uuid.dart';

class HomeProvider extends ChangeNotifier {
  final String? _userId = FirebaseAuthenticationService().currentUser?.uid;
  bool _changeScreenLock = false;
  final PageController controller = PageController(
    viewportFraction: 0.8,
  );

  List<KanbanViewModel> get items => _items;
  List<KanbanViewModel> _items = [
    //todo dummy data
    KanbanViewModel(
      id: 0,
      kanbanEnum: KanbanEnum.todo,
      items: [
        TaskViewModel(
          id: const Uuid().v1(),
          order: 1,
          title: "Lorem ipsum dolor sit amet",
          description:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
        ),
        TaskViewModel(
          id: const Uuid().v1(),
          order: 2,
          title: "eiusmod tempor incididunt",
          description:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
        ),
      ],
    ),
    KanbanViewModel(
      id: 1,
      kanbanEnum: KanbanEnum.inProgress,
      items: [],
    ),
    KanbanViewModel(
      id: 2,
      kanbanEnum: KanbanEnum.don,
      items: [],
    ),
  ];

  void init(){
    FirebaseDatabaseService().getUserData(_userId).then((value) {
      _items = value;
      notifyListeners();
    });
  }

  void onGoNextPage() {
    if (_changeScreenLock) return;
    var currentPage = (controller.page ?? 0.0).toInt();
    ++currentPage;
    if (currentPage >= _items.length) {
      return;
    }
    _changeScreenLock = true;
    controller.animateToPage(
      currentPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
    Future.delayed(const Duration(seconds: 1), () => _changeScreenLock = false);
  }

  void onGoBeforePage() {
    if (_changeScreenLock) return;
    var currentPage = (controller.page ?? 0.0).toInt();
    if (currentPage == 0) {
      return;
    }
    _changeScreenLock = true;
    controller.animateToPage(
      --currentPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
    Future.delayed(const Duration(seconds: 1), () => _changeScreenLock = false);
  }

  void onAccept({
    required int? pos,
    required TaskViewModel taskViewModel,
    required KanbanViewModel kanbanViewModel,
  }) {
    Future.delayed(const Duration(microseconds: 200), () {
      var newPos = pos ?? 0;
      if (newPos < 0) {
        newPos = 0;
      } else if (newPos > kanbanViewModel.items.length) {
        newPos = kanbanViewModel.items.length;
      }
      kanbanViewModel.items.insert(newPos, taskViewModel);
      for (int i = 0; i < kanbanViewModel.items.length; i++) {
        kanbanViewModel.items[i].order = (i + 1);
      }
      notifyListeners();
    });
  }

  void onDragCompleted({
    required int? pos,
    required TaskViewModel taskViewModel,
    required KanbanViewModel kanbanViewModel,
  }) {
    kanbanViewModel.items.removeWhere(
      (element) => element.id == taskViewModel.id,
    );
    Future.delayed(const Duration(microseconds: 400), () {
      var isSuccessfullyAdded = _items.any(
        (kanban) => kanban.items.any(
          (element) => element.id == taskViewModel.id,
        ),
      );
      if (!isSuccessfullyAdded) {
        onAccept(
          pos: pos,
          taskViewModel: taskViewModel,
          kanbanViewModel: kanbanViewModel,
        );
      }
    });
    notifyListeners();
  }

  void addNewItem(String value) {
    _items.first.items.add(TaskViewModel(
      id: const Uuid().v1(),
      order: _items.first.items.length,
      title: value,
    ));
    notifyListeners();
  }

  TaskViewModel getTask(String taskId) {
    for (var kanban in items) {
      if (kanban.items.any((element) => element.id == taskId)) {
        return kanban.items.where((element) => element.id == taskId).first;
      }
    }
    return items.first.items.first;
  }

  KanbanViewModel getTaskParent(String taskId) {
    for (var kanban in items) {
      if (kanban.items.any((element) => element.id == taskId)) {
        return kanban;
      }
    }
    return items.first;
  }

  void updateItem(TaskViewModel newModel) {
    var item = getTask(newModel.id);

    item.title = newModel.title;
    item.description = newModel.description;
    item.order = newModel.order;
    item.endDate = newModel.endDate;
    item.startDate = newModel.startDate;
    notifyListeners();
  }
}
