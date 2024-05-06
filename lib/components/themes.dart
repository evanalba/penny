// In a separate file (e.g., themes.dart)

import 'package:flutter/material.dart';

const Color _primaryColor = Colors.teal; // Adjust based on your app's primary color

ThemeData lightThemeData = ThemeData(
  brightness: Brightness.light,
  primaryColor: _primaryColor, // Adjust based on your app's accent color
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black54),
    titleMedium: TextStyle(color: Colors.black54),
    titleLarge: TextStyle(color: Colors.black),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: _primaryColor,
    unselectedItemColor: Colors.black54,
  ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal).copyWith(secondary: Colors.pinkAccent),
);

ThemeData darkThemeData = ThemeData(
  brightness: Brightness.dark,
  primaryColor: _primaryColor, // Adjust based on your app's accent color
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white70),
    titleMedium: TextStyle(color: Colors.white70),
    titleLarge: TextStyle(color: Colors.white),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: _primaryColor,
    unselectedItemColor: Colors.white54,
  ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal).copyWith(secondary: Colors.tealAccent.shade700),
);
