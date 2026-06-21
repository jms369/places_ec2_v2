import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

String getBaseUrl() {
  const String prodUrl = "https://places.universoweb.win"; // tu subdominio en AWS

  if (kIsWeb) {
    return "http://localhost:3000"; // Web en local
  } else if (Platform.isAndroid) {
    return "http://10.0.2.2:3000"; // Emulador Android
  } else if (Platform.isIOS) {
    return "http://localhost:3000"; // iOS local
  } else {
    // Detecta si está en modo producción (release)
    bool isProduction = const bool.fromEnvironment('dart.vm.product');
    return isProduction ? prodUrl : "http://192.168.1.8:3000"; // IP local de tu PC
  }
}

