import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kanban_board/firebase/firebase_authentication_service.dart';

class LoginProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void removeAllFocuses() {
    userNameFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }

  Future<void> login({
    void Function()? whenSuccess,
    void Function(String)? whenError,
  }) async {
    removeAllFocuses();
    (await FirebaseAuthenticationService().signInWithEmailAndPassword(
      emailAddress: userNameController.text,
      password: passwordController.text,
    ))
        .fold(
      whenSuccess: (newValue) {
        whenSuccess?.call();
      },
      whenError: (newValue) {
        whenError?.call(newValue);
      },
    );
  }
}
