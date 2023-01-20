import 'package:flutter/material.dart';
import 'package:kanban_board/view_model/task_view_model.dart';
import 'package:kanban_board/widgets/kanban/drag_target_widget.dart';

class KanbanSeparator extends StatelessWidget {
  final int? dragPos;
  final int index;
  final double? height;
  final Function(int? dragPos) onDrag;
  final Function(TaskViewModel taskViewModel,int? pos) onAccept;

  const KanbanSeparator({
    required this.dragPos,
    required this.index,
    required this.onAccept,
    required this.onDrag,
    this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? (dragPos == index ? 50 : 8),
      child : DragTargetWidget(
        index: index,
        onAccept: onAccept,
        onDrag: onDrag,
        child: const SizedBox(),
      ),
    );
  }
}
