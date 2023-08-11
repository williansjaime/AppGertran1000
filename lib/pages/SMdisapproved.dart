import 'package:flutter/material.dart';

class SMdisapproved extends StatefulWidget {
  @override
  _SMdisapprovedState createState() => _SMdisapprovedState();
}

class _SMdisapprovedState extends State<SMdisapproved> {
  bool _isAlwaysShown = true;
  bool _showTrackOnHover = false;
  final int SM = 14052832;
  final double valorCarga = 120000.00;
  final String placa = "MLX2526";
  final String statusSM = "VEÍCULO FORA DO LOCAL DE ORIGEM";
  // PORTA BAU ABERTA // ATRASO EM INFORMAR INICIO DE VIAGEM
  //ATRASO AO INFORMAR INCIO DE VIAGEM // INICO DE VIAGEM FORA DO PONTO

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SM Reprovadas"),
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
                    telaSM(SM, placa, statusSM, valorCarga),
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
  final int SM;
  final double valorCarga;
  final String placa;
  final String statusSM;

  const telaSM(this.SM, this.placa, this.statusSM, this.valorCarga);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.article,
        color: Colors.orange,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      title: Text('${SM} - ${placa}\nR\$${valorCarga}'),
      subtitle: Text(statusSM),
    );
  }
}
