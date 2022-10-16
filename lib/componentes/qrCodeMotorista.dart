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

class _QRCodePageState extends State<QRCodePage> {
  String ticket = '';

  readQRCode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
        "#FFFFFF", "Cancelar", true, ScanMode.QR);
    setState(() => ticket = code != '-1' ? code : 'Não Validado');
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