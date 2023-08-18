import 'dart:io';

import 'package:geolocator/geolocator.dart';

class GeoPos {
  // static Future<dynamic> retornaPosicao() async {
  //   if (Platform.isAndroid || Platform.isIOS) {
  //     return await Geolocator.getCurrentPosition().then((value) => value);
  //   }
  // }


    static Future<void> autorizaLocalizacao() async {
    if (Platform.isAndroid || Platform.isIOS) {
      await Geolocator.requestPermission();
    }
  }


}