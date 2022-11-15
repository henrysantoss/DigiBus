import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_beep/flutter_beep.dart';

import '../Firebase/Autenticador.dart';

class qrCodeMotorista extends StatelessWidget {
  const qrCodeMotorista({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: QRViewExample());
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  var acaoValida;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void lerQrCodeEInserirNaLista() async {
    if (result != null) {
      final codigoQrCode = result?.code;
      final firestoreInstance = FirebaseFirestore.instance;
      final idMotorista = Autenticador().UsuarioAtual?.uid;

      var aluno = await firestoreInstance.collection("Aluno").doc(result!.code).get();

      if (aluno.exists) {
        var nomeAluno = aluno.get('nome');

        final docAluno = await firestoreInstance.collection("Motorista").doc(idMotorista).collection("ListaAlunos").doc(codigoQrCode).get();

        if (!docAluno.exists) {
          acaoValida = true;
          firestoreInstance.collection("Motorista").doc(idMotorista).collection("ListaAlunos").doc(codigoQrCode).set({
            "nome": nomeAluno
          });
          firestoreInstance.collection("Aluno").doc(codigoQrCode).update({"idMotorista": idMotorista});
          FlutterBeep.beep();
        } else {
          acaoValida = false;
          FlutterBeep.beep(false);
        }
      } else {
        acaoValida = false;
      }

      result = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    lerQrCodeEInserirNaLista();
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 10, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.all(8),
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                if (snapshot.data == true) {
                                  return IconButton(
                                      onPressed: () async {
                                        await controller?.toggleFlash();
                                        setState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.flash_off,
                                        size: 30,
                                        color: Colors.black,
                                      ));
                                } else {
                                  return IconButton(
                                      onPressed: () async {
                                        await controller?.toggleFlash();
                                        setState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.flash_on,
                                        size: 30,
                                        color: Colors.black,
                                      ));
                                }
                              },
                            )),
                        Container(
                            margin: const EdgeInsets.all(8),
                            child: IconButton(
                                onPressed: () async {
                                  await controller?.flipCamera();
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.flip_camera_android,
                                  size: 30,
                                  color: Colors.black,
                                ))),
                      ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 450.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: acaoValida == null ? Colors.white : acaoValida ? Colors.green : Colors.red,
          borderRadius: 10,
          borderLength: 190,
          borderWidth: 20,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sem permissão'))
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
