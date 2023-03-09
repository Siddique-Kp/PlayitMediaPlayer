import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeDataClass {
  static ThemeData lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        color: Colors.black,
        foregroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
        ),
      ),
      backgroundColor: Colors.white);
  static ThemeData darkTheme = ThemeData(
    backgroundColor: ThemeData.dark().backgroundColor,
  );
}
