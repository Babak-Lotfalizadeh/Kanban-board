import 'package:flutter/material.dart';
import 'package:kanban_board/providers/language_provider.dart';
import 'package:kanban_board/providers/theme_provider.dart';
import 'package:kanban_board/screens/setting_screen.dart';
import 'package:kanban_board/services/navigation_service.dart';
import 'package:kanban_board/utilities/imports.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kanban Board App',
      onGenerateTitle: (context) => AppLocalizations.of(context)?.appName ?? "",
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: context.watch<LanguageProvider>().locale,
      theme: context.watch<ThemeProvider>().themeData,
      darkTheme: context.watch<ThemeProvider>().darkThemeData,
      themeMode: context.watch<ThemeProvider>().themeMode,
      navigatorKey: NavigationService.navigatorKey,
      home: const SettingScreen(),
    );
  }
}