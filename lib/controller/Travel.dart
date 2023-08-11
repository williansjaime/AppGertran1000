import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/TravelList.dart';
import '../models/Solicitacao.dart';
import '../pages/MapsDrivePoint.dart';
import '../models/Posicao.dart';
//import '../pages/HomePage.dart';
import '../models/Perifericos.dart';


List<ModelSM> travelList = [];
List<Posicao> listPosicao = [];
List<Perifericos> listPeriferico = [];

class HomeTravel extends StatefulWidget {
  const HomeTravel({super.key, required this.cnpj});
  final String cnpj;
  @override
  State<HomeTravel> createState() => _HomeTravel(cnpj: cnpj);
}

Future<List<ModelSM>> fetchModelSM(final String cnpj) async {
  String ipexterno = 'gertranapi.hopto.org';
  String ipinterno = '192.168.34.7';

  Uri uri = Uri(
      scheme: 'https',
      port: 5000,
      host: Platform.isLinux ? ipinterno : ipexterno,
      path: '/listasm/$cnpj');

  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  try {
    final response = await http.get(uri, headers: headers).timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      for (var bod in body.values) {
        if (ModelSM.fromJson(bod).PlacaCV != "" &&
            ModelSM.fromJson(bod).PlacaCV != null &&
            int.parse(ModelSM.fromJson(bod).Status) > 1 &&
            int.parse(ModelSM.fromJson(bod).Status) < 4) {
          travelList.add(ModelSM.fromJson(bod));
        }
      }
      return travelList; //compute(parsePhotos, response.body);
    } else {
      return travelList;
    }
  } catch (e) {
    //Navigator.pop(HomePage(cnpj));
    return throw Exception(e);
  }
}

Future<Posicao> fetchPosicao(final String placa) async 
{
  String ipexterno = 'gertranapi.hopto.org';
  String ipinterno = '192.168.34.7';

  Uri uri = Uri(
      scheme: 'https',
      port: 5000,
      host: Platform.isLinux ? ipinterno : ipexterno,
      path: '/posicao/$placa');

  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };
  try {
    final response = await http.get(uri, headers: headers).timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        return http.Response('Error', 408);
      },
    );

    if (response.statusCode == 200) {
      listPosicao.add(Posicao.fromJson(json.decode(response.body)));
      return Posicao.fromJson(json.decode(response.body));
    } else {
      return Posicao.fromJson(json.decode(response.body));
    }
  } catch (e) {
    return throw Exception(e);
  }
}

Future<List<Perifericos>> fetchPeriferico(final String placa) async {
  String ipexterno = 'gertranapi.hopto.org';
  String ipinterno = '192.168.34.7';

  Uri uri = Uri(
      scheme: 'https',
      port: 5000,
      host: Platform.isLinux ? ipinterno : ipexterno,
      path: '/travel/$placa');

  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };
  try {
    final response = await http.get(uri, headers: headers).timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      for (var bod in body.values) 
      {
        listPeriferico.add(Perifericos.fromJson(bod));
      }
      print(listPeriferico);
      return listPeriferico; //compute(parsePhotos, response.body);
    } else {
      return listPeriferico;
    }
  } catch (e) {
    //Navigator.pop(HomePage(cnpj));
    return throw Exception(e);
  }
}


class _HomeTravel extends State<HomeTravel> 
{
  _HomeTravel({required this.cnpj});
  
  final String cnpj;
  late TravelList trevel;
  late Future<List<ModelSM>> futurelist;
  late Future<List<ModelSM>> filterfuturelist;
  late Future<List<Perifericos>> filterFutureList;

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(body: buildContainer());
  }

  void initState() 
  {
    filterFutureList  = fetchPeriferico("RFX6E84");
    print(filterFutureList);
    futurelist = fetchModelSM(cnpj);
  }

  buildContainer() {
    return FutureBuilder<List<ModelSM>>(
      future: futurelist,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text(''),
          );
        } else if (snapshot.hasData) 
        {
          return CardLIst(modelsm: snapshot.data!);
        } else {
          return const Center(
            child: Text(''),
          );
        }
      },
    );
  }

  Future<String> getFutureDados() async =>
      await Future.delayed(Duration(seconds: 1), () {
        return 'Dados recebidos...';
      });
}

