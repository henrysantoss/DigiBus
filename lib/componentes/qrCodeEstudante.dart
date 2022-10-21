// ignore_for_file: prefer_const_constructors

import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pi1/Firebase/Autenticador.dart';

class qrCodeEstudante extends StatelessWidget {
  const qrCodeEstudante({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/imagens/fundo_qrcode.png"
                  ),
                  fit: BoxFit.fill
                )
              ),
            child: Container(
              width: double.infinity,
              height: 200,
              child: Container(
                alignment: Alignment(0.0,2.5),
              ),
            ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Leitor QR Code"
              ,style: TextStyle(
                fontSize: 25.0,
                color:Colors.blueGrey,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w400
            ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Center(
          heightFactor: 1,
          child: QrImage(
                        data: Autenticador().UsuarioAtual!.uid,
                        version: QrVersions.auto,
                        size: 350.0,
                      ),
        ),
          ],
        ),
      );
  }
}
