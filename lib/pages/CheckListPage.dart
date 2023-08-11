import 'dart:io';
import 'dart:async';
import 'dart:convert';
import "package:flutter/material.dart";
import '../models/CheckList.dart';
import 'package:http/http.dart' as http;

List<CheckList> listCheckList = [];

Future <List<CheckList>> fetchCheckList(final String cnpj) async {

  String ipexterno = 'gertranapi.hopto.org';
  String ipinterno =  '192.168.34.7';
  
  Uri uri = Uri(
      scheme: 'https',
      port: 5000,
      host: Platform.isLinux? ipinterno: ipexterno,
      path: '/checklist/$cnpj');

  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };
  try 
  {
    final response = await http.get(uri, headers: headers).timeout(
          const Duration(seconds: 20),
              onTimeout: () {
                // Time has run out, do what you wanted to do.
                return http.Response('Error', 408); // Request Timeout response status code
              },);

    if(response.statusCode == 200)
    {
      final body = json.decode(response.body);

      for(var bod in body.values)
      {
        listCheckList.add(CheckList.fromJson(bod));
        
      }
      return listCheckList;//compute(parsePhotos, response.body);
    }else{
        return listCheckList;
    }
  } catch (e) {
    return throw Exception(e);
  }
}

class CheckListPage extends StatefulWidget 
{
  CheckListPage({super.key, required this.cnpj});
  final String cnpj;
  @override
  _CheckListPageState createState() => _CheckListPageState(cnpj:cnpj);
}

class _CheckListPageState extends State<CheckListPage> 
{
   _CheckListPageState({required this.cnpj});
  final String cnpj;
  late Future <CheckList> filterFutureCheckList;
  late Future <List<CheckList>> listFilterFutureCheckList;

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
        body: buildContainer());
  }
  void initState()
  {
    listFilterFutureCheckList = fetchCheckList(cnpj);
  }  

  buildContainer() {
    return FutureBuilder <List<CheckList>>(
              future: listFilterFutureCheckList,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(''),
                  );
                } else if(snapshot.hasData) 
                {
                  return CardLIst(modelCheckList: snapshot.data!);                  
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
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
  const CardLIst({super.key, required this.modelCheckList});

  final List<CheckList> modelCheckList;
  @override
  Widget build(BuildContext context) 
  {
    return ListView.builder(
                  itemCount: modelCheckList.length,
                  itemBuilder: (context, index) { 
                  return
                  Card(
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
                                color: Colors.white,//((index%2)>0) == true ? Colors.green : Colors.red,
                                width: 80,  
                                height: 100,
                                child: IconButton(
                                    icon: Icon(
                                        Icons.assignment_outlined,
                                        color: Color.fromARGB(255, 0, 146, 220),
                                      ),
                                    onPressed: () => {
                                          /*Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => MapsDrivePoint(tr.latitude,tr.longitude)))*/
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
                                      "${modelCheckList[index].NumeroCheckList} - ${modelCheckList[index].SM != null? modelCheckList[index].SM + "\n":""} ${modelCheckList[index].placaCavalo != null ? modelCheckList[index].placaCavalo + "":""}",
                                    ),
                                    /*modelCheckList[index].PlacaCV != null ?
                                    PosicaoList(placa: modelCheckList[index].PlacaCV,)
                                    :*/
                                    Text('${DateTime.parse(modelCheckList[index].dataCriacao)}'),                                                                        
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    );                    
                    
                  }
                    );
                
      }
    
 }

