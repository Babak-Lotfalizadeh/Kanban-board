import 'package:flutter/material.dart';
import 'package:kanban_board/constants/screen_values.dart';
import 'package:kanban_board/enums/hero_tag.dart';
import 'package:kanban_board/enums/kanban_enum.dart';
import 'package:kanban_board/providers/home_provider.dart';
import 'package:kanban_board/providers/task_provider.dart';
import 'package:kanban_board/services/navigation_service.dart';
import 'package:kanban_board/utilities/imports.dart';
import 'package:kanban_board/view_model/kanban_view_model.dart';
import 'package:kanban_board/view_model/task_view_model.dart';
import 'package:kanban_board/widgets/app_bar_widget.dart';
import 'package:kanban_board/widgets/text_button_widget.dart';
import 'package:provider/provider.dart';

class TaskFullWidget extends StatelessWidget {
  final String taskId;

  const TaskFullWidget({
    required this.taskId,
    Key? key,
  }) : super(key: key);

  void _closePage() {
    NavigationService.pop();
  }

  @override
  Widget build(BuildContext context) {
    var strings = AppLocalizations.of(context);

    String? getTitle(KanbanViewModel kanbanViewModel) {
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
      create: (context) => TaskProvider(),
      child: Scaffold(
        appBar: AppBarWidget(title: strings?.taskDetails),
        body: Consumer2<HomeProvider, TaskProvider>(
          builder: (context, homeProvider, taskProvider, child) {
            TaskViewModel taskViewModel = homeProvider.getTask(taskId);
            return Padding(
              padding: const EdgeInsets.all(ScreenValues.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTitle(homeProvider.getTaskParent(taskId)) ?? "",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: ScreenValues.paddingLarge),
                  Visibility(
                    visible: !taskProvider.editModeTitle,
                    child: InkWell(
                      onTap: taskProvider.showTitleEditMode,
                      child: Hero(
                        tag: "${HeroTag.taskTitle}${taskViewModel.id}",
                        child: Text(
                          "title: ${taskViewModel.title}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: taskProvider.editModeTitle,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextFormField(
                          maxLines: 1,
                          controller: taskProvider.titleController(
                            taskViewModel.title,
                          ),
                        ),
                        TextButtonWidget(
                          onTap: () => taskProvider.saveTitle(
                            homeProvider,
                            taskViewModel,
                          ),
                          title: strings?.save ?? "",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: ScreenValues.paddingNormal),
                  InkWell(
                    onTap: taskProvider.showDescriptionEditMode,
                    child: Hero(
                      tag: "${HeroTag.taskDescription}${taskViewModel.id}",
                      child: Visibility(
                        visible: !taskProvider.editModeDescription,
                        child: Text(
                          "description: ${taskViewModel.description ?? " "}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: taskProvider.editModeDescription,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextFormField(
                          minLines: 8,
                          maxLines: 15,
                          controller: taskProvider.descriptionController(
                            taskViewModel.description,
                          ),
                        ),
                        TextButtonWidget(
                          onTap: () => taskProvider.saveDescription(
                            homeProvider,
                            taskViewModel,
                          ),
                          title: strings?.save ?? "",
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(ScreenValues.paddingLarge),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButtonWidget(
                          onTap: _closePage,
                          title: strings?.close ?? "",
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
