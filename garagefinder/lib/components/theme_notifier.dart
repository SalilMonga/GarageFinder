import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
  }

  // Updated Light Theme Colors
  static const Color primaryLightColor =
      Color.fromARGB(255, 142, 176, 243); // Soft pastel blue
  static const Color secondaryLightColor =
      Color(0xFF003366); // Contrast dark blue
  static const Color lightTextColor = Colors.black87; // Dark text for contrast
  static const Color lightCardColor = Colors.white; // Bright white for cards
  static const Color lightBackgroundColor =
      Color(0xFFF4F9FC); // Soft light background
  static const Color lightShadowColor =
      Colors.black; // Shadow color for light theme
  static const Color lightUnselectedItemColor =
      Colors.grey; // Unselected item color for light theme

  // Updated Dark Theme Colors
  static const Color primaryDarkColor = Color(0xFF004B8D); // Rich dark blue
  static const Color secondaryDarkColor = Color(0xFF001F3F); // Very dark blue
  static const Color darkTextColor = Colors.white; // White for text
  static const Color darkCardColor = Color(0xFF1A1A1A); // Slightly lighter dark
  static const Color darkBackgroundColor =
      Color(0xFF121212); // Deep dark background
  static const Color darkShadowColor =
      Colors.black; // Shadow color for dark theme
  static const Color darkUnselectedItemColor =
      Colors.grey; // Unselected item color for dark theme

  // Light Theme
  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: primaryLightColor,
          surface: lightCardColor,
          onPrimary: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryLightColor,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: lightBackgroundColor,
          selectedItemColor: primaryLightColor,
          unselectedItemColor: lightUnselectedItemColor,
        ),
        cardTheme: const CardTheme(
          color: lightCardColor,
          shadowColor: lightShadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 20, color: lightTextColor, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16, color: lightTextColor),
          bodyMedium: TextStyle(fontSize: 14, color: lightUnselectedItemColor),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryLightColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
      );

  // Dark Theme
  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: primaryDarkColor,
          surface: darkCardColor,
          onPrimary: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryDarkColor,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: darkBackgroundColor,
          selectedItemColor: primaryDarkColor,
          unselectedItemColor: darkUnselectedItemColor,
        ),
        cardTheme: const CardTheme(
          color: darkCardColor,
          shadowColor: darkShadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 20, color: darkTextColor, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16, color: darkTextColor),
          bodyMedium: TextStyle(fontSize: 14, color: darkUnselectedItemColor),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryDarkColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
      );
}
