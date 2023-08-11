import 'dart:io';
import 'dart:async';
import 'dart:convert';
import '../models/Posicao.dart';
import '../models/Routes.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlng/latlng.dart';
import 'package:flutter/services.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import '../pages/DriveHomePage.dart';

List<GeoPoint> listpoints = [];

Future<List<GeoPoint>> fetchModelSM(final String cpf) async {
  String ipexterno = 'gertranapi.hopto.org';
  String ipinterno = '192.168.34.7';
  List<GeoPoint> listpoint = [];

  Uri uri = Uri(
      scheme: 'https',
      port: 5000,
      host: Platform.isLinux ? ipinterno : ipexterno,
      path: '/rotas/$cpf');

  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  try
  {

    final response = await http.get(uri, headers: headers).timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        return http.Response('Error', 408);
      },
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      for (List i in Routes.fromJson(body).PontosRt) {
        listpoints.add(GeoPoint(
            latitude: double.parse(i[0]), longitude: double.parse(i[1])));
      }
    }
    listpoint = listpoints; 
    return listpoint;
  }
    catch (e) 
    {
      return throw Exception(e);
    }
}

class MapsRouteDrive extends StatefulWidget {
  MapsRouteDrive({required this.cpf});
  final String cpf;
  @override
  State<MapsRouteDrive> createState() => _MapsRouteDriveState(cpf);
}

class _MapsRouteDriveState extends State<MapsRouteDrive> 
{
  final String cpf;
  _MapsRouteDriveState(this.cpf);
  @override
  void dispose() {
    ///mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rota de Viagem"),
      ),
      body: Stack(
        children: <Widget>[
          RouteValidade(cpf),
          //(listpoints.length > 0)?
         ],
      ),
    );
  }
}



class RouteValidade extends StatelessWidget {

  final String cpf;
  RouteValidade(this.cpf);
  
  MapController mapController = MapController.withPosition(
    initPosition: GeoPoint(latitude: -20.125485, longitude: -40.306017),  
    areaLimit: const BoundingBox.world(),
  );

  
  Future<List<GeoPoint>>? futureListReturn;
  List<GeoPoint> ListReturn = []; 

  void initState() {
    futureListReturn = fetchModelSM(cpf);
    if(listpoints.length > 0)
    {
      mapController = MapController.withPosition(
        initPosition: listpoints[0],
        areaLimit: const BoundingBox.world(),
      );
      final configs = [
        MultiRoadConfiguration(
          startPoint: listpoints[0],
          destinationPoint: listpoints[listpoints.length-1],
          intersectPoints: listpoints ,
        ),
      ];

      Future.delayed(Duration(seconds: 5), () async {
        await mapController.drawMultipleRoad(    
          configs,
          commonRoadOption: MultiRoadOption(
            roadColor: Colors.blue,
          ),
        );
      });

      /*Future.delayed(Duration(seconds: 5), () async 
      {
        await mapController.zoomIn();
      });*/
    }
  }
   
  void dispose() 
  {
    mapController.dispose();
  }
   
  @override
  Widget build(BuildContext context) 
  {
    //initState();    
    return FutureBuilder (
        future: futureListReturn,
        builder: (context, snapshot) {
        if (snapshot.hasError) 
        {
          return  DriveHomePage();//const LoginPage();           
        } 
        else if(snapshot.hasData)
        {
          initState();
          return  OSMFlutter(
              controller: mapController,
              trackMyPosition: false,
              initZoom: 10,
              minZoomLevel: 8,
              maxZoomLevel: 18,
              stepZoom: 2.0,
              markerOption: MarkerOption(
                  defaultMarker: MarkerIcon(
                icon: Icon(
                  Icons.car_crash_outlined,
                  color: Colors.blue,
                  size: 56,
                ),
              )),
              isPicker: false,
            );                          
        }else 
        {
          return Center(
            child: CircularProgressIndicator(),);
        }
      },
    );      
  }
}
