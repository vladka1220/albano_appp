import 'dart:convert'; // Для работы с JSON

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'barcode_scanner_service.dart';

class BobinaDetailsPage extends StatefulWidget {
  const BobinaDetailsPage({super.key});

  @override
  _BobinaDetailsPageState createState() => _BobinaDetailsPageState();
}

class BobinaData {
  String numero;
  String largura;
  String peso;
  String metros;
  String gramatura;
  String marca;
  String tipo;

  BobinaData({
    required this.numero,
    required this.largura,
    required this.peso,
    required this.metros,
    required this.gramatura,
    required this.marca,
    required this.tipo,
  });

  // Преобразование экземпляра класса в Map для последующего преобразования в JSON
  Map<String, dynamic> toJson() {
    return {
      'numero': numero,
      'largura': largura,
      'peso': peso,
      'metros': metros,
      'gramatura': gramatura,
      'marca': marca,
      'tipo': tipo,
    };
  }

  // Фабричный конструктор для создания экземпляра класса из Map (полученного из JSON)
  factory BobinaData.fromJson(Map<String, dynamic> json) {
    return BobinaData(
      numero: json['numero'],
      largura: json['largura'],
      peso: json['peso'],
      metros: json['metros'],
      gramatura: json['gramatura'],
      marca: json['marca'],
      tipo: json['tipo'],
    );
  }
}

class _BobinaDetailsPageState extends State<BobinaDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController larguraController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController metrosController = TextEditingController();
  final TextEditingController gramaturaController = TextEditingController();
  final TextEditingController marcaController = TextEditingController();
  final TextEditingController tipoController = TextEditingController();

  // Инициализация списка данных о бобинах
  List<BobinaData> bobinasData = [];

  @override
  void initState() {
    super.initState();
    loadBobinasData();
  }

  Future<void> saveBobinasData() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bobinasJson =
        bobinasData.map((data) => jsonEncode(data.toJson())).toList();
    await prefs.setString('bobinas_data', jsonEncode(bobinasJson));

    // Возвращаемся на предыдущий экран
    Navigator.pop(context);
  }

  Future<void> loadBobinasData() async {
    final prefs = await SharedPreferences.getInstance();
    String? bobinasJsonString = prefs.getString('bobinas_data');
    if (bobinasJsonString != null) {
      List<dynamic> bobinasJson = jsonDecode(bobinasJsonString) as List;
      setState(() {
        bobinasData = bobinasJson
            .map((json) => BobinaData.fromJson(jsonDecode(json)))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали Бобины'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildTextFieldWithScan('Номер', numeroController),
              _buildNumericFormField('Ширина', larguraController),
              _buildNumericFormField('Вес', pesoController),
              _buildNumericFormField('Метры', metrosController),
              _buildDropdownField('Марка', marcas, selectedMarca, (newValue) {
                setState(() {
                  selectedMarca = newValue;
                });
              }),
              _buildDropdownField('Граммаж', gramaturas, selectedGramatura,
                  (newValue) {
                setState(() {
                  selectedGramatura = newValue;
                });
              }),
              _buildDropdownField('Тип', tipos, selectedTipo, (newValue) {
                setState(() {
                  selectedTipo = newValue;
                });
              }),
              // Добавить поля для марки, граммажа и типа
              // ...
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print("Кнопка 'Подтвердить' нажата");
                  if (_formKey.currentState!.validate()) {
                    saveBobinasData();
                    // Дополнительные действия после сохранения
                  }
                },
                child: const Text('Подтвердить'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldWithScan(
      String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number, // Только цифровой ввод
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: const Icon(Icons.camera_alt),
          onPressed: () async {
            final barcode = await BarcodeScannerService.scanBarcode();
            if (barcode != null && barcode != '-1') {
              setState(() {
                controller.text = barcode;
              });
            }
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty || int.tryParse(value) == null) {
          return 'Введите целое число';
        }
        return null;
      },
    );
  }

  Widget _buildNumericFormField(
      String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty || int.tryParse(value) == null) {
          return 'Введите целое число';
        }
        return null;
      },
    );
  }

  // Виджеты для выпадающих списков и других элементов управления будут добавлены здесь
  List<String> marcas = ['Marca 1', 'Marca 2', 'Marca 3']; // Примеры марок
  List<String> gramaturas = ['80g', '100g', '120g']; // Примеры граммажей
  List<String> tipos = ['Термо', 'Нормаль']; // Примеры типов

  String? selectedMarca;
  String? selectedGramatura;
  String? selectedTipo;

  Widget _buildDropdownField(String label, List<String> items,
      String? selectedValue, void Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  // Методы для обработки данных и отправки на сервер
  // ...
}
