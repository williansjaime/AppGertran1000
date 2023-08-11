import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apptestewillians/models/Solicitacao.dart';

Future<List<ModelSM>> fetchModelSM(final String cnpj) async {
  Uri uri = Uri(
      scheme: 'https',
      port: 5000,
      host: '192.168.34.7',
      path: '/listasm/$cnpj');

  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  try {
        http.Response response = await http.get(uri, headers: headers).timeout(
            const Duration(seconds: 40),
            onTimeout: () {
              // Time has run out, do what you wanted to do.
              return http.Response('Error', 408); // Request Timeout response status code
            },
        );
    if (response.statusCode == 200) {
      
      return List<ModelSM>.from(
        json.decode(response.body)
        .map((data) => ModelSM.fromJson(data))
        );
       //ModelSM.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  } catch (e) {
    return throw Exception(e);
  }
}

/*enum statusViagem
{
  AGUARDANDO,
  EMVIAGEM,
  REPROVADO,
  CANCELADO,
  EMAVALIACAO,
  ,
  7,
  8,
  9
}*/

class APIIntegrationState {  
  //late Future<Album> futureAlbum;
  late Future<List<ModelSM>> futureSM;
  late List <Future<ModelSM>> futureList = [];
  
  
  Future APIReturn() {
    //futureAlbum = fetchAlbum();
    futureSM = fetchModelSM('16849231000104');
    return futureSM;
  }
}
