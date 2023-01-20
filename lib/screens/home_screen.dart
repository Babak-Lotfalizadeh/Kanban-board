import 'package:flutter/material.dart';
import 'package:kanban_board/providers/home_provider.dart';
import 'package:kanban_board/services/alert_dialog_service.dart';
import 'package:kanban_board/utilities/imports.dart';
import 'package:kanban_board/widgets/app_bar_widget.dart';
import 'package:kanban_board/widgets/drawer_widget.dart';
import 'package:kanban_board/widgets/kanban/kanban_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _addNewItem(BuildContext context) {
    AlertDialogService.askForText(
      context: context,
      onSave: (title) {
        context.read<HomeProvider>().addNewItem(title);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var strings = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBarWidget(title: strings?.tasks ?? ""),
      drawer: const DrawerWidget(),
      body: SafeArea(
        child: Consumer<HomeProvider>(
          builder: (context, homeProvider, child) => PageView(
            controller: homeProvider.controller,
            children: homeProvider.items
                .map(
                  (element) => KanbanScreen(
                    kanbanViewModel: element,
                    onGoNextPage: homeProvider.onGoNextPage,
                    onGoBeforePage: homeProvider.onGoBeforePage,
                    onAccept: (taskViewModel, pos) => homeProvider.onAccept(
                      pos: pos,
                      kanbanViewModel: element,
                      taskViewModel: taskViewModel,
                    ),
                    onDragCompleted: (taskViewModel, pos) {
                      homeProvider.onDragCompleted(
                        pos: pos,
                        kanbanViewModel: element,
                        taskViewModel: taskViewModel,
                      );
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _addNewItem(context),
      ),
    );
  }
}
