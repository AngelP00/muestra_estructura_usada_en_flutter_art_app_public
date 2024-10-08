import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordButton extends StatelessWidget {
  const ResetPasswordButton({super.key});

  Future<void> resetPassword() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      String email = auth.currentUser?.email ?? '';

      if (email.isNotEmpty) {
        await auth.sendPasswordResetEmail(email: email);
        print(
            'Se ha enviado un correo electrónico para restablecer la contraseña.');
      } else {
        print('No se ha encontrado una dirección de correo electrónico.');
      }
    } catch (e) {
      print('Ha ocurrido un error al restablecer la contraseña: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: resetPassword,
      child: const Text('Restablecer Contraseña'),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Restablecer Contraseña'),
      ),
      body: const Center(
        child: ResetPasswordButton(),
      ),
    ),
  ));
}
