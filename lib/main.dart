import 'dart:ui';

import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:projeto_pi1/telaLogin.dart';
=======
import 'package:projeto_pi1/paginaInicial.dart';
>>>>>>> 6c772efce93ec628b899a2df25bfcebd43200467

void main() {
  runApp(MyApp());
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: AppScrollBehavior(),
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      home: LoginScreen(),
=======
      home: paginaInicial(),
>>>>>>> 6c772efce93ec628b899a2df25bfcebd43200467
    );
  }
}
