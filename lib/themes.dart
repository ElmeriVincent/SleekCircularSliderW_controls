import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

CustomTheme currentTheme = CustomTheme();

// Colors to be used
const darkBlue = Color(0xFF2C363D);
const lightBlue = Color.fromARGB(255, 0, 218, 247);
const darkerGray = Color(0xFF505E68);
const lighterGray = Color(0xFF91A8AB);
const white = Colors.white;

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = true;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
  /*

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: white,
      colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        background: white,
        primary: darkBlue,
        onPrimary: darkBlue,
        onBackground: lightBlue,
        secondary: lightBlue,
        outline: darkBlue,
      ),
      textTheme: GoogleFonts.mulishTextTheme().copyWith(
        displayLarge: const TextStyle(
          color: darkBlue,
          fontSize: 45,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: const TextStyle(
          color: gray,
          fontSize: 32,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: const TextStyle(color: darkBlue, fontSize: 48),
        bodySmall: const TextStyle(
          color: darkBlue,
          fontSize: 32,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
  */

  static ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: darkBlue,
      colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        background: darkBlue,
        primary: darkerGray,
        onPrimary: darkBlue,
        onBackground: white,
        secondary: lighterGray,
        outline: lightBlue,
      ),
      textTheme: GoogleFonts.mulishTextTheme().copyWith(
        displayLarge: const TextStyle(
          color: white,
          fontSize: 45,
          fontWeight: FontWeight.normal,
        ),
        displaySmall: const TextStyle(
          color: white,
          fontSize: 32,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: const TextStyle(
          color: darkBlue,
          fontSize: 30,
        ),
        bodySmall: const TextStyle(
          color: darkBlue,
          fontSize: 32,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
