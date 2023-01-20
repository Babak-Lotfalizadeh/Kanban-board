import 'package:flutter/material.dart';
import 'package:kanban_board/constants/screen_values.dart';
import 'package:kanban_board/enums/kanban_enum.dart';
import 'package:kanban_board/providers/kanban_provider.dart';
import 'package:kanban_board/utilities/imports.dart';
import 'package:kanban_board/view_model/kanban_view_model.dart';
import 'package:kanban_board/view_model/task_view_model.dart';
import 'package:kanban_board/widgets/kanban/change_page_hit_box.dart';
import 'package:kanban_board/widgets/kanban/drag_target_widget.dart';
import 'package:kanban_board/widgets/kanban/kanban_list_view.dart';
import 'package:provider/provider.dart';

class KanbanScreen extends StatelessWidget {
  final Function() onGoNextPage;
  final Function() onGoBeforePage;
  final KanbanViewModel kanbanViewModel;
  final Function(TaskViewModel taskViewModel, int? pos) onAccept;
  final Function(TaskViewModel taskViewModel, int? pos) onDragCompleted;

  const KanbanScreen({
    required this.kanbanViewModel,
    required this.onGoNextPage,
    required this.onGoBeforePage,
    required this.onAccept,
    required this.onDragCompleted,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? getTitle() {
      var strings = AppLocalizations.of(context);
      switch (kanbanViewModel.kanbanEnum) {
        case KanbanEnum.todo:
          return strings?.todo;
        case KanbanEnum.inProgress:
          return strings?.inProgress;
        case KanbanEnum.don:
          return strings?.don;
      }
    }

    return ChangeNotifierProvider(
      create: (context) => KanbanProvider()..init(kanbanViewModel),
      child: Consumer<KanbanProvider>(
        builder: (context, kanbanProvider, child) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DragTargetWidget(
                index: -1,
                onAccept: onAccept,
                onDrag: kanbanProvider.onDrag,
                child: Column(
                  children: [
                    const SizedBox(height: ScreenValues.paddingLarge),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: ScreenValues.paddingLarge,
                      ),
                      child: Text(
                        getTitle() ?? "",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(ScreenValues.paddingLarge),
                    child: KanbanListView(
                      items: kanbanProvider.kanbanViewModel.items,
                      dragPos: kanbanProvider.dragPos,
                      onDrag: kanbanProvider.onDrag,
                      onAccept: onAccept,
                      onDragCompleted: onDragCompleted,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: DragTarget(
                      builder: (context, _, rejectedData) =>
                          const ChangePageHitBox(),
                      onMove: (details) => onGoBeforePage.call(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: DragTarget(
                      builder: (context, _, rejectedData) =>
                          const ChangePageHitBox(),
                      onMove: (details) => onGoNextPage.call(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
