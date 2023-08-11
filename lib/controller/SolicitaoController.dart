import 'dart:io';
import 'dart:async';
import 'dart:convert';
import '../models/Posicao.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apptestewillians/models/TravelList.dart';
import 'package:apptestewillians/models/Solicitacao.dart';


class SolicitacaoController extends StatefulWidget {
  SolicitacaoController({super.key, required this.cnpj});
  late final String cnpj;
  @override
  State<SolicitacaoController> createState() => _SolicitacaoController(cnpj: cnpj);
}


List<ModelSM> travelList = [];

Future <List<ModelSM>> fetchModelSM(final String cnpj) async {
  String ipexterno = 'gertranapi.hopto.org';
  String ipinterno =  '192.168.34.7';
  
  Uri uri = Uri(
      scheme: 'https', 
      port: 5000,
      host: Platform.isLinux? ipinterno: ipexterno,
      path: '/listasm/$cnpj');

  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };
  try 
  {
    final response = await http.get(uri, headers: headers).timeout(
          const Duration(seconds: 15),
              onTimeout: () {
                // Time has run out, do what you wanted to do.
                return http.Response('Error', 408); // Request Timeout response status code
              },);

    if(response.statusCode == 200){
      final body = json.decode(response.body);

      for(var bod in body.values){
        travelList.add(ModelSM.fromJson(bod));
        }
      return travelList;//compute(parsePhotos, response.body);
    }else{
        return travelList;  
    }
  } catch (e) {
    return throw Exception(e);
  }
}


class _SolicitacaoController extends State<SolicitacaoController> 
{
  _SolicitacaoController({required this.cnpj});
  final String cnpj;
  
  late TravelList trevel;
  late Future <List<ModelSM>> futurelist;

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
        body: buildContainer());
  }
  void initState()
  {
    futurelist = fetchModelSM(cnpj);    
  }

  buildContainer(){

  }
}