import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

String getBaseUrl() {
  const String prodUrl = "http://places.universoweb.win/api"; // dominio en producción antes estaba sin /api

  if (kIsWeb) {
    // Si es Web, usa el dominio en producción cuando compilas con flutter build web
    // y localhost cuando corres en modo desarrollo con flutter run
    bool isProduction = const bool.fromEnvironment('dart.vm.product');
    return isProduction ? prodUrl : "http://localhost:3000";
  } else if (Platform.isAndroid) {
    // Emulador Android
    return "http://10.0.2.2:3000";
  } else if (Platform.isIOS) {
    // iOS local
    return "http://localhost:3000";
  } else {
    // Otros entornos: distingue entre producción y desarrollo
    bool isProduction = const bool.fromEnvironment('dart.vm.product');
    return isProduction ? prodUrl : "http://192.168.1.8:3000"; // IP local de tu PC
  }
}



/*import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

String getBaseUrl() {
  const String prodUrl = "http://places.universoweb.win"; // tu subdominio en AWS

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
}  */

