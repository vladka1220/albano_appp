import 'package:flutter/material.dart';

import 'pages/pedido_de_material_page.dart';
import 'pages/plano_de_trabalho_page.dart';
import 'pages/plastificacao_page.dart';
import 'pages/producao_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Главная страница'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _showMenu(context),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Привет, мир!',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontFamily: Theme.of(context).textTheme.titleLarge?.fontFamily,
          ),
        ),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.production_quantity_limits),
              title: const Text('Producao'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ProducaoPage())),
            ),
            ListTile(
              leading: const Icon(Icons.layers),
              title: const Text('Plastificacao'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PlastificacaoPage())),
            ),
            ListTile(
              leading: const Icon(Icons.work),
              title: const Text('Plano de trabalho'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PlanoDeTrabalhoPage())),
            ),
            ListTile(
              leading: const Icon(Icons.request_page),
              title: const Text('Pedido de material'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PedidoDeMaterialPage())),
            ),
          ],
        );
      },
    );
  }
}
