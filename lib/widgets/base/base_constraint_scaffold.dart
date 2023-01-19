import 'package:flutter/material.dart';
import 'package:kanban_board/constants/screen_values.dart';
import 'package:kanban_board/widgets/app_bar_widget.dart';

class BaseConstraintScaffold extends StatelessWidget {
  final String? title;
  final Widget? body;

  const BaseConstraintScaffold({
    this.title,
    required this.body,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title == null ? null : AppBarWidget(
        title: title,
      ),
      body: Center(
        child: Container(
          constraints: ScreenValues.mobileConstraints,
          child: body,
        ),
      ),
    );
  }
}
