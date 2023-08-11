import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ModelSM {
  final String SM;
  final String Status;
  final String PlacaCV;
  final String PlacaCR;
  final String none;
  final String Motorista;
  final String DataTime;
  final String DataAlter;

  const ModelSM({
    required this.SM,
    required this.Status,
    required this.PlacaCV,
    required this.PlacaCR,
    required this.none,
    required this.Motorista,
    required this.DataTime,
    required this.DataAlter,
    
  });

  factory ModelSM.fromJson(Map<String, dynamic> json) {
    return ModelSM(
      DataTime: json['Data'] as String,
      DataAlter: json['DataAlter']  as String,
      Motorista: json['Mot']  as String,
      PlacaCR: json['PlacaCR']  as String,
      PlacaCV: json['PlacaCV']  as String,
      SM: json['SM']  as String,
      Status: json['Status']  as String,
      none: json['none']  as String,
    );
  }
  
  
}



/*
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<ModelSM> model_sm;
  
  @override
  void initState() {    
    super.initState();
    model_sm = fetchModelSM();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
          child: FutureBuilder<ModelSM>(
            future: model_sm,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.Motorista.toString());
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
    );
  }
}*/
