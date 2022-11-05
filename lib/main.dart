import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pi1/Firebase/Construtor.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:projeto_pi1/servicos/notification_service.dart';
import 'package:projeto_pi1/servicos/firebase_messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  
  runApp(
    MultiProvider(
      providers: [
        Provider<NotificationService>(
          create: (context) => NotificationService(),
        ),
        Provider<FirebaseMessagingService>(
          create: (context) => FirebaseMessagingService(context.read<NotificationService>()),
        ),
      ],
      child: MyApp(),
    ),
  );
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
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
      scrollBehavior: AppScrollBehavior(),
      debugShowCheckedModeBanner: false,
      home: Construtor(),
    );
  }
}
