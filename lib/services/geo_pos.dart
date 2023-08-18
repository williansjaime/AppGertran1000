import 'dart:io';

import 'package:geolocator/geolocator.dart';

class GeoPos {
  static Future<dynamic> retornaPosicao() async {
    if (Platform.isAndroid || Platform.isIOS) {
      await Geolocator.requestPermission();

      return await Geolocator.getCurrentPosition().then((value) => value);
    }
  }
}