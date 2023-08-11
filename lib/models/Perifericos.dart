import 'package:flutter/material.dart';

class Perifericos {
  final String CodigoPerifericoPer;
  final String DataAtualizacaoPer;
  final String ValorPer;
  final String Placa;
  
  Perifericos( {
    required this.CodigoPerifericoPer,
    required this.DataAtualizacaoPer,
    required this.ValorPer,
    required this.Placa,
  });

  factory Perifericos.fromJson(Map<String, dynamic> json) 
  {
    return Perifericos(
      CodigoPerifericoPer: json['CodigoPerifericoPer'] as String,
      DataAtualizacaoPer: json['DataAtualizacaoPer'] as String,
      ValorPer: json['ValorPer'] as String,
      Placa: json['Placa'] as String,
    );
  }
}
