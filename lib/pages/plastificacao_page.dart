import 'package:flutter/material.dart';

class PlastificacaoPage extends StatefulWidget {
  const PlastificacaoPage({super.key});

  @override
  _PlastificacaoPageState createState() => _PlastificacaoPageState();
}

class _PlastificacaoPageState extends State<PlastificacaoPage> {
  final _formKey = GlobalKey<FormState>();

  // Контроллеры для полей ввода
  final TextEditingController refController = TextEditingController();
  final TextEditingController loteController = TextEditingController();
  final TextEditingController quantidadeController = TextEditingController();
  final TextEditingController observacoesController = TextEditingController();

  late String observacoes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plastificacao'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 70), // Отступ между полями
              _buildNumericFormField('Ref', refController),
              const SizedBox(height: 20), // Отступ между полями
              _buildNumericFormField('Lote', loteController),
              const SizedBox(height: 20), // Отступ между полями
              _buildNumericFormField('Quantidade', quantidadeController),
              const SizedBox(height: 20), // Отступ между полями
              _buildTextFormField('Observacoes', observacoesController),
              const SizedBox(height: 40), // Отступ между полями
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Отправить'),
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
      keyboardType: TextInputType.number, //input inly numbers on keyboard
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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Извлекаем данные из контроллеров
      // ignore: unused_local_variable
      final int ref = int.parse(refController.text);
      // ignore: unused_local_variable
      final int lote = int.parse(loteController.text);
      // ignore: unused_local_variable
      final int quantidade = int.parse(quantidadeController.text);
      observacoes = observacoesController.text;

      // Отправка данных на сервер
      // sendDataToServer(ref, lote, quantidade, observacoes);
    }
  }

  // Пример функции для отправки данных на сервер (закомментировано)
  /*
  void sendDataToServer() async {
    // Здесь код для отправки данных на сервер, например, через http.post
  }
  */
}
