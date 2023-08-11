import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapsDrivePoints extends StatefulWidget {
  MapsDrivePoints({
    required this.placa,
    required this.latitude,
    required this.longitude,
    required this.datahora,
  });
  final String placa;
  final double latitude;
  final double longitude;
  final String datahora;

  @override
  State<MapsDrivePoints> createState() => _MapsDrivePointsState(
      placa: placa,
      latitude: latitude,
      longitude: longitude,
      datahora: datahora);
}

class _MapsDrivePointsState extends State<MapsDrivePoints> {
  _MapsDrivePointsState({
    required this.placa,
    required this.latitude,
    required this.longitude,
    required this.datahora,
  });

  final String placa;
  final double latitude;
  final double longitude;
  final String datahora;

  late GlobalKey<ScaffoldState> scaffoldKey;
  ValueNotifier<bool> zoomNotifierActivation = ValueNotifier(false);
  ValueNotifier<bool> visibilityZoomNotifierActivation = ValueNotifier(false);
  ValueNotifier<bool> advPickerNotifierActivation = ValueNotifier(false);
  ValueNotifier<bool> trackingNotifier = ValueNotifier(false);

  MapController mapController = MapController(
    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude: 0, longitude: 0),
    areaLimit: const BoundingBox.world(),
  );

  void initState() {
    super.initState();
    mapController = MapController(
      initMapWithUserPosition: false,
      initPosition: GeoPoint(latitude: latitude, longitude: longitude),
      areaLimit: const BoundingBox.world(),
    );

    scaffoldKey = GlobalKey<ScaffoldState>();
    mapController.listenerMapLongTapping.addListener(() {
      if (mapController.listenerMapLongTapping.value != null) {
        print(mapController.listenerMapLongTapping.value);
      }
    });

    mapController.listenerMapSingleTapping.addListener(() {
      if (mapController.listenerMapSingleTapping.value != null) {
        print(mapController.listenerMapSingleTapping.value);
      }
    });
    /*Future.delayed(Duration(seconds: 5), () async {
      await mapController.zoomIn();
    });*/
    Future.delayed(Duration(seconds: 5), () async {
      await mapController.changeLocation(
        GeoPoint(
          latitude: latitude,
          longitude: longitude,
        ),
      );
    });

    /*if(latitude != 0 && longitude != 0) 
    {
      mapController = MapController.withPosition(
                                  //initMapWithUserPosition: false,
                                  initPosition: GeoPoint(latitude: latitude, longitude: longitude),
                                  areaLimit: const BoundingBox.world(),
                              );
      Future.delayed(Duration(seconds: 12), () async {
      await mapController.changeLocation(
        GeoPoint(
          latitude: latitude,
          longitude: longitude,
        ),
      );});
    }
    else
    {
      Navigator.pop(context);
    }*/
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Localização do Veiculo"),
      ),
      body: Stack(
        children: <Widget>[
          OSMFlutter(
            controller: mapController,
            initZoom: 14,
            minZoomLevel: 2,
            markerOption: MarkerOption(
                defaultMarker: MarkerIcon(
              icon: Icon(
                Icons.local_shipping,
                color: Colors.blue,
                size: 56,
              ),
            )),
            isPicker: false,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 80,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Container(
                  color: Colors.blue,
                  width: 70,
                  height: 70,
                  child:
                      Icon(Icons.local_shipping, size: 60, color: Colors.white),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        placa +
                            "-" +
                            DateFormat('dd/MM/y hh:mm')
                                .format(DateTime.parse(datahora)),
                      ),
                      Text("Endereço do caminhão",
                          style: TextStyle(color: Colors.grey))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
