import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../customs/barcode_scanner_service.dart';

class ProducaoPage extends StatefulWidget {
  const ProducaoPage({super.key});

  @override
  _ProducaoPageState createState() => _ProducaoPageState();
}

class _ProducaoPageState extends State<ProducaoPage> {
  final _formKey = GlobalKey<FormState>();

// Контроллеры для полей ввода
  final TextEditingController refController = TextEditingController();
  final TextEditingController loteController = TextEditingController();
  final TextEditingController numeroDaBobineController =
      TextEditingController();
  final TextEditingController quantidadeController = TextEditingController();
  final TextEditingController observacoesController = TextEditingController();

  late String observacoes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
              const SizedBox(height: 40), // Отступ после заголовка
              _buildNumericFormField('Ref', refController),
              const SizedBox(height: 20), // Отступ между полями
              _buildNumericFormField('Lote', loteController),

              const SizedBox(height: 20), // Отступ между полями
              TextFormField(
                controller: numeroDaBobineController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Numero da bobine',
                  border:
                      const OutlineInputBorder(), // Здесь устанавливается прямоугольная граница
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () async {
                      final barcode = await BarcodeScannerService.scanBarcode();
                      if (barcode != null) {
                        setState(() {
                          numeroDaBobineController.text = barcode;
                        });
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20), // Отступ после поля сканирования
              _buildNumericFormField('Quantidade', quantidadeController),
              const SizedBox(height: 20), // Отступ между полями
              _buildTextFormField('Observacoes', observacoesController),
              const SizedBox(height: 40), // Отступ перед кнопкой
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

  // Сканирование с камеры
  Widget _buildBarcodeFormField(
      String label, TextEditingController controller) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: label,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.camera_alt),
          onPressed: scanBarcode,
        ),
      ],
    );
  }

  Future<void> scanBarcode() async {
    final barcode = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666', // Цвет линии сканера
      'Cancel', // Текст кнопки отмены
      true, // Использовать фонарик
      ScanMode.BARCODE, // Режим сканирования
    );

    if (barcode != '-1') {
      setState(() {
        numeroDaBobineController.text = barcode;
      });
    }
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
      final int numeroDaBobine = int.parse(numeroDaBobineController.text);
      // ignore: unused_local_variable
      final int quantidade = int.parse(quantidadeController.text);
      observacoes = observacoesController.text;

      // Отправка данных на сервер
      // sendDataToServer(ref, lote, numeroDaBobine, quantidade, observacoes);
    }
  }

  // Пример функции для отправки данных на сервер (закомментировано)
  /*
  void sendDataToServer() async {
    // Здесь код для отправки данных на сервер, например, через http.post
  }
  */
}
