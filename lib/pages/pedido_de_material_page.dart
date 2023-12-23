import 'package:flutter/material.dart';

class PedidoDeMaterialPage extends StatelessWidget {
  const PedidoDeMaterialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Producao'),
      ),
      body: Center(
        child: Text(
          'Добро пожаловать на страницу Producao!',
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
