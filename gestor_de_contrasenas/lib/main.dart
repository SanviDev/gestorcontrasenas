import 'package:flutter/material.dart';
import 'package:gestor_de_contrasenas/screens/home_page.dart';
import 'package:gestor_de_contrasenas/providers/account_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          AccountProvider()..loadAccounts(), // Cargar cuentas al inicio
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de Contraseñas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Ingrese su contraseña',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                ),
                obscureText: true,
                controller: passController,
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (passController.text == 'miscuentas') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListAccounts()),
                    );
                  } else {
                    passController.clear();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Contraseña incorrecta'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cerrar'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('Entrar'),
              ),
            ],
          ),
        
        ),
       
        );
  }
}
