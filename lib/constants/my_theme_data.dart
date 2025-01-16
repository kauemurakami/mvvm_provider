import 'package:flutter/material.dart';

class MyThemeData {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    cardColor: Colors.white30,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white, foregroundColor: Colors.black, elevation: 1),
    colorScheme: const ColorScheme.light(
      surface: Color.fromARGB(26, 13, 184, 247),
    ),
  );
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    cardColor: Colors.white70,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade800,
      foregroundColor: Colors.white,
      elevation: 1,
    ),
    colorScheme: const ColorScheme.dark(
      surface: Colors.black26,

      // primary: Colors.teal,
    ),
  );
}
