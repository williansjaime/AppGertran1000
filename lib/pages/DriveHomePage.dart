import 'dart:async';
import 'dart:math';
import '../controller/ImageInput.dart';
import 'package:flutter/material.dart';
import '../controller/RoutePageDrive.dart';
import 'package:apptestewillians/pages/DriveComVehicle.dart';
import "package:apptestewillians/pages/login.page.dart";
import 'package:apptestewillians/controller/LocationPosition.dart';
import 'package:geocoding/geocoding.dart';
import '../controller/GetIDTecnologia.dart';
import 'package:bmnav/bmnav.dart' as bmnav;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DriveHomePage extends StatefulWidget {
  //const DriveHomePage({super.key});
  @override
  State<DriveHomePage> createState() => _DriveHomePageState();
}

class _DriveHomePageState extends State<DriveHomePage> {
  bool _isAlwaysShown = true;
  bool _showTrackOnHover = false;
  @override
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //LocationPosition location = new LocationPosition();
  final List rota = [DriveComVehicle(), LoginPage()];

  File? _storedImage;
  _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    XFile imageFile = await _picker.pickImage( 
      source: ImageSource.camera,
      maxWidth: 600,
    ) as XFile;

    setState(() {
      _storedImage = File(imageFile.path);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Container(
              width: mediaQuery * 0.7,
              //color: Colors.black,
              child: Text("Motorista"),
            ),
            SizedBox(width: 10),
            IconButton(
              icon: Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () => _takePicture(),
              color: Color.fromARGB(255, 0, 146, 220),
            ),
          ],
        ),
      ),
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
                    color: Colors.red,
                    width: 70,
                    height: 70,
                    child: IconButton(
                        icon: Icon(
                          Icons.local_shipping,
                          size: 50,
                        ),
                        onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          DriveComVehicle())) //APIIntegration()))//
                            },
                        color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("N° SM - MLK12023"),
                        Text("Nome do Motorista",
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.route,
                      size: 40,
                    ),
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MapsRouteDrive(
                                    cpf: "09358076755",
                                  )))
                    },
                    color: Color.fromARGB(255, 0, 146, 220),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(),
        Container(
          width: 180,
          height: 100,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Text(
                  "Nenhuma Nota fiscal!!",
                  selectionColor: Colors.red,
                ),
        ),
        SizedBox(
          width: 10,
        ),
      ])),
      bottomNavigationBar: bmnav.BottomNav(
        onTap: (index) {
          if (index == 2) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => rota[index]),
                (Route<dynamic> route) => false);
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => rota[index]));
          }
          //getView(index);
        },
        labelStyle: bmnav.LabelStyle(visible: true),
        iconStyle:
            bmnav.IconStyle(color: Colors.black, onSelectColor: Colors.red),
        elevation: 10,
        items: [
          bmnav.BottomNavItem(Icons.home, label: "Comandos"),
          bmnav.BottomNavItem(Icons.exit_to_app, label: "Sair"),
        ],
      ),
    );
  }
}