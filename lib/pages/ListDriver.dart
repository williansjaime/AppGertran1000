import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ListDriver extends StatefulWidget {
  @override
  _ListDriverState createState() => _ListDriverState();
}

class _ListDriverState extends State<ListDriver> {
  bool _isAlwaysShown = true;
  bool _showTrackOnHover = false;
  final String nome = "Caio Herique da Costa";
  final String cnh = "MG20202220132421";
  final String cargo = "AGREGADO"; // TERCEIRO // CONTRATADO
  final int cpf = 123456789123;
  /*var lisaMotorisata = List<String, String, String, String, int>  {
    "Caio Herique da Costa",
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Motoristas Cadastrados"),
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
                itemCount: 20,
                itemBuilder: (context, index) =>
                    MyItem(index, nome, cnh, cpf, cargo),
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
  final int cpf;
  final String nome;
  final String cnh;
  final String cargo;

  const MyItem(this.index, this.nome, this.cnh, this.cpf, this.cargo);

  @override
  Widget build(BuildContext context) {
    final color = Colors.primaries[index % Colors.primaries.length];
    final hexRgb = color.shade500.toString().substring(10, 16).toUpperCase();
    if ((index % 2) == 0) {
      return ListTile(
        leading: Icon(Icons.person),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        title: Text(nome),
        subtitle: Text('${cargo}'),
      );
    } else {
      return ListTile(
        leading: Icon(
          Icons.person,
          color: Colors.red,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        title: Text(nome),
        subtitle: Text('TERCEIRO'),
      );
    }
  }
}
