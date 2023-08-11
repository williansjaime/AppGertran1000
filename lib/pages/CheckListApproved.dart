import 'package:flutter/material.dart';

class CheckListApproved extends StatefulWidget {
  @override
  _CheckListApprovedState createState() => _CheckListApprovedState();
}

class _CheckListApprovedState extends State<CheckListApproved> {
  bool _isAlwaysShown = true;
  bool _showTrackOnHover = false;
  final int SM = 14052832;
  final String placa = "MLX2526";
  final String alertaVeiculo = "VEICULO PRONTO";
  // PORTA BAU ABERTA // ATRASO EM INFORMAR INICIO DE VIAGEM
  //ATRASO AO INFORMAR INCIO DE VIAGEM // INICO DE VIAGEM FORA DO PONTO

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CheckList Aprovado"),
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
                    checklistapproved(SM, placa, alertaVeiculo),
              ),
            ),
          ),
          Divider(height: 10),
        ],
      ),
    );
  }
}

class checklistapproved extends StatelessWidget {
  final int numCheckList;
  final String placa;
  final String alertaVeiculo;

  const checklistapproved(this.numCheckList, this.placa, this.alertaVeiculo);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.assignment_outlined,
        color: Colors.green,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      title: Text('${numCheckList} - ${placa}'),
      subtitle: Text(alertaVeiculo),
    );
  }
}
