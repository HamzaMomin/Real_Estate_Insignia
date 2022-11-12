import 'package:flutter/material.dart';
import 'package:fyp/screen/web_screen.dart';
import 'package:fyp/ui/splash_screen.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.minWidth > 600) {
          return WebMainScreen();
        } else {
          return Splash();
        }
      },
    );
  }
}