import 'package:flutter/material.dart';
import 'package:kanban_board/constants/screen_values.dart';

class AuthenticationContentWidget extends StatelessWidget {
  final String? title;
  final GlobalKey<FormState> formKey;
  final List<Widget> contents;
  final Widget footer;

  const AuthenticationContentWidget({
    required this.title,
    required this.formKey,
    required this.contents,
    required this.footer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title ?? "",
          style: Theme.of(context).textTheme.headline1?.copyWith(
            color: Colors.black45,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: ScreenValues.paddingLarge),
        Card(
          margin: const EdgeInsets.all(ScreenValues.paddingLarge),
          child: Padding(
            padding: const EdgeInsets.all(ScreenValues.paddingLarge),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children:  contents,
              ),
            ),
          ),
        ),
        const SizedBox(height: ScreenValues.paddingLarge),
        footer,
      ],
    );
  }
}
