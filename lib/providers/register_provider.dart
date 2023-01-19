import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kanban_board/firebase/firebase_authentication_service.dart';

class RegisterProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmFocusNode = FocusNode();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  void removeAllFocuses() {
    userNameFocusNode.unfocus();
    passwordFocusNode.unfocus();
    confirmFocusNode.unfocus();
  }

  Future<void> register({
    void Function()? whenSuccess,
    void Function(String)? whenError,
  }) async {
    removeAllFocuses();
    (await FirebaseAuthenticationService().createUserWithEmailAndPassword(
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
