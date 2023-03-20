import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

CustomTheme currentTheme = CustomTheme();

// Colors to be used
const darkBlue = Color.fromARGB(255, 20, 28, 43);
const lightBlue = Color.fromARGB(255, 0, 218, 247);
const white = Color.fromARGB(255, 255, 255, 255);
const gray = Color.fromARGB(255, 31, 38, 51);

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = true;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: white,
      colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        background: white,
        primary: darkBlue,
        onPrimary: white,
        onBackground: white,
        secondary: lightBlue,
        onSecondary: darkBlue,
        surface: darkBlue,
        onSurface: white,
      ),
      textTheme: GoogleFonts.latoTextTheme().copyWith(
        displayLarge: const TextStyle(
          color: darkBlue,
          fontSize: 64,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: const TextStyle(color: darkBlue, fontSize: 48),
        bodySmall: const TextStyle(
            color: darkBlue, fontSize: 32, fontWeight: FontWeight.bold),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: darkBlue,
      colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        background: darkBlue,
        primary: darkBlue,
        onPrimary: white,
        onBackground: white,
        secondary: lightBlue,
        surface: darkBlue,
        onSurface: white,
      ),
      textTheme: GoogleFonts.latoTextTheme().copyWith(
          displayLarge: const TextStyle(
            color: white,
            fontSize: 64,
            fontWeight: FontWeight.normal,
          ),
          bodyMedium: const TextStyle(color: darkBlue, fontSize: 48),
          bodySmall: const TextStyle(
              color: white, fontSize: 32, fontWeight: FontWeight.w900)),
    );
  }
}
