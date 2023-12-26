import 'package:flutter/material.dart';

import 'barcode_scanner_service.dart';

class NumeroDaBobineWidget extends StatefulWidget {
  const NumeroDaBobineWidget({super.key});

  @override
  _NumeroDaBobineWidgetState createState() => _NumeroDaBobineWidgetState();
}

class _NumeroDaBobineWidgetState extends State<NumeroDaBobineWidget> {
  final TextEditingController numeroDaBobineController =
      TextEditingController();
  List<String> numerosDaBobine = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: numeroDaBobineController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Numero da bobine',
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: () async {
                final barcode = await BarcodeScannerService.scanBarcode();
                if (barcode != null) {
                  _addNumeroDaBobine(barcode);
                }
              },
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => _addNumeroDaBobine(numeroDaBobineController.text),
          child: const Text('Добавить'),
        ),
        ...numerosDaBobine.map((numero) => Text(numero)),
      ],
    );
  }

  void _addNumeroDaBobine(String numero) {
    if (numero.isNotEmpty) {
      setState(() {
        numerosDaBobine.add(numero);
        numeroDaBobineController.clear();
      });
    }
  }
}
