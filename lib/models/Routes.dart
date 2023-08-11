class Routes
{
  String DataCriacao;
  String DestinoRt;
  String OrigemRt;
  List<dynamic> PontosRt;
  String PercursoRt;
  

  Routes({
    required this.PontosRt,
    required this.PercursoRt,
    required this.OrigemRt,
    required this.DestinoRt,
    required this.DataCriacao,
  });

  factory Routes.fromJson(Map<String, dynamic> json) 
    {
      return Routes(
        DataCriacao: json["DataCriacao"],
        DestinoRt: json["DestinoRt"], 
        OrigemRt: json["OrigemRt"],
        PercursoRt: json["PercursoRt"],
        PontosRt: json["PontosRt"],
      );
  }

}