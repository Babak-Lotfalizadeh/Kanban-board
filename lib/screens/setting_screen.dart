import 'package:flutter/material.dart';
import 'package:kanban_board/utilities/imports.dart';
import 'package:kanban_board/widgets/base/base_constraint_scaffold.dart';
import 'package:kanban_board/widgets/setting/setting_content_widget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseConstraintScaffold(
      title: AppLocalizations.of(context)?.setting,
      body: const SettingContentWidget(),
    );
  }
}