class CardLIst extends StatelessWidget {
  const CardLIst({super.key, required this.modelsm});

  final List<ModelSM> modelsm;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: modelsm.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 100,
                  color: Color.fromARGB(0, 237, 227, 227),
                  child: Row(
                    children: <Widget>[
                      Container(
                        color: int.parse(modelsm[index].Status) == 3
                            ? Colors.green
                            : Colors.blue,
                        width: 80,
                        height: 120,
                        child: IconButton(
                            icon: Icon(Icons.local_shipping),
                            iconSize: 50,
                            onPressed: () => (modelsm[index].PlacaCV != "" ||
                                    modelsm[index].PlacaCV != null &&
                                        (listPosicao.indexWhere((item) =>
                                                item.PlacaCv ==
                                                modelsm[index].PlacaCV)) >= 0)
                                ? {
                                    //listPosicao.indexWhere((item) => item.PlacaCv == modelsm[index].PlacaCV)
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => MapsDrivePoints(
                                                  placa: modelsm[index].PlacaCV,
                                                  latitude: double.parse(
                                                      listPosicao[listPosicao
                                                              .indexWhere((item) =>
                                                                  item.PlacaCv ==
                                                                  modelsm[index]
                                                                      .PlacaCV)]
                                                          .LatitudePos),
                                                  longitude: double.parse(
                                                      listPosicao[listPosicao
                                                              .indexWhere((item) =>
                                                                  item.PlacaCv ==
                                                                  modelsm[index]
                                                                      .PlacaCV)]
                                                          .LongitudePos),
                                                  datahora:
                                                      modelsm[index].DataAlter,
                                                )))
                                  }
                                : {},
                            color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${modelsm[index].SM} - ${modelsm[index].PlacaCV != null ? modelsm[index].PlacaCV + " - " : ""}${DateFormat('dd/MM/y hh:mm',).format(DateTime.parse(modelsm[index].DataAlter))}"
                              ,style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            (modelsm[index].PlacaCV != "" ||
                                    modelsm[index].PlacaCV != null)
                                ? PosicaoList(
                                    placa: modelsm[index].PlacaCV,
                                  )
                                : Text(""),
                            SizedBox(height: 8),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Icon(
                                    (index % 2 == 0)
                                        ? Icons.key
                                        : Icons.key_off_outlined,
                                    color: (index % 2 == 0)
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  (index % 2 == 0)
                                      ? Icon(
                                          Icons.lock_open_outlined,
                                          color:
                                              Color.fromARGB(255, 15, 15, 15),
                                        )
                                      : Icon(
                                          Icons.lock_outlined,
                                          color: Colors.red,
                                        ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.device_thermostat,
                                    color: Colors.black,
                                  ),
                                  Text("${0}C°"),
                                  Icon(
                                    Icons.speed,
                                    color: Color.fromARGB(255, 15, 15, 15),
                                  ),
                                  Text("${0}Km/h",style: const TextStyle(fontWeight: FontWeight.bold)),
                                ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class PosicaoList extends StatelessWidget 
{
  PosicaoList({super.key, required this.placa});
  final String placa;
  late Future<Posicao> posicao;

  void initState() {
    posicao = fetchPosicao(placa);
  }

  @override
  Widget build(BuildContext context) {
    initState();
    return FutureBuilder<Posicao>(
      future: posicao,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text(''),
          );
        } else if (snapshot.hasData) {
          return Text(
            snapshot.data!.ReferenciaPos != null
                ? snapshot.data!.ReferenciaPos.toString()
                : "",
            // style: TextStyle(fontSize: 10),
          );
        } 
        else 
        {
          return const Center(
            child: Text(''), 
          );
        }
      },
    );
  }
}
