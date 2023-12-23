import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: const Color.fromARGB(255, 105, 186, 226), // Основной цвет
    fontFamily: 'Roboto',
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: Colors.green), // Вторичный цвет
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent, // Прозрачный фон AppBar
      elevation: 0, // Убираем тень
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 190, 230, 246),
  );
}
