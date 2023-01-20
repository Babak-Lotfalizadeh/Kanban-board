import 'package:flutter/material.dart';
import 'package:kanban_board/constants/screen_values.dart';
import 'package:kanban_board/utilities/imports.dart';
import 'package:kanban_board/utilities/utility.dart';
import 'package:kanban_board/view_model/task_view_model.dart';
import 'package:kanban_board/widgets/kanban/key_value_widget.dart';
import 'package:kanban_board/widgets/timer_widget.dart';

class TaskTimerWidget extends StatelessWidget {
  final TaskViewModel taskViewModel;

  const TaskTimerWidget({
    required this.taskViewModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var strings = AppLocalizations.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(ScreenValues.paddingLarge),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.timer_sharp),
                const SizedBox(width: ScreenValues.paddingSmall),
                Text(strings?.timer ?? ""),
              ],
            ),
            const SizedBox(height: ScreenValues.paddingLarge),
            KeyValueWidget(
              keyTitle: strings?.startAt,
              valueTitle: taskViewModel.startDateTime.toShowFormat(strings?.notStarted),
            ),
            KeyValueWidget(
              keyTitle: strings?.endAt,
              valueTitle: taskViewModel.endDateTime.toShowFormat(strings?.notStarted),
            ),
            KeyValueWidget(
              keyTitle: strings?.process,
              valueWidget: TimerWidget(
                onTick: () => taskViewModel.timeDiff(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
