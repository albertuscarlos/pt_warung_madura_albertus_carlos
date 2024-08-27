import 'package:flutter/material.dart';
import 'package:pt_warung_madura_albertus_carlos/config/style.dart';

class CustomThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Style.backgroundColor,
    scaffoldBackgroundColor: Style.backgroundColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        fixedSize: const WidgetStatePropertyAll(
          Size(double.infinity, 50),
        ),
        backgroundColor: const WidgetStatePropertyAll<Color>(
          Style.btnColor,
        ),
        textStyle: WidgetStatePropertyAll(
          Style.buttonTextStyle.copyWith(
            color: Style.secondaryColor,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: Style.backgroundColor,
    ),
  );
}
