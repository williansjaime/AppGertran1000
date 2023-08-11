class Posicao
{
  String PlacaCv;
  String DataInicioPos;
  String LatitudePos;
  String LongitudePos;
  String ReferenciaPos;

  Posicao({
    required this.PlacaCv,
    required this.DataInicioPos,
    required this.LatitudePos,
    required this.LongitudePos,
    required this.ReferenciaPos,
  });

  factory Posicao.fromJson(Map<String, dynamic> json) 
    {
      return Posicao(
        PlacaCv: json["placa"],
        DataInicioPos: json["DataInicioPos"],
        LatitudePos: json["LatitudePos"],
        LongitudePos: json["LongitudePos"],
        ReferenciaPos: json["ReferenciaPos"],
      );
  }

}