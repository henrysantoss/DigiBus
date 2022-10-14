import 'package:projeto_pi1/Firebase/Autenticador.dart';
import 'package:projeto_pi1/telaLogin.dart';
import 'package:flutter/material.dart';

class Construtor extends StatefulWidget {
  const Construtor({Key? key}) : super(key: key);

  @override
  State<Construtor> createState() => _ConstrutorState();
}

class _ConstrutorState extends State<Construtor> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Autenticador().MudancasAutenticador,
      builder: (context, snapshot) {
        return LoginScreen();
      },
    );
  }
}