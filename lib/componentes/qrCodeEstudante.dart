// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class qrCodeEstudante extends StatelessWidget {
  const qrCodeEstudante({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
            Center(
          heightFactor: 1,
=======
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
              "Leitor QR Code"
              ,style: TextStyle(
                fontSize: 25.0,
                color:Color.fromARGB(255, 0, 0, 0),
                letterSpacing: 2.0,
                fontWeight: FontWeight.w400,
            ),
        ),
        Center(
          heightFactor: 1.9,
>>>>>>> 6c772efce93ec628b899a2df25bfcebd43200467
          child: Column(
            children: [
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/imagens/qrcode_teste.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
<<<<<<< HEAD
          ],
        ),
      );
=======
      ],
    );
>>>>>>> 6c772efce93ec628b899a2df25bfcebd43200467
  }
}
