import 'package:flutter/material.dart';
import 'package:gestor_de_contrasenas/providers/account_provider.dart';

import 'package:provider/provider.dart';

class ListWidget extends StatefulWidget {
  const ListWidget({super.key});

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AccountProvider().loadAccounts(),
        builder: (context, snapshot) {
          final accounts = AccountProvider().accounts;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.deepPurple,
            ));
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error, ${snapshot.error}",
                style: TextStyle(color: Colors.redAccent, fontSize: 18),
              ),
            );
          }
          return Consumer(
            builder: (context, value, child) {
              if (accounts.isEmpty) {
                return Center(
                  child: Text("Aquí estarán sus cuentas..."),
                );
              }
              return ListView.builder(
                  itemCount: accounts.length,
                  itemBuilder: (context, index) {
                    final account = accounts[index];
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        child: Container(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              account.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            },
          );
        });
  }
}
