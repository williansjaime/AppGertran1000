/*import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';

class LocationPosition {
  //final now2 = DateTime.now();
  Position? _currentPosition;
  String? _currentAddress;
  

  void locatePosition() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    
    _currentPosition = position;
    final now2 = DateTime.now();
    print(now2);
    print(_currentPosition);
  }
 
  void gerarPosition(){
    locatePosition();
  }
  
} */
 

