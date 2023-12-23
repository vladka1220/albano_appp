import 'package:albano_app/customs/animated_logo.dart';
import 'package:flutter/material.dart';

import 'customs/credentials.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  void login() {
    String username = usernameController.text;
    String password = passwordController.text;

    if (credentials.containsKey(username) &&
        credentials[username] == password) {
      Navigator.pushReplacementNamed(context, '/start');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('O nome ou pin está incorreto')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Autorização')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AnimatedLogo(
                imagePath: 'assets/images/logo2_V1.png', // Путь к логотипу
                width: 300,
                height: 250,
              ),
              const SizedBox(height: 30),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Прямоугольная граница
                  labelText: 'Nome',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: !passwordVisible, // Скрытие пароля
                decoration: InputDecoration(
                  border: const OutlineInputBorder(), // Прямоугольная граница
                  labelText: 'Pin',
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: togglePasswordVisibility,
                  ),
                ),
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: login,
                child: const Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
