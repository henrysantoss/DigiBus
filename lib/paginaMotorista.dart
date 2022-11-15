// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'dart:ui';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pi1/componentes/perfilMotorista.dart';
import 'componentes/listaMotorista.dart';
import 'componentes/qrCodeMotorista.dart';

class paginaMotorista extends StatefulWidget {
  String motorista;

  paginaMotorista({
    required this.motorista
  });
  
  @override
  State<paginaMotorista> createState() => _paginaMotoristaState(nomeMotorista: motorista);
}

class _paginaMotoristaState extends State<paginaMotorista> {
  String nomeMotorista;

  _paginaMotoristaState({
    required this.nomeMotorista
  });

  int meuIndex = 0;

  final PageController _pageController = PageController(initialPage: 0);

  // List<Widget> Paginas = [
  //   perfilMotorista(nomeMotorista: nomeMotorista,),
  //   listaMotorista(),
  //   qrCodeMotorista(),
  // ];

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
          perfilMotorista(nomeMotorista: nomeMotorista),
          listaMotorista(),
          qrCodeMotorista(),
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
          Icon(Icons.list),
          Icon(Icons.qr_code),
        ],
      ),
    );
  }
}
