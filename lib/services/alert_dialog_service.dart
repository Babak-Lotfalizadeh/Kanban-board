import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kanban_board/services/navigation_service.dart';
import 'package:kanban_board/utilities/imports.dart';
import 'package:kanban_board/widgets/text_button_widget.dart';

class AlertDialogService {
  AlertDialogService._();

  static Future<void> askForText({
    required BuildContext context,
    required Function(String title) onSave,
  }) async {
    TextEditingController textFieldController = TextEditingController();
    var strings = AppLocalizations.of(context);
    await showCupertinoDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(strings?.createNewTask ?? ""),
          content: TextField(
            controller: textFieldController,
            decoration: InputDecoration(
              hintText: strings?.taskTitle ?? "",
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            TextButtonWidget(
              onTap: () {
                NavigationService.pop();
              },
              title: strings?.cancel ?? "",
            ),
            TextButtonWidget(
              onTap: () {
                onSave(textFieldController.text);
                NavigationService.pop();
              },
              title: strings?.create ?? "",
            ),

          ],
        );
      },
    );
  }
}
