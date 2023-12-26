import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../customs/dados_da bobine/BobinaDetailsPage.dart';

class ProducaoPage extends StatefulWidget {
  const ProducaoPage({super.key});

  @override
  _ProducaoPageState createState() => _ProducaoPageState();
}

class _ProducaoPageState extends State<ProducaoPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController refController = TextEditingController();
  final TextEditingController loteController = TextEditingController();
  final TextEditingController quantidadeController = TextEditingController();
  final TextEditingController observacoesController = TextEditingController();
  final TextEditingController numeroDaBobineController =
      TextEditingController();

  late String observacoes;
  List<String> bobinasData = [];

  @override
  void initState() {
    super.initState();
    loadBobinasData();
  }

  Future<void> loadBobinasData() async {
    final prefs = await SharedPreferences.getInstance();
    String? bobinasJsonString = prefs.getString('bobinas_data');
    if (bobinasJsonString != null) {
      List<dynamic> bobinasJson = jsonDecode(bobinasJsonString) as List;
      setState(() {
        bobinasData = bobinasJson.map((json) => json.toString()).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Producao'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Producao',
                style: TextStyle(fontSize: 30.0),
              ),
              const SizedBox(height: 40),
              _buildNumericFormField('Ref', refController),
              const SizedBox(height: 20),
              _buildNumericFormField('Lote', loteController),
              const SizedBox(height: 20),
              TextField(
                controller: numeroDaBobineController,
                decoration: const InputDecoration(
                  labelText: 'Numero da bobine',
                  border: OutlineInputBorder(),
                ),
                readOnly: true, // Сделать поле только для чтения
              ),
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BobinaDetailsPage(),
                    ),
                  );

                  // Обновление поля номера бобины после возврата
                  if (result != null) {
                    numeroDaBobineController.text = result;
                  }
                },
                child: const Text('Добавить данные бобины'),
              ),
              _buildNumericFormField('Quantidade', quantidadeController),
              const SizedBox(height: 20),
              _buildTextFormField('Observacoes', observacoesController),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Confirmar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildNumericFormField(
      String label, TextEditingController controller) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
      validator: (value) {
        if (value == null || value.isEmpty || int.tryParse(value) == null) {
          return 'Введите целое число';
        }
        return null;
      },
    );
  }

  TextFormField _buildTextFormField(
      String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Пожалуйста, заполните это поле';
        }
        return null;
      },
    );
  }

  // Отправка данных на сервер
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // ignore: unused_local_variable
      final int ref = int.parse(refController.text);
      // ignore: unused_local_variable
      final int lote = int.parse(loteController.text);
      observacoes = observacoesController.text;

      // Отправка данных на сервер
      // sendDataToServer(ref, lote, bobinasData, quantidadeController.text, observacoes);
      // Очищаем список бобин после отправки
      setState(() {
        bobinasData.clear();
      });
    }
  }

  // Функция для отправки данных на сервер
  // void sendDataToServer(int ref, int lote, List<String> bobinas, String quantidade, String observacoes) async {...}
}
