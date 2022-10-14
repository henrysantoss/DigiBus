import 'package:firebase_auth/firebase_auth.dart';

class Autenticador{
  final FirebaseAuth _autenticador = FirebaseAuth.instance;

  User? get UsuarioAtual => _autenticador.currentUser;

  Stream<User?> get MudancasAutenticador => _autenticador.authStateChanges();

  Future<void> Login({
    required String email,
    required String senha,
  }) async {
    await _autenticador.signInWithEmailAndPassword(
      email: email,
      password: senha,
    );
  }
}