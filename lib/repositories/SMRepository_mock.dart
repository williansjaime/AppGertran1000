import 'dart:convert';

import 'package:apptestewillians/models/Solicitacao.dart';
import 'package:flutter/services.dart';

import 'SMRepository.dart';

class SMRepositoryMock implements SMModelRepository{
  @override
  Future<List<ModelSM>> fetchModelSM() async {
    var value = await rootBundle.loadString('assets/fakes/SM.json');
    List postJson = jsonDecode(value);
    return postJson.map((e) => ModelSM.fromJson(e)).toList();
  }
}