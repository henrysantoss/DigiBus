import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class qrCodeMotorista extends StatelessWidget {
  const qrCodeMotorista({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QRCODE',
      home: QRCodePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QRCodePage extends StatefulWidget {
  QRCodePage({Key? key}) : super(key: key);

  @override
  _QRCodePageState createState() => _QRCodePageState();
}

void insereAlunoLista(String ticket){
  final firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser =  FirebaseAuth.instance.currentUser;

  var idMotorista = firebaseUser?.uid;

  firestoreInstance.collection("Motorista").doc(idMotorista).collection("ListaAlunos").add({
    "nome": ticket
  });

  print(ticket);

}

class _QRCodePageState extends State<QRCodePage> {
  String ticket = '';

  readQRCode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
        "#FFFFFF", "Cancelar", true, ScanMode.QR);
    setState(() => {
      ticket = code != '-1' ? code : '-1'
    });
    readQRCode();
    insereAlunoLista(ticket);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (ticket != '')
                  Padding(
                    padding: EdgeInsets.only(bottom: 24.0),
                    child: Text(
                      'Ticket: $ticket',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ElevatedButton.icon(
                  onPressed: () => readQRCode(),
                  icon: Icon(Icons.qr_code),
                  label: Text('Validar'),
                )
              ],
            )));
  }
}