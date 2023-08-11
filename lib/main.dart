// @dart=2.9
import 'dart:io';
import 'package:flutter/material.dart';
import '../pages/login.page.dart';
void main() async {  
  HttpOverrides.global = new MyHttpOverrides();
  runApp(AppGertran());
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext   context)
  {
    String ipexterno = 'gertranapi.hopto.org';
    String ipinterno =  '192.168.34.7';
    int port = 5000;
    return super.createHttpClient(context)
      ..badCertificateCallback = ((X509Certificate cert, String host, port) 
      {        
        final isValidHost = [Platform.isLinux? ipinterno: ipexterno,].contains(host); 
        return isValidHost;
      });
  }
}

class AppGertran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //initState();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gertran',
      theme: ThemeData(
        //primarySwatch: Color.fromARGB(255, 0, 146, 220),
      ),
      home: LoginPage(), 
    );
  }
}

