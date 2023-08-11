import 'package:flutter/material.dart';

class VehicleAlerts extends StatefulWidget {
  @override
  _VehicleAlertsState createState() => _VehicleAlertsState();
}

class _VehicleAlertsState extends State<VehicleAlerts> {
  bool _isAlwaysShown = true;
  bool _showTrackOnHover = false;
  final int SM = 14052832;
  final String placa = "MLX2526";
  final String alertaVeiculo = "EXCESSO DE VELOCIDADE";
  // PORTA BAU ABERTA // ATRASO EM INFORMAR INICIO DE VIAGEM
  //ATRASO AO INFORMAR INCIO DE VIAGEM // INICO DE VIAGEM FORA DO PONTO

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alertas de Veículos"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Scrollbar(
              isAlwaysShown: _isAlwaysShown,
              showTrackOnHover: _showTrackOnHover,
              hoverThickness: 30.0,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) =>
                    telaSM(index, SM, placa, alertaVeiculo),
              ),
            ),
          ),
          Divider(height: 10),
        ],
      ),
    );
  }
}

class telaSM extends StatelessWidget {
  final int id;
  final int SM;
  final String placa;
  final String alertaVeiculo;

  const telaSM(this.id, this.SM, this.placa, this.alertaVeiculo);

  @override
  Widget build(BuildContext context) {
    if ((id % 2) == 0) {
      return ListTile(
        leading: Icon(
          Icons.bus_alert_rounded,
          color: Colors.red,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        title: Text("${SM} - ${placa}"),
        subtitle: Text("${alertaVeiculo} \nRua Bahia, Belo Horizonte,MG "),
      );
    } else {
      return ListTile(
        leading: Icon(
          Icons.bus_alert_rounded,
          color: Colors.orange,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        title: Text("${SM} - ${placa}"),
        subtitle: Text("${alertaVeiculo} \n BR 381, Sabará,MG "),
      );
    }
  }
}
