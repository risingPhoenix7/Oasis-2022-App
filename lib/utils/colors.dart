import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OasisColors {
  static const Color backgroundColorWhite = Colors.black;
  static const Color primaryYellow = Colors.yellow;
  static const Color shadowColorAppBar = Color.fromRGBO(0, 42, 104, 0.1);
  static const Color blackButtonColor = Color(0XFF292929);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const LinearGradient lightBlackgradient =
      LinearGradient(colors: [Color(0xFF1F1F1F), Color(0xFF333333)]);
  static const LinearGradient verticalBlackgradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [Color(0xFF2D2D2D), Color(0xFF000000)]);
  static const LinearGradient darkBlackgradient = LinearGradient(colors: [
    Color.fromRGBO(0, 0, 0, 1),
    Color.fromRGBO(44, 44, 44, 1),
  ]);
}

// to use write BosmColors.backgroundColorWhite
