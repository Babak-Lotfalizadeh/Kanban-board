import 'package:flutter/material.dart';
import 'package:kanban_board/view_model/task_view_model.dart';

class DragTargetWidget extends StatelessWidget {
  final Widget child;
  final int index;
  final Function(int? dragPos) onDrag;
  final Function(TaskViewModel taskViewModel, int? pos) onAccept;

  const DragTargetWidget({
    required this.child,
    required this.index,
    required this.onDrag,
    required this.onAccept,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<TaskViewModel>(
      builder: (context, candidateData, rejectedData) => child,
      onAccept: (data) {
        onAccept(data, index);
        onDrag(null);
      },
      onLeave: (data) => onDrag(null),
      onMove: (details) => onDrag(index),
    );
  }
}
