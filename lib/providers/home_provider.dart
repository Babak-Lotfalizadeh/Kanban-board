import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:kanban_board/enums/kanban_enum.dart';
import 'package:kanban_board/firebase/firebase_authentication_service.dart';
import 'package:kanban_board/firebase/firebase_database_service.dart';
import 'package:kanban_board/view_model/kanban_view_model.dart';
import 'package:kanban_board/view_model/task_view_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class HomeProvider extends ChangeNotifier {
  final String? _userId = FirebaseAuthenticationService().currentUser?.uid;
  bool _changeScreenLock = false;
  final PageController controller = PageController(
    viewportFraction: 0.8,
  );

  bool get savingCSV => _savingCSV;
  bool _savingCSV = false;

  List<KanbanViewModel> get items => _items;
  List<KanbanViewModel> _items = [];

  void init() {
    FirebaseDatabaseService().getUserData(_userId).then((value) {
      if (value.isNotEmpty) {
        _items = value;
      } else {
        _items.addAll([
          KanbanViewModel(
            id: 0,
            kanbanEnum: KanbanEnum.todo,
            items: [],
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
        ]);
      }
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
      if (kanbanViewModel.kanbanEnum == KanbanEnum.inProgress) {
        taskViewModel.startDate = DateTime.now().toIso8601String();
      } else if (kanbanViewModel.kanbanEnum == KanbanEnum.don) {
        taskViewModel.endDate = DateTime.now().toIso8601String();
      }

      kanbanViewModel.items.insert(newPos, taskViewModel);
      for (int i = 0; i < kanbanViewModel.items.length; i++) {
        kanbanViewModel.items[i].order = (i + 1);
      }
      syncData();
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
    syncData();
  }

  void addNewItem(String value) {
    _items.first.items.add(TaskViewModel(
      id: const Uuid().v1(),
      order: _items.first.items.length,
      title: value,
    ));
    syncData();
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
    syncData();
  }

  void syncData() {
    notifyListeners();
    FirebaseDatabaseService().setUserData(items: _items, userId: _userId);
  }

  Future<void> exportCSV() async {
    if(_savingCSV) return;
    _savingCSV = true;
    notifyListeners();
    final String directory = ((await getExternalStorageDirectory()) ?? (await getApplicationDocumentsDirectory())).path;
    final path = "$directory/csv-${DateTime.now()}.csv";
    List<List<String>> data = [
      ["taskId", "title", "description", "startDate", "endDate", "status"]
    ];
    for (var kanban in items) {
      for (var element in kanban.items) {
        data.add([
          element.id,
          element.title,
          element.description ?? "",
          element.startDate ?? "",
          element.endDate ?? "",
          kanban.kanbanEnum.toString(),
        ]);
      }
    }
    String csvData = const ListToCsvConverter().convert(data);
    final File file = File(path);
    await file.writeAsString(csvData);
    await _shareFile(path);
    _savingCSV = false;
    notifyListeners();
  }

  Future<void> _shareFile(String path) async {
    await FlutterShare.shareFile(
      title: 'CSV',
      text: 'share CSV',
      filePath: path,
    );
  }
}
