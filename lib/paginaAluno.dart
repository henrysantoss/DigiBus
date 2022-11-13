// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'dart:ui';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pi1/componentes/perfilAlunoMotorista.dart';
import 'componentes/perfilEstudante.dart';
import 'componentes/qrCodeEstudante.dart';

class paginaAluno extends StatefulWidget {
  String aluno;

  paginaAluno({
    required this.aluno,
  });

  @override
  State<paginaAluno> createState() => _paginaAlunoState(nomeAluno: aluno,);
}

class _paginaAlunoState extends State<paginaAluno> {
  String nomeAluno;
  _paginaAlunoState({
    required this.nomeAluno,
  });

  int meuIndex = 0;

  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        onPageChanged: (i){
          setState(() {
            meuIndex = i;
          });
        },
        children: [
          perfilEstudante(nomeAluno: nomeAluno,),
          qrCodeEstudante(),
          perfilAlunoMotorista(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        backgroundColor: Colors.white,
        color: Color.fromARGB(255, 11, 148, 64),
        animationDuration: Duration(milliseconds: 600),
        animationCurve: Curves.ease,
        index: meuIndex,
        onTap: (i) {
          _pageController.animateToPage(i, duration: Duration(milliseconds: 600), curve: Curves.ease);
        },
        items: [
          Icon(Icons.home),
          Icon(Icons.qr_code),
          Icon(Icons.directions_bus)
        ],
      ),
    );
  }
}
