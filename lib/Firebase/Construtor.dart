import 'package:projeto_pi1/Firebase/Autenticador.dart';
import 'package:projeto_pi1/telaLogin.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pi1/servicos/notification_service.dart';
import 'package:projeto_pi1/servicos/firebase_messaging.dart';
import 'package:provider/provider.dart';

class Construtor extends StatefulWidget {
  const Construtor({Key? key}) : super(key: key);

  @override
  State<Construtor> createState() => _ConstrutorState();
}

class _ConstrutorState extends State<Construtor> {
  @override
  void initState() {
    super.initState();
    initilizeFirebaseMessaging();
    checkNotifications();
  }

  initilizeFirebaseMessaging() async {
    await Provider.of<FirebaseMessagingService>(context, listen: false).initialize();
  }

  checkNotifications() async {
    await Provider.of<NotificationService>(context, listen: false).checkForNotifications();
  }

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Autenticador().MudancasAutenticador,
      builder: (context, snapshot) {
        return LoginScreen();
      },
    );
  }
}