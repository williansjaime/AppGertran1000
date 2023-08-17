import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/DriveHomePage.dart';

class IfLogged{
    void verificarSeLogado(BuildContext context) async {
    SharedPreferences te = await SharedPreferences.getInstance();
    String? token_global111 = te.getString('token');

    if (token_global111 != "") {
      String? cccc = te.getString('cpf');
      print(token_global111);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => DriveHomePage(
                    cpfcnpj: cccc ?? "",
                  )),
          (Route<dynamic> route) => false);
    }
  }
}