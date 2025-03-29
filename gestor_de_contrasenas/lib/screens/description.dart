import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import necesario para copiar al portapapeles
import 'package:gestor_de_contrasenas/models/account_model.dart';

class DetailsAccount extends StatelessWidget {
  final Account account;

  const DetailsAccount({super.key, required this.account});

  // Función para copiar texto al portapapeles
  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copiado: $text')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(account.name), // Nombre de la app
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCopyableRow(context, 'Usuario', account.user),
            _buildCopyableRow(context, 'Contraseña', account.password),
            _buildCopyableRow(context, 'Email', account.email),
            _buildCopyableRow(context, 'Teléfono', account.phone),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context); // Volver atrás
              },
              child: const Text('Volver'),
            ),
            ),
            
          ],
        ),
      ),
    );
  }

  // Widget para mostrar texto seleccionable con botón de copiar
  Widget _buildCopyableRow(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Expanded(
              child: SelectableText(
                value,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.copy, color: Colors.deepPurple),
              onPressed: () => _copyToClipboard(context, value),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
