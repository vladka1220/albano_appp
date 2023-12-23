import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../customs/animated_logo.dart';
import '../customs/credentials.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final now = DateTime.now();
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
    String formattedDateTime =
        DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(formattedDateTime),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AnimatedLogo(
                imagePath: 'assets/images/logo2_V1.png',
                width: 300,
                height: 250,
              ),
              const SizedBox(height: 30),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: !passwordVisible,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Pin',
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: togglePasswordVisibility,
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
