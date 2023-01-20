import 'package:flutter/material.dart';
import 'package:kanban_board/view_model/task_view_model.dart';
import 'package:kanban_board/widgets/kanban/drag_target_widget.dart';
import 'package:kanban_board/widgets/kanban/kanban_card.dart';
import 'package:kanban_board/widgets/kanban/kanban_separator.dart';

class KanbanListView extends StatelessWidget {
  final List<TaskViewModel> items;
  final int? dragPos;
  final Function(int? dragPos) onDrag;
  final Function(TaskViewModel taskViewModel, int? pos) onAccept;
  final Function(TaskViewModel taskViewModel, int? pos) onDragCompleted;

  const KanbanListView({
    required this.items,
    required this.dragPos,
    required this.onDrag,
    required this.onAccept,
    required this.onDragCompleted,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemBuilder: (context, index) => KanbanCard(
            taskViewModel: items[index],
            onDragCompleted: (taskViewModel) => onDragCompleted(
              taskViewModel,
              index,
            ),
          ),
          separatorBuilder: (context, index) => KanbanSeparator(
            dragPos: dragPos,
            index: index,
            onDrag: onDrag,
            onAccept: onAccept,
          ),
          itemCount: items.length,
        ),
        DragTargetWidget(
          index: items.length,
          onAccept: onAccept,
          onDrag: onDrag,
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.2,
          ),
        ),
      ],
    );
  }
}
