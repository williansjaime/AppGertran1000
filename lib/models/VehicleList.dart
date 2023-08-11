
class VehicleList {
  final  int SM ;
  final String PLACA;
  final String statusVeiculo;
  final bool status;
  final bool ignicao;
  final bool bloqueado;
  final int temperatura;
  final int velocidade;

  VehicleList(
    {required this.SM,
    required this.PLACA,
  required this.statusVeiculo,
  required this.status, 
  required this.ignicao, 
  required this.bloqueado, 
  required this.temperatura,
  required this.velocidade});
}