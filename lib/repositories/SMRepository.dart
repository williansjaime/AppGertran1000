import '../models/Solicitacao.dart';

abstract class SMModelRepository{
  Future<List<ModelSM>> fetchModelSM();
}