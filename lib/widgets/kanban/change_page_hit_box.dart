import 'package:flutter/material.dart';

class ChangePageHitBox extends StatelessWidget {
  const ChangePageHitBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: 100,
    );
  }
}
