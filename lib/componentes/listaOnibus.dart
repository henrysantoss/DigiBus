import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class listaOnibus extends StatelessWidget {
  const listaOnibus({super.key});

  @override
  Widget build(BuildContext context) {
    final bancoDeDados = FirebaseFirestore.instance;

    return SafeArea(child:
    StreamBuilder<QuerySnapshot>(
        stream: bancoDeDados.collection("Onibus").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Não há nenhum ônibus cadastrado no sistema."));
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
                  leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.directions_bus, color: Colors.black, size: 30),
                      ],
                  ),
                  title: Text(doc['nome'] ?? ''),
                  subtitle: RichText(text: TextSpan(
                      children: [
                        const TextSpan(text: "Status: ", style: TextStyle(color: Color.fromRGBO(136, 141, 146, 100))),
                        TextSpan(text: doc['status'] ?? '', style: TextStyle(color: doc['status'] == "Parado" ? Colors.red : Colors.green))
                      ])
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