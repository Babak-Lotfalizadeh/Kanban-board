import 'package:flutter/material.dart';
import 'package:kanban_board/providers/language_provider.dart';
import 'package:kanban_board/services/navigation_service.dart';
import 'package:kanban_board/utilities/imports.dart';
import 'package:kanban_board/widgets/setting/setting_item_card.dart';
import 'package:provider/provider.dart';

class BottomSheetChangeLanguage extends StatelessWidget {
  const BottomSheetChangeLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var strings = AppLocalizations.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SettingItemCard(
          title: strings?.english ?? "",
          iconData: Icons.translate_outlined,
          onClick: () {
            context.read<LanguageProvider>().setEnglishLanguage();
            NavigationService.pop();
          },
        ),
        SettingItemCard(
          title: strings?.persian ?? "",
          iconData: Icons.translate_outlined,
          onClick: () {
            context.read<LanguageProvider>().setPersianLanguage();
            NavigationService.pop();
          },
        ),
      ],
    );
  }
}
