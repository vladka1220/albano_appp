import 'package:albano_app/customs/theme.dart';
import 'package:flutter/material.dart';

import '../start_page.dart'; // Путь к вашей стартовой странице
import 'auth/auth_page.dart'; // Путь к вашей странице авторизации

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Albano Alves',
      theme: AppTheme.lightTheme,
      // Настройки темы вашего приложения

      initialRoute:
          '/auth', // Устанавливаем начальный маршрут на страницу авторизации
      routes: {
        '/auth': (context) =>
            const AuthPage(), // Маршрут к странице авторизации
        '/start': (context) =>
            const MyHomePage(), // Маршрут к стартовой странице
      },
    );
  }
}
