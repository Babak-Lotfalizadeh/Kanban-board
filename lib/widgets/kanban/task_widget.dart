import 'package:flutter/material.dart';
import 'package:kanban_board/constants/screen_values.dart';
import 'package:kanban_board/enums/hero_tag.dart';
import 'package:kanban_board/enums/task_drag_status.dart';
import 'package:kanban_board/providers/home_provider.dart';
import 'package:kanban_board/services/navigation_service.dart';
import 'package:kanban_board/view_model/task_view_model.dart';
import 'package:kanban_board/widgets/kanban/task_full_widget.dart';
import 'package:provider/provider.dart';

class TaskWidget extends StatelessWidget {
  final String taskId;
  final TaskDragStatus taskDragStatus;

  const TaskWidget({
    required this.taskId,
    required this.taskDragStatus,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: taskDragStatus != TaskDragStatus.whenDragging,
      child: Transform.rotate(
        angle: taskDragStatus == TaskDragStatus.feedback ? 0.07 : 0.0,
        child: Consumer<HomeProvider>(
          builder: (context, homeProvider, child) {
            TaskViewModel taskViewModel = homeProvider.getTask(taskId);

            return Card(
              elevation: 3,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(ScreenValues.radiusNormal),
                ),
                splashColor: Theme.of(context).primaryColor,
                splashFactory: InkRipple.splashFactory,
                onTap: () {
                  NavigationService.push(TaskFullWidget(taskId: taskId));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(ScreenValues.paddingLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: "${HeroTag.taskTitle}${taskViewModel.id}",
                        child: Text(
                          taskViewModel.title,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Hero(
                        tag: "${HeroTag.taskDescription}${taskViewModel.id}",
                        child: Visibility(
                          visible: taskViewModel.description != null,
                          child: Text(
                            taskViewModel.description ?? "",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
