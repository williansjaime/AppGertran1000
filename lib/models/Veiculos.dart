import 'package:flutter/services.dart';

class Veiculos {
  final int albumId;
  final int id;
  final String Placa;
  final String Modelos;
  final String Status;

  const Veiculos({
    required this.albumId,
    required this.id,
    required this.Placa,
    required this.Modelos,
    required this.Status,
  });

  factory Veiculos.fromJson(Map<String, dynamic> json) {
    return Veiculos(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      Placa: json['title'] as String,
      Modelos: json['url'] as String,
      Status: json['thumbnailUrl'] as String,
    );
  }
}
