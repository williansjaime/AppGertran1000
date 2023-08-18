import 'package:http/http.dart' as http;

class HttpReq {
  Future<void> fetchPosicion(
      final String latitude, final String longitude, final String token) async {
    String url = 'https://api.gertran.zayit.com.br/v1/drivers/mobile/position/';

    Map<String, String> data = {
      'latitude': latitude,
      'longitude': longitude,
      'token': token,
    };
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: data,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('Resposta 2: ${response.body}');
      } else {
        throw Exception('Falha para envira a posição');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
