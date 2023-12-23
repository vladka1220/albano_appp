import 'package:flutter/material.dart';

class ProducaoPage extends StatefulWidget {
  const ProducaoPage({super.key});

  @override
  _ProducaoPageState createState() => _ProducaoPageState();
}

class _ProducaoPageState extends State<ProducaoPage> {
  final _formKey = GlobalKey<FormState>();

  // Переменные для хранения данных формы
  late int ref;
  late int lote;
  late int numeroDaBobine;
  late int quantidade;
  late String observacoes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Producao'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildNumericFormField('Ref', (value) => ref = int.parse(value!)),
              _buildNumericFormField(
                  'Lote', (value) => lote = int.parse(value!)),
              _buildNumericFormField('Numero da bobine',
                  (value) => numeroDaBobine = int.parse(value!)),
              _buildNumericFormField(
                  'Quantidade', (value) => quantidade = int.parse(value!)),
              _buildTextFormField(
                  'Observacoes', (value) => observacoes = value!),
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

  TextFormField _buildNumericFormField(String label, Function(String?) onSave) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
      onSaved: onSave,
      validator: (value) {
        if (value == null || value.isEmpty || int.tryParse(value) == null) {
          return 'Введите целое число';
        }
        return null;
      },
    );
  }

  TextFormField _buildTextFormField(String label, Function(String?) onSave) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
      onSaved: onSave,
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
      _formKey.currentState!.save();
      // Отправка данных на сервер
      // sendDataToServer();
    }
  }

  // Пример функции для отправки данных на сервер (закомментировано)
  /*
  void sendDataToServer() async {
    // Здесь код для отправки данных на сервер, например, через http.post
  }
  */
}
