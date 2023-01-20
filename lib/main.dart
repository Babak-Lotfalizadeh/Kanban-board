import 'package:flutter/material.dart';
import 'package:kanban_board/firebase/firebase_core_service.dart';
import 'package:kanban_board/my_app.dart';
import 'package:kanban_board/providers/home_provider.dart';
import 'package:kanban_board/providers/language_provider.dart';
import 'package:kanban_board/providers/theme_provider.dart';
import 'package:kanban_board/services/navigation_service.dart';
import 'package:provider/provider.dart';

void main() async {
  NavigationService();
  await FirebaseCoreService().init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()..init()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()..init()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
