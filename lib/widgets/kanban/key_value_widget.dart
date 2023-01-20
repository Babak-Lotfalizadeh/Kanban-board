import 'package:flutter/material.dart';
import 'package:kanban_board/constants/screen_values.dart';

class KeyValueWidget extends StatelessWidget {
  final String? keyTitle;
  final String? valueTitle;
  final Widget? valueWidget;

  const KeyValueWidget({
    required this.keyTitle,
    this.valueTitle,
    this.valueWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(ScreenValues.paddingNormal),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: Text(keyTitle ?? "")),
          Expanded(
            child: valueWidget ?? Text(
              valueTitle ?? "",
            ),
          ),
        ],
      ),
    );
  }
}
