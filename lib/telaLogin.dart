import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_login/theme.dart';
import 'package:projeto_pi1/paginaInicial.dart';
 
const users = const {
  'isaque@teste.com': '1234',
  'motorista@teste.com': '12345',
};
 
class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 1150);
 
  Future<String> _autorizarUsuario(LoginData data) {
    print('Nome: ${data.name}, Senha: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Usuário não Existe';
      }
      if (users[data.name] != data.password) {
        return 'Senha não é válida';
      }
      return '';
    });
  }
 
  Future<String> _recuperarSenha(String nome) {
    print('Nome: $nome');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(nome)) {
        return 'Usuário não Existe';
      }
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
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => paginaInicial(),
        ));
      }, onRecoverPassword: _recuperarSenha,
    );
  }
}