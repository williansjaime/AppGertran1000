// import 'dart:io';
import 'package:apptestewillians/services/background_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../pages/login.page.dart';
import 'pages/PrivacyPolicyScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.removeAfter(inicialization);
  // HttpOverrides.global = new MyHttpOverrides();

  runApp(AppGertran());
}

Future inicialization(BuildContext? context) async {
  await Future.delayed(Duration(seconds: 3));
}

// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext   context)
//   {
//     String ipexterno = 'gertranapi.hopto.org';
//     String ipinterno =  '192.168.34.7';
//     int port = 5000;
//     return super.createHttpClient(context)
//       ..badCertificateCallback = ((X509Certificate cert, String host, port)
//       {
//         final isValidHost = [Platform.isLinux? ipinterno: ipexterno,].contains(host);
//         return isValidHost;
//       });
//   }
// }

class AppGertran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gertran',
      home: LoginPage(),
    );
  }
}
