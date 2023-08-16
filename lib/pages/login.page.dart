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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var cpfcnpj = new TextEditingController();
  var senha = new TextEditingController();
  Color cor = Color.fromARGB(255, 0, 100, 220);
  bool tipoUsuario = false;

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("ERRO CPF/CNPJ"),
          content: new Text("Favor digitar CPF/CNPJ e senha valido!"),
          actions: <Widget>[
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
                          child: Image.asset('assets/images/logogertran.png')),
                    ),
                  ),
                  Divider(),
                  if (tipoUsuario == false)
                    Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          color: cor, borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            tipoUsuario = true;
                          });
                        },
                        child: Text(
                          'Motorista',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  Divider(),
                  Divider(),
                  if (tipoUsuario == false)
                    Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          color: cor, borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            tipoUsuario = true;
                          });
                        },
                        child: Text(
                          'Cliente',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  if (tipoUsuario == true)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'CPF',
                              hintText: 'Digite seu CPF/CNPJ'),
                          controller: this.cpfcnpj,
                          inputFormatters: [
                            MaskedTextInputFormatterShifter(
                                maskONE: "XXX.XXX.XXX-XX",
                                maskTWO: "XX.XXX.XXX/XXXX-XX"),
                          ],
                          keyboardType: TextInputType.number),
                    ),
                  if (tipoUsuario == true)
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15, bottom: 0),
                      child: TextField(
                          style: TextStyle(color: Colors.black),
                          obscureText: true,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              labelText: 'Senha',
                              hintText: 'Digite sua senha'),
                          controller: this.senha,
                          keyboardType: TextInputType.number),
                    ),
                  if (tipoUsuario == true)
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
                  if (tipoUsuario == true)
                    Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          color: cor, borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: () {
                          if (cpfcnpj.text.length == 14 ||
                              cpfcnpj.text.length == 18) {
                            var filter = (((cpfcnpj.text.replaceAll(".", ""))
                                        .replaceAll(".", ""))
                                    .replaceAll(".", ""))
                                .replaceAll("-", "");
                            final exp = RegExp(r"/");
                            if (exp.hasMatch(filter)) {
                              filter = filter.replaceAll("/", "");
                            }
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => LoginValidate(
                                        cpfcnpj: filter, senha: senha.text)),
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
                  Divider(),
                  if (tipoUsuario == true)
                    Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 165, 33, 66),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            tipoUsuario = false;
                          });
                        },
                        child: Text(
                          'Voltar',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
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
  LoginValidate({super.key, required this.cpfcnpj, required this.senha});

  final String cpfcnpj;
  final String senha;
  late String token = "";
  Future<Login>? futureLogin;

  Future<Login> fetchLogin(final String cnpjcpf, final String senha) async {
    String url = '';
    if (true) {
      //print('cnpj');
      url = 'https://api.gertran.zayit.com.br/v1/drivers/mobile/login/';
    } else {
      url = 'https://api.gertran.zayit.com.br/v1/drivers/mobile/login/';
      //print('cpf');
    }

    Map<String, String> data = {
      'cpf': cnpjcpf, //cnpjcpf,
      'password': senha //,
    };
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: data,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        token = json.decode(response.body)["access_token"];
        saveToken(token);
        print("Salve Token OK");
      } else {
        throw Exception('Failed to load Login');
      }
      return Login.fromJson(json.decode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void initState() {
    futureLogin = fetchLogin(cpfcnpj, senha);
  }
  //HomePage() DriveHomePage()

  @override
  Widget build(BuildContext context) {
    initState();
    void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("ERRO CPF/CNPJ"),
            content: new Text("Favor digitar CPF/CNPJ  e senha valido!"),
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
        //saveToken('teste123');
        //return HomePage(HomecountSM: 10, Homecountchecklist: 15, cnpj: cpfcnpj);

        // if (validateCNPJ(cpfcnpj)) {
        //   print('cnpj');
        // } else {
        //   print('cpf');
        // }

        if (snapshot.hasError) {
          return const LoginPage(); /*DriveHomePage(
            cpfcnpj: cpfcnpj,
            token: token,
          ); */ //
        } else if (snapshot.hasData) {
          if (false) {
            return HomePage(
                HomecountSM: snapshot.data!.countSM,
                Homecountchecklist: snapshot.data!.countchecklist,
                cnpj: cpfcnpj);
          } else {
            return DriveHomePage(
              cpfcnpj: cpfcnpj,
            );
          }

          //snapshot.data!.token != ""?
          /*? HomePage(
                  HomecountSM: snapshot.data!.countSM,
                  Homecountchecklist: snapshot.data!.countchecklist,
                  cnpj: cnpj)*/
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}




                  /*Column( 
              mainAxisAlignment: MainAxisAlignment.end,
               children: <Widget>[
              TextButton(onPressed: (){}, child: Text('Novo usuário? Criar conta', style: TextStyle(color: Colors.white)
              ),
              ),
              ]
            ),*/