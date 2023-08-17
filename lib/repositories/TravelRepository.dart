import '../models/Perifericos.dart';

abstract class TravelRepository{
  Future<List<Perifericos>> fetchPeriferico(String placa);
}


