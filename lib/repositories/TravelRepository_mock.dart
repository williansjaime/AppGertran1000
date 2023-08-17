import 'dart:convert';

import 'package:apptestewillians/models/Perifericos.dart';
import 'package:flutter/services.dart';

import 'TravelRepository.dart';


class TravelRepositoryMock implements TravelRepository{
  @override
  Future<List<Perifericos>> fetchPeriferico(String placa) async {
    String value = await rootBundle.loadString('assets/fakes/status.json');
    List postJson = jsonDecode(value);
    return postJson.map((e) => Perifericos.fromJson(e)).toList();
  }

}