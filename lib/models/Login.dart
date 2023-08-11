import 'package:flutter/material.dart';

class Login 
{
  //final int userId;
  //final String id;
  //final final String cnpjcpf;
  final int countSM;
  final int countchecklist;
  final bool senha;
  Login({
    //required this.userId,
    //required this.id,
    //required this.cnpjcpf,
    required this.countSM,
    required this.countchecklist,
    required this.senha,
    
  });

  factory Login.fromJson(Map<String, dynamic> json) 
  {
    return Login(
      //userId: json['userId'],
      //id: json['id'],
      //cnpjcpf: json['cnpjcpf'],
      senha: json['result'] as bool,
      countSM: json['countSM'] as int,
      countchecklist: json['countchecklist'] as int,
      
    );
  }
}

