import 'dart:io';
import 'dart:async';
import 'dart:convert';
import '../models/Login.dart';
import 'HomePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apptestewillians/pages/DriveHomePage.dart';
import 'package:mask_shifter/mask_shifter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}

Future<Login> fetchLogin(final String cnpjcpf) async {
  String ipexterno = 'gertranapi.hopto.org';
  String ipinterno = '192.168.34.7';

  Uri uri = Uri(
      scheme: 'https',
      port: 5000,
      host: Platform.isLinux ? ipinterno : ipexterno,
      path: '/users/$cnpjcpf');

  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  try {
    http.Response response = await http.get(uri, headers: headers)
    .timeout(
        const Duration(seconds: 20),
            onTimeout: () {
              return http.Response('Error', 408);
            },);
    if (response.statusCode == 200) {
      print(response.body);
      return Login.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Login');
    }
  } catch (e) {
    return throw Exception(e);
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var controller = new TextEditingController();
  Color cor = Color.fromARGB(255, 0, 100, 220);
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("ERRO CPF/CNPJ"),
          content: new Text("Favor digitar CPF/CNPJ valido!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height, //para altura
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/imgfundoGertran01.jpeg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height, //para altura
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Center(
                      child: Container(
                          width: 200,
                          height: 150,
                          /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),
                    */
                          child: Image.asset('assets/images/logogertran.png')),
                    ),
                  ),
                  Divider(),
                  Padding(
                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'CPF/CNPJ',
                            hintText: 'Digite seu CPF/CNPJ'),
                        controller: controller,
                        inputFormatters: [
                          MaskedTextInputFormatterShifter(
                              maskONE: "XXX.XXX.XXX-XX",
                              maskTWO: "XX.XXX.XXX/XXXX-XX"),
                        ],
                        keyboardType: TextInputType.number),

                    //CNPJValidator.isValid()
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    //padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          labelText: 'Senha',
                          hintText: 'Digite sua senha'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //TODO FORGOT PASSWORD SCREEN GOES HERE
                    },
                    child: Text(
                      'Não sabe a Senha? Favor entrar em contato com a Gertran',
                      style: TextStyle(color: cor, fontSize: 10),
                    ),
                  ),
                  Divider(),
                  Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                        color: cor, borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () {


                        // Navigator.of(context).pushAndRemoveUntil(
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             LoginValidate(cnpj: '')),
                        //     (Route<dynamic> route) => false);

                        if (controller.text.length == 14 ||
                            controller.text.length == 18) {
                          var filter = (((controller.text.replaceAll(".", ""))
                                      .replaceAll(".", ""))
                                  .replaceAll(".", ""))
                              .replaceAll("-", "");
                          final exp = RegExp(r"/");
                          if (exp.hasMatch(filter)) {
                            filter = filter.replaceAll("/", "");
                          }
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginValidate(cnpj: filter)),
                              (Route<dynamic> route) => false);
                        } else {
                          _showDialog();
                        }
                      },
                      child: Text(
                        'Entrar',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                  /*Column( 
              mainAxisAlignment: MainAxisAlignment.end,
               children: <Widget>[
              TextButton(onPressed: (){}, child: Text('Novo usuário? Criar conta', style: TextStyle(color: Colors.white)
              ),
              ),
              ]
            ),*/
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LoginValidate extends StatelessWidget {
  LoginValidate({super.key, required this.cnpj});

  final String cnpj;
  Future<Login>? futureLogin;

  @override
  void initState() {
    futureLogin = fetchLogin(cnpj);
  }
  //HomePage() DriveHomePage()

  @override
  Widget build(BuildContext context) {
    initState();
    void _showDialog() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("ERRO CPF/CNPJ"),
            content: new Text("Favor digitar CPF/CNPJ valido!"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new TextButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return FutureBuilder<Login>(
        future: futureLogin,
        builder: (context, snapshot) {

          if (snapshot.hasError)
          {
            return  DriveHomePage();//const LoginPage();
          }
          else if(snapshot.hasData){
                return snapshot.data!.senha ==true ? HomePage(HomecountSM: snapshot.data!.countSM,Homecountchecklist: snapshot.data!.countchecklist,cnpj: cnpj) : DriveHomePage();
              }else {
                return Center(
                  child: CircularProgressIndicator(),);
          }
        });
  }
}
