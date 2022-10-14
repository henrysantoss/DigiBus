// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'dart:ui';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'componentes/listaMotorista.dart';
import 'componentes/qrCodeMotorista.dart';

class paginaMotorista extends StatefulWidget {
  @override
  State<paginaMotorista> createState() => _paginaMotoristaState();
}

class _paginaMotoristaState extends State<paginaMotorista> {
  List<Widget> Paginas = [
    listaMotorista(),
    qrCodeMotorista(),
  ];
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
          Icon(Icons.list),
          Icon(Icons.qr_code),
        ],
      ),
    );
  }
}
