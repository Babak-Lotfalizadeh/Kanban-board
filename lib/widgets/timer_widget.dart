import 'package:flutter/material.dart';
import 'package:kanban_board/providers/timer_provider.dart';
import 'package:kanban_board/utilities/imports.dart';
import 'package:kanban_board/utilities/utility.dart';
import 'package:provider/provider.dart';

class TimerWidget extends StatelessWidget {
  final Duration? Function() onTick;

  const TimerWidget({
    required this.onTick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var strings = AppLocalizations.of(context);

    return ChangeNotifierProvider(
      create: (context) => TimerProvider()..init(),
      child: Consumer<TimerProvider>(
        builder: (context, timerProvider, child) => Text(
          onTick.call().toShowFormat(strings?.unKnown),
        ),
      ),
    );
  }
}
