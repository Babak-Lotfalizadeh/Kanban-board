import 'package:flutter/material.dart';
import 'package:kanban_board/my_app.dart';
import 'package:kanban_board/providers/language_provider.dart';
import 'package:kanban_board/providers/theme_provider.dart';
import 'package:kanban_board/services/navigation_service.dart';
import 'package:provider/provider.dart';

void main() {
  NavigationService();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()..init()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()..init()),
      ],
      child: const MyApp(),
    ),
  );
}
