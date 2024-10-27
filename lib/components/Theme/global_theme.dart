import 'package:flutter/material.dart';

class RestauresTheme {
  // Primary color used throughout the app for consistency
  static const Color primaryColor =
      Color(0xFF000000); // Green for success and fresh dining
  static const Color accentColor =
      Color(0xFFFF5c00); // Amber for highlighting important elements

  // Background colors for pages and cards
  static const Color backgroundColor =
      Color(0xFFFFFFFF); // Light grey for general background
  static const Color cardColor =
      Color(0xFFFFFFFF); // White for card backgrounds

  // Text colors for different text elements
  static const Color titleTextColor = Color(0xFF212121); // Dark grey for titles
  static const Color bodyTextColor =
      Color(0xFF757575); // Medium grey for body text

  // Button colors for primary actions
  static const Color buttonColor = Color(0xFFFF5c00); // Same as primary color
  static const Color buttonTextColor =
      Colors.white; // White for contrast on buttons

  // Colors for input fields and borders
  static const Color inputFillColor =
      Color(0xFFFFFFFF); // White background for input fields
  static const Color inputBorderColor =
      Color(0xFFBDBDBD); // Light grey border for inputs

  // // Dot indicators for the introduction screen
  // static const Color dotColor = Color(0xFFBDBDBD); // Inactive dot color
  // static const Color activeDotColor =
  //     Color.fromARGB(255, 0, 63, 2); // Active dot color matching primary

  // Creating a ThemeData for the app
  static ThemeData get themeData {
    return ThemeData(
      primaryColor: primaryColor,
      hintColor: accentColor,
      scaffoldBackgroundColor: backgroundColor,
      cardColor: cardColor,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            color: titleTextColor, fontSize: 28, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(color: bodyTextColor, fontSize: 19),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: buttonColor,
        textTheme: ButtonTextTheme.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: inputFillColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: inputBorderColor),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: buttonTextColor,
          backgroundColor: buttonColor,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      colorScheme: const ColorScheme(
        primary: primaryColor,
        secondary: accentColor,
        surface: cardColor,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
    );
  }
}
