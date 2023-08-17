import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/DriveHomePage.dart';

class IfLogged{
    void verificarSeLogado(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token') ?? "";

    if (token != "") {
      String? cpf = sharedPreferences.getString('cpf');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => DriveHomePage(
                    cpfcnpj: cpf ?? "",
                  )),
          (Route<dynamic> route) => false);
    }
  }
}