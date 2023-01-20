import 'package:flutter/material.dart';
import 'package:kanban_board/constants/screen_values.dart';
import 'package:kanban_board/firebase/firebase_authentication_service.dart';
import 'package:kanban_board/providers/theme_provider.dart';
import 'package:kanban_board/screens/setting_screen.dart';
import 'package:kanban_board/services/navigation_service.dart';
import 'package:kanban_board/utilities/imports.dart';
import 'package:kanban_board/widgets/dark_light_switch_widget.dart';
import 'package:kanban_board/widgets/user_image_widget.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var strings = AppLocalizations.of(context);
    var user = FirebaseAuthenticationService().currentUser;

    return Drawer(
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) => ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              margin: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserImageWidget(
                          userImageAddress: user?.photoURL ?? "",
                          size: ScreenValues.smallImageSize,
                        ),
                        const Spacer(),
                        const DarkLightSwitchWidget(),
                      ],
                    ),
                  ),
                  const SizedBox(height: ScreenValues.paddingNormal),
                  Text(user?.email ?? ""),
                ],
              ),
            ),
            ListTile(
              title: Text(strings?.setting ?? ""),
              leading: const Icon(Icons.settings_outlined),
              onTap: () => NavigationService.push(const SettingScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
