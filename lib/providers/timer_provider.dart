import 'dart:async';

import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {
  late Timer timer;

  void init() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
       notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
