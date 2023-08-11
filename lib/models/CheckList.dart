import 'package:flutter/material.dart';

class CheckList {
final String NumeroCheckList;
final String SM;
final String placaCavalo;
final String placaCarreta;
final String AtuaSensor;
final String dataCriacao;

CheckList({
  required this.NumeroCheckList,
  required this.SM,
  required this.placaCavalo,
  required this.placaCarreta,
  required this.AtuaSensor,
  required this.dataCriacao,

});

 factory CheckList.fromJson(Map<String, dynamic> json) 
  {
    return CheckList(
      NumeroCheckList: json['CodigoCheckListChk'] as String,
      SM: json['CodigoViagemMonitoradaChk'] as String,
      placaCavalo: json['PlacaCV'] as String,
      placaCarreta: json['PlacaCR'] as String,
      AtuaSensor: json['Atuadores_SensoresChk'] as String,
      dataCriacao: json['DataCriacaoChk'] as String,
           
    );
/*
{"0":{"Atuadores_SensoresChk":"{\"chkSensorPortaMotorista\":true,\"chkSensorPortaPassageiro\":true,\"chkSensorEngateCarreta\":true,\"chkSensorPainel\":true,\"chkSensorBau\":true,\"chkSirene\":true,\"chkBloqueio\":true,\"chkTravaBau\":false,\"chkAprovado\":true,\"chkreprovado\":false,\"txtJustificativa\":\"\",\"chkViagemAutorizada\":true,\"chkViagemNaoAutorizada\":false,\"txtJustificativaGeral\":\"\",\"chkMacrosSIM\":true,\"chkMacrosNAO\":false,\"chkInteligenciaEmbarcadaSIM\":true,\"chkInteligenciaEmbarcadaNAO\":false,\"txtJustInteligenciaEmbarcada\":\"\",\"txtTerminal\":\"96\",\"txtNome\":\"BRENO ARAUJO DE SOUZA\",\"txtEmpresa\":\"TRANSCAFE (BRANDAO E ARAUJO TRANSPORTES LTDA)\",\"txtDataCriacao\":\"2023/02/16 07:56:11\"}",
"CodigoCheckListChk":"701268","CodigoViagemMonitoradaChk":"1520069","DataCriacaoChk":"Thu, 16 Feb 2023 09:29:53 GMT","PlacaCR":null,"PlacaCV":"NLE9C14"},"1":{"Atuadores_SensoresChk":"{\"chkSensorPortaMotorista\":true,\"chkSensorPortaPassageiro\":true,\"chkSensorEngateCarreta\":true,\"chkSensorPainel\":true,\"chkSensorBau\":true,\"chkSirene\":true,\"chkBloqueio\":true,\"chkTravaBau\":false,\"chkAprovado\":true,\"chkreprovado\":false,\"txtJustificativa\":\"\",\"chkViagemAutorizada\":true,\"chkViagemNaoAutorizada\":false,\"txtJustificativaGeral\":\"\",\"chkMacrosSIM\":true,\"chkMacrosNAO\":false,\"chkInteligenciaEmbarcadaSIM\":true,\"chkInteligenciaEmbarcadaNAO\":false,\"txtJustInteligenciaEmbarcada\":\"\",\"txtTerminal\":\"96\",\"txtNome\":\"BRENO ARAUJO DE SOUZA\",\"txtEmpresa\":\"TRANSCAFE (BRANDAO E ARAUJO TRANSPORTES LTDA)\",\"txtDataCriacao\":\"2023/02/16 07:56:11\"}","CodigoCheckListChk":"701185",
 "CodigoViagemMonitoradaChk":"1520069","DataCriacaoChk":"Thu, 16 Feb 2023 09:29:53 GMT","PlacaCR":null,"PlacaCV":"nle9c14"}}

*/

  }


}