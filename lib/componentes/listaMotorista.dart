import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Firebase/Autenticador.dart';

class listaMotorista extends StatelessWidget {
  const listaMotorista({super.key});

  @override
  Widget build(BuildContext context) {
    final bancoDeDados = FirebaseFirestore.instance;

      return SafeArea(child:
        StreamBuilder<QuerySnapshot>(
          stream: bancoDeDados.collection("Motorista").doc(Autenticador().UsuarioAtual?.uid).collection("ListaAlunos").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("Não há alunos cadastrados no ônibus."));
            }

            return ListView(
              padding: const EdgeInsets.all(15.0),
              children: snapshot.data!.docs.map((doc) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10.0),
                    tileColor: Colors.blueGrey[50],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    leading: const Icon(Icons.person, color: Colors.black),
                    title: Text(doc['nome'] ?? ''),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, size: 20.0, color: Colors.black),
                      onPressed: () async {
                        final resultado = await showDialog<bool>(context: context, builder: (context) => AlertDialog(
                          title: const Text("Confirmação"),
                          content: const Text("Deseja realmente retirar o aluno da lista?"),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Confimar")),
                            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancelar")),
                          ],
                        ));

                        if (resultado == null || !resultado) return;

                        bancoDeDados.collection("Motorista").doc(Autenticador().UsuarioAtual?.uid).collection("ListaAlunos").doc(doc.id).delete();
                        bancoDeDados.collection("Aluno").doc(doc.id).update({"idMotorista": ""});
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          }
        )
      );
  }
}