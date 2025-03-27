import 'dart:io';
import 'dart:convert'; // Para jsonEncode y jsonDecode
import 'package:flutter/material.dart';
import 'package:gestor_de_contrasenas/models/account_model.dart';
import 'package:path_provider/path_provider.dart';

class AccountProvider extends ChangeNotifier {
  List<Account> _accounts = [];

  List<Account> get accounts => _accounts;

  void addAccount(
      String name,String username, String password, String email, String phone) {
    _accounts.add(Account(

        name: name,user: username, password: password, email: email, phone: phone));
    saveAccounts(); // Guardar automáticamente al agregar
    notifyListeners();
  }

  /// Cargar cuentas desde el archivo JSON
  Future<void> loadAccounts() async {
    try {
      final Directory appDocumentsDir =
          await getApplicationDocumentsDirectory();
      final File file = File('${appDocumentsDir.path}/accounts.json');

      if (await file.exists()) {
        String content = await file.readAsString();
        List<dynamic> jsonList = jsonDecode(content);

        _accounts = jsonList.map((json) => Account.fromJson(json)).toList();
        notifyListeners();
      }
    } catch (e) {
      print("Error al cargar cuentas: $e");
    }
  }

  /// Guardar cuentas en un archivo JSON
  Future<void> saveAccounts() async {
    try {
      final Directory appDocumentsDir =
          await getApplicationDocumentsDirectory();
      final File file = File('${appDocumentsDir.path}/accounts.json');

      String jsonContent =
          jsonEncode(_accounts.map((a) => a.toJson()).toList());
      await file.writeAsString(jsonContent);
    } catch (e) {
      print("Error al guardar cuentas: $e");
    }
  }
}
