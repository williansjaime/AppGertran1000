import 'package:apptestewillians/pages/DriveHomePage.dart';

import "ListTruck.dart";
import "ListDriver.dart";
import "VehicleAlerts.dart";
import "SMApproved.dart";
import "VehicleStatus.dart";
import "package:flutter/material.dart";
import "package:apptestewillians/pages/login.page.dart";

class HomePage extends StatefulWidget {
  HomePage(
      {super.key,
      required this.HomecountSM,
      required this.Homecountchecklist,
      required this.cnpj});

  int HomecountSM, Homecountchecklist;
  final String cnpj;
  @override
  State<HomePage> createState() => _HomePageState(
      HomecountSM: HomecountSM,
      Homecountchecklist: Homecountchecklist,
      cnpj: cnpj);
}

class _HomePageState extends State<HomePage> {
  _HomePageState(
      {required this.HomecountSM,
      required this.Homecountchecklist,
      required this.cnpj});
  int HomecountSM, Homecountchecklist;
  final String cnpj;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  //key for scaffold, required to manually open/close drawer

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Gerenciamento"),
      ),
      // drawer: Drawer(
      //   child: SafeArea(
      //       child: Column(
      //     children: [
      //       ListTile(
      //         dense: true,
      //         title: Text("Gerenciamento"),
      //         leading: Icon(Icons.home),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         dense: true,
      //         title: Text("Motoristas Cadastrados"),
      //         leading: Icon(Icons.person),
      //         onTap: () {
      //           Navigator.push(
      //               context, MaterialPageRoute(builder: (_) => ListDriver()));
      //         },
      //       ),
      //       ListTile(
      //         dense: true,
      //         title: Text("Veículos Cadastrados"),
      //         leading: Icon(Icons.local_shipping),
      //         onTap: () {
      //           Navigator.push(
      //               context, MaterialPageRoute(builder: (_) => ListTruck()));
      //         },
      //       ),
      //       ListTile(
      //         dense: true,
      //         title: Text("Configurações"),
      //         leading: Icon(Icons.settings),
      //         onTap: () {
      //           // Navigator.push(
      //           //     context,
      //           //     MaterialPageRoute(
      //           //         builder: (_) =>
      //           //             DriveHomePage())); 
      //         },
      //       ),
      //       ListTile(
      //         dense: true,
      //         title: Text("Sair"),
      //         leading: Icon(Icons.exit_to_app),
      //         onTap: () {
      //           Navigator.of(context).pushAndRemoveUntil(
      //               MaterialPageRoute(builder: (context) => LoginPage()),
      //               (Route<dynamic> route) => false);
      //         },
      //       )
      //     ],
      //   )),
      // ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 70,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Container(
                    color: Colors.green,
                    width: 70,
                    height: 70,
                    child: Icon(Icons.local_shipping,
                        size: 60, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("STATUS DOS VEÍCULOS"),
                        Text("", style: TextStyle(color: Colors.grey))
                      ],
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => VehicleStatus(
                                          cnpj: cnpj,
                                        )))
                          },
                      color: Colors.blue),
                ],
              ),
            ),
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 70,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Container(
                    color: Colors.red,
                    width: 70,
                    height: 70,
                    child: IconButton(
                        icon: Icon(
                          Icons.bus_alert_rounded,
                          size: 60,
                        ),
                        onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => VehicleAlerts()))
                            },
                        color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("ALERTAS DE VEÍCULOS"),
                        Text("", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () => {
                            /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => VehicleAlerts()))*/
                          },
                      color: Colors.blue),
                ],
              ),
            ),
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 70,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Container(
                    color: Color.fromARGB(255, 3, 139, 250),
                    width: 70,
                    height: 70,
                    child: Icon(Icons.article, size: 60, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("SOLICITAÇÕES DE MONITORAMENTO"),
                        // Text(HomecountSM.toString(),
                        //     style: TextStyle(color: Colors.grey))
                      ],
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SMApproved(cnpj: cnpj)))
                          },
                      color: Color.fromARGB(255, 3, 139, 250)),
                ],
              ),
            ),
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 70,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Container(
                    color: Colors.orange,
                    width: 70,
                    height: 70,
                    child: Icon(Icons.assignment_late_rounded,
                        size: 60, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("CHECKLISTS"),
                        // Text(Homecountchecklist.toString(),
                        //     style: TextStyle(color: Colors.grey))
                      ],
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () => {
                            {}
                            /* if(Homecountchecklist>0){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CheckListPage(cnpj:cnpj)))
                            }else{
                              {}
                            }*/
                            ,
                          },
                      color: Colors.blue),
                ],
              ),
            ),
          ),
        ),
        Divider(),
      ])),
    );
  }
}
