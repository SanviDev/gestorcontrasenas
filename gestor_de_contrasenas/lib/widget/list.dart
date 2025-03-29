import 'package:flutter/material.dart';
import 'package:gestor_de_contrasenas/providers/account_provider.dart';
import 'package:gestor_de_contrasenas/screens/description.dart';
import 'package:provider/provider.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            Provider.of<AccountProvider>(context, listen: false).loadAccounts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          return Consumer<AccountProvider>(builder: (context, provider, child) {
            if (provider.accounts.isEmpty) {
              return const Center(
                child: Text("Aquí estarán sus cuentas"),
              );
            }

            return ListView.builder(
                itemCount: provider.accounts.length,
                itemBuilder: (context, index) {
                  final account = provider.accounts[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsAccount(account: account),
                          ),
                        );
                      },
                      child: Card(
                        child: SizedBox(
                          width: double.infinity,
                          height: 120,
                          child: Center(
                            child: Text(
                              account.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          });
        });
  }
}
