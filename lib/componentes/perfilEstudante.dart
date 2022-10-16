// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projeto_pi1/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projeto_pi1/Firebase/Autenticador.dart';

class perfilEstudante extends StatelessWidget {
  String nomeAluno = '';

  perfilEstudante({
    required this.nomeAluno,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('Aluno').doc(Autenticador().UsuarioAtual?.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        String dbNome = data['nome'] ?? "";
        String dbData = data['data']?? "";
        String dbFoto = data['foto']?? "";
        String dbLocalidade = data['localidade']?? "";
        String dbTurno = data['turno']?? "";
        String dbCpf = data['cpf']?? "";
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/imagens/fundo_profile.png"
                      ),
                      fit: BoxFit.fill
                    )
                  ),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  child: Container(
                    alignment: Alignment(0.0,2.5),
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
                  dbNome
                  ,style: TextStyle(
                    fontSize: 25.0,
                    color:Colors.blueGrey,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w400
                ),
                ),
                Text(
                  "Estudante"
                  ,style: TextStyle(
                    fontSize: 15.0,
                    color:Colors.black45,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  dbLocalidade
                  ,style: TextStyle(
                    fontSize: 18.0,
                    color:Colors.black45,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300
                ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Data de Nascimento: "+ dbData
                  ,style: TextStyle(
                    fontSize: 18.0,
                    color:Colors.black45,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300
                ),
                ),
                Text(
                  "CPF: " + dbCpf
                  ,style: TextStyle(
                    fontSize: 18.0,
                    color:Colors.black45,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300
                ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Turno: " + dbTurno
                  ,style: TextStyle(
                    fontSize: 18.0,
                    color:Colors.black45,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w400
                  ),
                ),
                Text(
                  "Ano Letivo: 2022"
                  ,style: TextStyle(
                    fontSize: 18.0,
                    color:Colors.black45,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w400
                  ),
                ),
                Text(
                  "Situação: ATIVO"
                  ,style: TextStyle(
                    fontSize: 18.0,
                    color:Colors.black45,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          )
        );
      } else {
        return Column();
      }
      }
    );
  }
}