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

  Duration get loginTime => Duration(milliseconds: 1150);

  Future<String?> _autorizarUsuario(LoginData data) async {
    try {
      await Autenticador().Login(
        email: data.name,
        senha: data.password,
      );
      
      setState(() {
        if (data.name.contains("@motorista")){
          login = "motorista";
        } else {
          login = "aluno";
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
    };
  }

  Future<String> _recuperarSenha(String nome) {
    print('Nome: $nome');
    return Future.delayed(loginTime).then((_) {
      return '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'DIGIBus',
      onLogin: _autorizarUsuario,
      theme: LoginTheme(
        primaryColor: Color.fromARGB(255, 11, 148, 64),
        buttonTheme: LoginButtonTheme(
          backgroundColor: Color.fromARGB(255,217,37,30),
        ),
        
      ),
      messages: LoginMessages(
        forgotPasswordButton: 'Esqueceu sua senha?',
        passwordHint: 'Senha',
        loginButton: 'Acessar',
        userHint: 'Email',
        recoverPasswordDescription: 'Mandaremos um email para confirmação',
        recoverPasswordIntro: 'Recupere sua Senha!',
        recoverPasswordButton: 'Recuperar',
        goBackButton: 'Voltar',
      ),
      onSubmitAnimationCompleted: () {
        if (login == "aluno") {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => paginaAluno(),
          ));
        } else if (login == "motorista") {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => paginaMotorista(),
          ));
        }
      }, onRecoverPassword: _recuperarSenha,
    );
  }
}