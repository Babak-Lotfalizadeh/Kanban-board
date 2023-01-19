import 'package:flutter/material.dart';
import 'package:kanban_board/constants/screen_values.dart';
import 'package:kanban_board/screens/home_screen.dart';
import 'package:kanban_board/screens/login_screen.dart';
import 'package:kanban_board/services/navigation_service.dart';
import 'package:kanban_board/firebase/firebase_authentication_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _handleUser();
    });
  }

  void _handleUser() {
    var currentUser = FirebaseAuthenticationService().currentUser;
    Widget destination = const LoginScreen();
    if (currentUser != null) {
      destination = const HomeScreen();
    }
    NavigationService.pushAndReplace(destination);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: ScreenValues.iconNormal,
          width: ScreenValues.iconNormal,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
