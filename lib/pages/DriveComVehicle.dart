import 'package:flutter/material.dart';
import 'package:bmnav/bmnav.dart' as bmnav;
import '../pages/DriveHomePage.dart';
import 'login.page.dart';


class DriveComVehicle extends StatefulWidget {
  //const DriveComVehicle({super.key});
  @override
  State<DriveComVehicle> createState() => _DriveComVehicleState();
}

class _DriveComVehicleState extends State<DriveComVehicle> {
  final List rota = [
    //DriveHomePage(), 
  LoginPage()];
  
  @override
  Widget build(BuildContext context) {
    final title = "Motorista";

    return Scaffold(
            appBar: AppBar(
              title: Text(
                title,
                textAlign: TextAlign.center,
              ),
            ),
            body: GridView.count(
                crossAxisCount: 3,
                children: List.generate(comandes.length, (index) {
                  return Center(
                    child: ChoiceCard(comandes: comandes[index]),
                  );
                })),
                 bottomNavigationBar: bmnav.BottomNav(
        onTap: (index) {
          if(index == 1){
            Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => rota[index]),
                    (Route<dynamic> route) => false);
          }else{
            Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => rota[index]),
                          (Route<dynamic> route) => false);
          
          }
          //getView(index);
        },
        labelStyle: bmnav.LabelStyle(visible: true),
        iconStyle:
            bmnav.IconStyle(color: Colors.black, onSelectColor: Colors.red),
        elevation: 10,
        items: [
          bmnav.BottomNavItem(Icons.home, label: "Página inicial"),
          bmnav.BottomNavItem(Icons.exit_to_app, label: "Sair"),
        ],
      ),
    );
  }
}

class Comande {
  const Comande({this.title});
  final String? title;
}

const List<Comande> comandes = const [
  const Comande(title: "INICIO DE JORNADA"),
  const Comande(title: "INICIO DE VIAGEM"),
  const Comande(title: "PARADA EVENTUAL"),
  const Comande(title: "PARADA REFEIÇÃO"),
  const Comande(title: "PARADA PERNOITE"),
  const Comande(title: "REINICIO DE VIAGEM"),
  const Comande(title: "INCIO DE CARGA/DESCAGA"),
  const Comande(title: "TERMINO DE CARGA/DESCAGA"),
  const Comande(title: "FIM DE VIAGEM"),
  const Comande(title: "BOTÃO DE PANICO"),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key? key, this.comandes}) : super(key: key);

  final Comande? comandes;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: new InkWell(
            /*onTap: () {
              Navigator.push(
              context, MaterialPageRoute(builder: (_) => showAlertDialog1(context)));              
            },*/
            child: Center(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${comandes?.title}",
                      textAlign: TextAlign.center,
                    ),
                  ]), 
            ),),);
  }
}
/*
class DialogComande extends StatelessWidget {
  const DialogComande({super.key});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}*/

/*
showAlertDialog1(BuildContext context) 
{ 
    // configura o button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () { },
  );
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text("Promoção Imperdivel"),
    content: Text("Não perca a promoção."),
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}*/
