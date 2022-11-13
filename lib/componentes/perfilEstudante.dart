// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projeto_pi1/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projeto_pi1/Firebase/Autenticador.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_pi1/telaLogin.dart';

class perfilEstudante extends StatelessWidget {
  String nomeAluno = '';

  perfilEstudante({
    required this.nomeAluno,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Aluno')
            .doc(Autenticador().UsuarioAtual?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            String dbNome = data['nome'] ?? "";
            String dbData = data['data'] ?? "";
            String dbFoto = data['foto'] ?? "";
            String dbLocalidade = data['localidade'] ?? "";
            String dbTurno = data['turno'] ?? "";
            String dbCpf = data['cpf'] ?? "";
            return SafeArea(
              child: Scaffold(
              extendBodyBehindAppBar: true,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      LoginScreen();
                    },
                  ),
                ),
              body: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/imagens/fundo_profile.png"),
                            fit: BoxFit.fill)),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      child: Container(
                        alignment: Alignment(0.0, 2.5),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            dbFoto,
                          ),
                          radius: 60.0,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    dbNome,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        color: Color.fromARGB(255, 30, 39, 43),
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "Estudante",
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black45,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.house,
                          color: Colors.teal,
                        ),
                        title: Text(
                          dbLocalidade,
                          style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              fontSize: 20,
                              color: Colors.teal.shade900),
                        ),
                      ),
                    ),
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        elevation: 0.5,
                        title: const Text('Localidade'),
                        content: Text(
                          dbLocalidade,
                          style: TextStyle(
                            fontSize: 20
                          ),
                          ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.teal,
                        ),
                        title: Text(
                          dbData,
                          style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              fontSize: 20,
                              color: Colors.teal.shade900),
                        ),
                      ),
                    ),
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        elevation: 0.5,
                        title: const Text('Data de Nascimento'),
                        content: Text(
                          dbData,
                          style: TextStyle(
                            fontSize: 20
                          ),
                          ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.chrome_reader_mode_rounded,
                          color: Colors.teal,
                        ),
                        title: Text(
                          dbCpf,
                          style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              fontSize: 20,
                              color: Colors.teal.shade900),
                        ),
                      ),
                    ),
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        elevation: 0.5,
                        title: const Text('CPF'),
                        content: Text(
                          dbCpf,
                          style: TextStyle(
                            fontSize: 20
                          ),
                          ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.more_time,
                          color: Colors.teal,
                        ),
                        title: Text(
                          dbTurno + ' de 2022',
                          style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              fontSize: 20,
                              color: Colors.teal.shade900),
                        ),
                      ),
                    ),
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        elevation: 0.5,
                        title: const Text('Turno e Ano'),
                        content: Text(
                          dbTurno + ' de 2022',
                          style: TextStyle(
                            fontSize: 20
                          ),
                          ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.check_box,
                          color: Colors.teal,
                        ),
                        title: Text(
                          'ATIVO',
                          style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              fontSize: 20,
                              color: Colors.teal.shade900),
                        ),
                      ),
                    ),
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        elevation: 0.5,
                        title: const Text('Situação'),
                        content: Text(
                          'ATIVO',
                          style: TextStyle(
                            fontSize: 20
                          ),
                          ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
              );
          } else {
            return Column();
          }
        });
  }
}
