import 'package:flutter/material.dart';
import 'package:gestor_de_contrasenas/models/account_model.dart';
import 'package:gestor_de_contrasenas/providers/account_provider.dart';

class ShowModalNewApp extends StatelessWidget {
  final TextEditingController nCont;
  final TextEditingController uCont;
  final TextEditingController pCont;
  final TextEditingController eCont;
  final TextEditingController tCont;

  const ShowModalNewApp({
    super.key,
    required this.nCont,
    required this.uCont,
    required this.pCont,
    required this.eCont,
    required this.tCont,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Añadir nueva cuenta',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: nCont,
            decoration: const InputDecoration(
              labelText: 'Nombre de la aplicación',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: uCont,
            decoration: const InputDecoration(
              labelText: 'Usuario',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: pCont,
            decoration: const InputDecoration(
              labelText: 'Contraseña',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: eCont,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: tCont,
            decoration: const InputDecoration(
              labelText: 'Teléfono',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              if (nCont.text.isEmpty ||
                  uCont.text.isEmpty ||
                  pCont.text.isEmpty ||
                  eCont.text.isEmpty ||
                  tCont.text.isEmpty) {
                nCont.clear();
                uCont.clear();
                pCont.clear();
                eCont.clear();
                tCont.clear();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Error'),
                    content: const Text('Todos los campos son obligatorios.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cerrar'),
                      ),
                    ],
                  ),
                );
              }else {
              final Account newAccount = Account(
                  name: nCont.text,
                  user: uCont.text,
                  password: pCont.text,
                  email: eCont.text,
                  phone: tCont.text);
              AccountProvider().addAccount(newAccount.name, newAccount.user,
                  newAccount.password, newAccount.email, newAccount.phone);
              Navigator.pop(context);
              }

            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
