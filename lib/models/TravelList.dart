import 'package:flutter/material.dart';

class TravelList {
  final int SM;
  final int temperatura;
  final int velocidade;
  final bool status;
  final bool ignicao;
  final bool bloqueado;
  final double latitude;
  final double longitude;
  final String placa;
  final String statusVeiculo;
  final String nomeMotorista;
  final String EnderecoPosicao;
  final DateTime dateTime;
    
  TravelList(
    {
    required this.SM,
    required this.placa,
    required this.statusVeiculo,
    required this.nomeMotorista,
    required this.EnderecoPosicao,
    required this.status,
    required this.ignicao,
    required this.bloqueado,
    required this.temperatura,
    required this.velocidade,
    required this.dateTime,
    required this.latitude,
    required this.longitude,
  });

}