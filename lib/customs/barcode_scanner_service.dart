import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeScannerService {
  static Future<String?> scanBarcode() async {
    try {
      final barcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', // Цвет линии сканера
        'Cancel', // Текст кнопки отмены
        true, // Использовать фонарик
        ScanMode.BARCODE, // Режим сканирования
      );

      if (barcode == '-1') {
        return null; // Сканирование отменено
      }
      return barcode;
    } catch (e) {
      // Обработка ошибок сканирования
      return null;
    }
  }
}
