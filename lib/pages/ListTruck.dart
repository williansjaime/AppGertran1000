import 'package:flutter/material.dart';

class ListTruck extends StatefulWidget {
  @override
  _ListTruckState createState() => _ListTruckState();
}

class _ListTruckState extends State<ListTruck> 
{
  bool _isAlwaysShown = true;
  bool _showTrackOnHover = false;
  final String placa = "MLX2526";
  final String tipo = "CAVALO";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Veiculos Cadastrados"),
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
                itemBuilder: (context, index) => MyItem(index, placa, tipo),
              ),
            ),
          ),
          Divider(height: 10),
        ],
      ),
    );
  }
}

class MyItem extends StatelessWidget {
  final int index;
  final String placa;
  final String tipo;

  const MyItem(this.index, this.placa, this.tipo);

  @override
  Widget build(BuildContext context) {
    if ((index % 2) == 0) {
      return ListTile(
        leading: Icon(Icons.local_shipping),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        title: Text(placa),
        subtitle: Text(tipo),
      );
    } else {
      return ListTile(
        leading: Icon(Icons.local_shipping),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        title: Text(placa),
        subtitle: Text('REBOQUE'),
      );
    }
  }
}
