import 'dart:io';
import 'dart:convert'; // Para jsonEncode y jsonDecode
import 'package:flutter/material.dart';
import 'package:gestor_de_contrasenas/models/account_model.dart';
import 'package:path_provider/path_provider.dart';

class AccountProvider extends ChangeNotifier {
  List<Account> _accounts = [];

  List<Account> get accounts => _accounts;

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/accounts.json");
  }

  /// Cargar cuentas desde el archivo JSON
  Future<void> loadAccounts() async {
    try {
      final file = await _getFile();
      if (!await file.exists()) {
        debugPrint("Archivo JSON no encontrado, iniciando lista vacía.");
        return;
      }
      final data = await file.readAsString();
      if (data.isNotEmpty) {
        final List<dynamic> jsonData = jsonDecode(data);
        _accounts = jsonData.map((t) => Account.fromJson(t)).toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error al cargar datos: $e");
    }
  }

  /// Agregar una cuenta sin sobrescribir la lista
  Future<void> addAccount(String name, String username, String password,
      String email, String phone) async {
    await loadAccounts(); // Cargar las cuentas antes de modificar la lista

    _accounts.add(Account(
        name: name,
        user: username,
        password: password,
        email: email,
        phone: phone));

    saveAccounts(); // Guardar automáticamente al agregar
  }

  /// Guardar cuentas en un archivo JSON
  Future<void> saveAccounts() async {
    try {
      final file = await _getFile();
      final data = jsonEncode(_accounts.map((a) => a.toJson()).toList());
      await file.writeAsString(data);
    } catch (e) {
      debugPrint("Error al guardar datos: $e");
    }
    notifyListeners();
  }
}
