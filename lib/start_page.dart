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
        title: const Text('Home Page'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _showMenu(context),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.15), // Отступ для AppBar
          Center(
            child: Image.asset(
              'assets/images/logo.png', // Убедитесь, что путь к логотипу верный
              height: 90, // Высота логотипа
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: <Widget>[
                _buildCard(context, 'Producao',
                    Icons.production_quantity_limits, const ProducaoPage()),
                _buildCard(context, 'Plastificacao', Icons.layers,
                    const PlastificacaoPage()),
                _buildCard(context, 'Plano de trabalho', Icons.work,
                    const PlanoDeTrabalhoPage()),
                _buildCard(context, 'Pedido de material', Icons.request_page,
                    const PedidoDeMaterialPage()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
      BuildContext context, String title, IconData icon, Widget page) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => page)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 80),
            Text(title),
          ],
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
              title: const Text('Test_Producao'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ProducaoPage())),
            ),
            ListTile(
              leading: const Icon(Icons.layers),
              title: const Text('Test_Plastificacao'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PlastificacaoPage())),
            ),
            ListTile(
              leading: const Icon(Icons.work),
              title: const Text('Test_Plano de trabalho'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PlanoDeTrabalhoPage())),
            ),
            ListTile(
              leading: const Icon(Icons.request_page),
              title: const Text('Test_Pedido de material'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PedidoDeMaterialPage())),
            ),
          ],
        );
      },
    );
  }
}
