import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

String getBaseUrl() {
  if (kIsWeb) {
    return "http://localhost:3000"; // Web usa localhost
  } else if (Platform.isAndroid) {
    return "http://10.0.2.2:3000"; // Emulador Android usa 10.0.2.2
  } else {
    return "http://192.168.1.8:3000"; // Celular físico usa IP local de tu PC
  }
}
