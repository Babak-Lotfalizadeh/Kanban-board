import 'package:flutter/material.dart';
import 'package:kanban_board/enums/task_drag_status.dart';
import 'package:kanban_board/view_model/task_view_model.dart';
import 'package:kanban_board/widgets/kanban/task_widget.dart';

class KanbanCard extends StatelessWidget {
  final TaskViewModel taskViewModel;
  final Function(TaskViewModel taskViewModel) onDragCompleted;

  const KanbanCard({
    required this.taskViewModel,
    required this.onDragCompleted,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<TaskViewModel>(
      data: taskViewModel,
      onDragCompleted: () => onDragCompleted.call(taskViewModel),
      feedback: TaskWidget(
        taskId: taskViewModel.id,
        taskDragStatus: TaskDragStatus.feedback,
      ),
      childWhenDragging: TaskWidget(
        taskId: taskViewModel.id,
        taskDragStatus: TaskDragStatus.whenDragging,
      ),
      child: TaskWidget(
        taskId: taskViewModel.id,
        taskDragStatus: TaskDragStatus.normal,
      ),
    );
  }
}
