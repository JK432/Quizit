import 'dart:math';
import 'package:flutter/material.dart';

class someColor {
  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);
}

class Palette {
  static const Color hardprimary = Color(0xe4d76303);
  static const Color container = Color(0xffee9a3c);
  static const Color sucess = Color(0xff00fac8);
  static const Color failure = Color(0xfae34c4c);
  static const Color basic = Color(0xff155263);
  static const Color darkbasic = Color(0xff293f49);
  static const Color lightbasic = Color(0xff7093a1);
  static const Color secondary = Color(0xffe79059);
  static const Color options = Color(0xffb38066);
  static const Color button = Color(0xf8f59b14);
  static const Color whitetext = Color(0xf8ffffff);
  static const Color sub = Color(0xcd000000);
  static const Color containertext = Color(0xffee9a3c);

}
