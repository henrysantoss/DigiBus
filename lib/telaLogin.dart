import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_login/theme.dart';
import 'package:projeto_pi1/paginaAluno.dart';
import 'package:projeto_pi1/paginaMotorista.dart';
import 'package:projeto_pi1/Firebase/Autenticador.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? msgErro = '';
  String? login = '';
  List<String> getNome = [];
  String nomeAluno = '';
  String nomeMotorista = '';

  Duration get loginTime => Duration(milliseconds: 1150);

  String capitalize(String string) {
    if (string.isEmpty) {
      return string;
    }

    return string[0].toUpperCase() + string.substring(1);
  }

  Future<String?> _autorizarUsuario(LoginData data) async {
    try {
      await Autenticador().Login(
        email: data.name,
        senha: data.password,
      );
      
      setState(() {
        if (data.name.contains("@motorista")){
          login = "motorista";
          getNome = data.name.split("@");
          nomeMotorista = getNome[0].trim();
          nomeMotorista = capitalize(nomeMotorista);
        } else {
          login = "aluno";
          getNome = data.name.split("@");
          nomeAluno = getNome[0].trim();
          nomeAluno = capitalize(nomeAluno);
        }
      });

      return '';
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == "invalid-email") {
          msgErro = "Email Inválido";
        } else if (e.code == "wrong-password"){
          msgErro = "Senha Inválida";
        } else {
          msgErro = "Usuário não encontrado!";
        }
      });

      return msgErro;
    }
  }

  Future<String> _recuperarSenha(String nome) {
    print('Nome: $nome');
    return Future.delayed(loginTime).then((_) {
      return '';
    });
  }

  void RetornaLogin(String email){
    setState(() {
        if (email.contains("@motorista")){
          login = "motorista";
          getNome = email.split("@");
          nomeMotorista = getNome[0].trim();
          nomeMotorista = capitalize(nomeMotorista);
        } else {
          login = "aluno";
          getNome = email.split("@");
          nomeAluno = getNome[0].trim();
          nomeAluno = capitalize(nomeAluno);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
   var user = FirebaseAuth.instance.currentUser;
   if (user != null){
    RetornaLogin(user.email!);
    if (login == "aluno") {
          return paginaAluno(aluno: nomeAluno);
        } else if (login == "motorista") {
          return paginaMotorista(motorista: nomeMotorista);
        }
      return null!;
   } else {
    return FlutterLogin(
      logo: AssetImage('assets/imagens/iconeLogo.png'),
      title: 'DIGIBus',
      onLogin: _autorizarUsuario,
      theme: LoginTheme(
        primaryColor: Color.fromARGB(255, 11, 148, 64),
        buttonTheme: LoginButtonTheme(
          backgroundColor: Color.fromARGB(255,217,37,30),
        ),
      ),
      messages: LoginMessages(
        forgotPasswordButton: ' ',
        passwordHint: 'Senha',
        loginButton: 'Acessar',
        userHint: 'Email',
        recoverPasswordDescription: 'Mandaremos um email para confirmação',
        recoverPasswordIntro: 'Recupere sua Senha!',
        recoverPasswordButton: 'Recuperar',
        goBackButton: 'Voltar',
      ),
      userValidator: (value) {
        if(!value!.contains("@")) {
          return "Email Inválido";
        }
      },
      passwordValidator: (value) {
        if (value!.isEmpty) {
          return "Senha Inválida";
        }},
      footer: "Copyright (c) 2022 - Projeto Integrador I",
      hideForgotPasswordButton: true,
      onSubmitAnimationCompleted: () {
        if (login == "aluno") {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => paginaAluno(
              aluno: nomeAluno,
            ),
          ));
        } else if (login == "motorista") {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => paginaMotorista(
              motorista: nomeMotorista,
            ),
          ));
        }
      }, onRecoverPassword: (String ) {  },
    );
   }
  }
}