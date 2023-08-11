import "package:flutter/material.dart";

class CheckListDisapproved extends StatefulWidget {
  @override
  _CheckListDisapprovedState createState() => _CheckListDisapprovedState();
}

class _CheckListDisapprovedState extends State<CheckListDisapproved> {
  bool _isAlwaysShown = true;
  bool _showTrackOnHover = false;
  final int NumCheckList = 14052832;
  final String placa = "MLX2526";
  final String alertaVeiculo = "";
  // PORTA BAU ABERTA // ATRASO EM INFORMAR INICIO DE VIAGEM
  //ATRASO AO INFORMAR INCIO DE VIAGEM // INICO DE VIAGEM FORA DO PONTO

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CheckList Reprovados"),
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
                    checklistdisapproved(NumCheckList, placa, alertaVeiculo),
              ),
            ),
          ),
          Divider(height: 10),
        ],
      ),
    );
  }
}

class checklistdisapproved extends StatelessWidget {
  final int numchecklist;
  final String placa;
  final String alertaVeiculo;

  const checklistdisapproved(this.numchecklist, this.placa, this.alertaVeiculo);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.assignment_outlined,
        color: Colors.orange,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      title: Text("${numchecklist} - ${placa}"),
      subtitle: Text("${alertaVeiculo}Problema na trava do Baú/Porta Carona"),
    );
  }
}
