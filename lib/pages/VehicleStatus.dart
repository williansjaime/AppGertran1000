import 'login.page.dart';
import '../models/TravelList.dart';
import 'package:flutter/material.dart';
import 'package:bmnav/bmnav.dart' as bmnav;
import 'package:apptestewillians/pages/HomePage.dart';
import 'package:apptestewillians/controller/Travel.dart';
import 'package:apptestewillians/controller/APIIntegration.dart';


class VehicleStatus extends StatefulWidget 
{
  VehicleStatus({super.key, required this.cnpj});
  final String cnpj;
  @override
  State<VehicleStatus> createState() => _VehicleStatusState(cnpj:cnpj);  
}

class _VehicleStatusState extends State<VehicleStatus>
{
  _VehicleStatusState({required this.cnpj});
  final String cnpj;
  
  bool _isAlwaysShown = true;
  bool _showTrackOnHover = false;
 
  final List rota = [LoginPage(), LoginPage()];
  
  APIIntegrationState apiIntegrationState = new APIIntegrationState();
  
  void initState()
  {
    //apiIntegrationState.APIReturn();
    //super initState();
  }
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Status dos Veículos"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: HomeTravel(cnpj:cnpj),),
        ],
      ),
      bottomNavigationBar: bmnav.BottomNav(
        onTap: (index) {
          if(index < 1)
          {
            Navigator.pop(context);
          }
          else
          {    
            //getView(index);
            Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => rota[index]),
                      (Route<dynamic> route) => false);
            }
        },
        labelStyle: bmnav.LabelStyle(visible: true),
        iconStyle:
            bmnav.IconStyle(color: Colors.black, onSelectColor: Colors.red),
        elevation: 10,
        items: [
          bmnav.BottomNavItem(Icons.home, label: "Gerenciamento"),
          //bmnav.BottomNavItem(Icons.local_shipping, label: "Veiculos"),
          //bmnav.BottomNavItem(Icons.person, label: "Motoristas"),
          bmnav.BottomNavItem(Icons.exit_to_app, label: 'Sair')
        ],
      ),
    );
  } 
}
