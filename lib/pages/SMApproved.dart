import 'dart:io';
import 'dart:convert';
import 'package:apptestewillians/pages/MapsDrivePoint.dart';
import 'package:apptestewillians/repositories/SMRepository.dart';
import 'package:apptestewillians/repositories/SMRepository_mock.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apptestewillians/models/Solicitacao.dart';

List<ModelSM> travelList = [];

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
        travelList.add(ModelSM.fromJson(bod));
      }
      return travelList; //compute(parsePhotos, response.body);
    } else {
      return travelList;
    }
  } catch (e) {
    return throw Exception(e);
  }
}

class SMApproved extends StatefulWidget {
  SMApproved({super.key, required this.cnpj});
  final String cnpj;
  @override
  _SMApprovedState createState() => _SMApprovedState(cnpj: cnpj);
}

class _SMApprovedState extends State<SMApproved> {
  _SMApprovedState({required this.cnpj});
  final String cnpj;
  bool _isAlwaysShown = true;
  bool _showTrackOnHover = false;
  // PORTA BAU ABERTA // ATRASO EM INFORMAR INICIO DE VIAGEM
  //ATRASO AO INFORMAR INCIO DE VIAGEM // INICO DE VIAGEM FORA DO PONTO

  late Future<List<ModelSM>> futurelist;

  void initState() {
    super.initState();
    SMModelRepository modelRepository = SMRepositoryMock();
    //futurelist = modelRepository.fetchModelSM();
    futurelist = fetchModelSM(cnpj);
  }

  buildContainer() {
    return FutureBuilder<List<ModelSM>>(
      future: futurelist,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error has occurred!'),
          );
        } else if (snapshot.hasData) {
          return CardLIst(modelsm: snapshot.data!);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de SM"),
        ),
        body: buildContainer());
  }
}

class telaSM extends StatelessWidget {
  final int SM;
  final double valor;
  final String placa;
  final String alertaVeiculo;
  final String nomeMotorista;

  const telaSM(
      this.SM, this.placa, this.alertaVeiculo, this.nomeMotorista, this.valor);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.article,
        color: Color.fromARGB(255, 0, 146, 220),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      title: Text('${SM} - ${placa}\nR\$${valor}'),
      subtitle: Text("${nomeMotorista} "),
    );
  }
}

List<String> tiposStatus = [
  "Rascunho",
  "Em_Avaliação",
  "Aguardando_inicio_de_viagem",
  "Em_viagem",
  "Finalizado",
  "Encerrado_com_sucesso",
  "cancelado",
  "Reprovado",
  "Provavel_sinistro",
  "Sinistro_caracterizado",
  "Encerrado_sem_sucesso",
  "Encerrado_reprovado",
  "Pendente",
  "Simulação"
];

String funcStatus(int valorStatus) {
  if (valorStatus != 99) {
    return tiposStatus[valorStatus];
  } else if (valorStatus == 99) {
    return tiposStatus[tiposStatus.length - 1];
  } else {
    return "SEM_STATUS";
  }
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
                  height: 70,
                  color: Color.fromARGB(0, 237, 227, 227),
                  child: Row(
                    children: <Widget>[
                      Container(
                        color: Colors
                            .white, //((index%2)>0) == true ? Colors.green : Colors.red,
                        width: 80,
                        height: 100,
                        child: IconButton(
                            icon: Icon(
                              Icons.article,
                              color: Color.fromARGB(255, 0, 146, 220),
                            ),
                            onPressed: () => {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (_) => MapsDrivePoints(
                                  //             placa: 'placa',
                                  //             latitude: 20.5,
                                  //             longitude: 20.00,
                                  //             datahora: '10/10/2000')))
                                },
                            color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${modelsm[index].SM} - ${modelsm[index].PlacaCV != null ? modelsm[index].PlacaCV + "" : ""}",
                            ),
                            /*modelsm[index].PlacaCV != null ?
                                    PosicaoList(placa: modelsm[index].PlacaCV,)
                                    :*/
                            Text('${DateTime.parse(modelsm[index].DataAlter)}'),
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
