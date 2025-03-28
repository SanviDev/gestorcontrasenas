import 'package:flutter/material.dart';
import 'package:gestor_de_contrasenas/widget/list.dart';
import 'package:gestor_de_contrasenas/widget/new_account.dart';

class ListAccounts extends StatelessWidget {
  const ListAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Listado de cuentas',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: const ListWidget(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          // Crear los controladores antes de pasarlos
          final nController = TextEditingController();
          final uController = TextEditingController();
          final pController = TextEditingController();
          final eController = TextEditingController();
          final tController = TextEditingController();

          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return ShowModalNewApp(
                nCont: nController,
                uCont: uController,
                pCont: pController,
                eCont: eController,
                tCont: tController,
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
