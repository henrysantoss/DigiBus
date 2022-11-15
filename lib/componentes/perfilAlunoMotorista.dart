// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projeto_pi1/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projeto_pi1/Firebase/Autenticador.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_pi1/telaLogin.dart';

class perfilAlunoMotorista extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      final bancoDeDados = FirebaseFirestore.instance;
      return SafeArea(child:
    StreamBuilder<DocumentSnapshot>(
        stream: bancoDeDados.collection('Aluno').doc(Autenticador().UsuarioAtual?.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data!["idMotorista"].isEmpty){
            return Center(child: Text("Não está cadastrado em nenhuma lista de ônibus."));
          } else {
            return Center(child: Text("Isaque - Acabar esta parte."));
          }
        }
    )
    );
  }
}
