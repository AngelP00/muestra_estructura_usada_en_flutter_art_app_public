import 'package:flutter/material.dart';
import 'package:art_mix/utils/LoginGoogleUtils.dart';
import '../../continue_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(
            0xFFF0BF5E), // Cambia el color de fondo de la AppBar aquí
        title: const Text('Registro de Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Container(
                //color: Colors.red, // Cambia el color de fondo aquí
                child: Image.asset(
                  'assets/imgs/descarga4.png',
                  width: 120,
                  height: 120,
                ),
              ),
            ),
            const Text(
              'Art App',
              //style: Theme.of(context).textTheme.headline1,
              style: TextStyle(
                color: Colors.black, // Cambia el color del texto aquí
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo Electrónico',
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_passwordVisible,
            ),
            const SizedBox(height: 20.0),
            MaterialButton(
              elevation: 0,
              //minWidth: 170.0,
              minWidth: 343.0,
              height: 44.0,

              color: const Color(0xFFF0BF5E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                'Registrarse',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 17.0,
                  height: 1.29,
                  //textAlign: TextAlign.center,
                  letterSpacing: -0.408,
                  color: Color(0xFFFFFFFF),
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: () async {
                /*
                // Navegar a la pantalla de inicio de sesión (LoginScreen)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
                */

                // Aquí puedes agregar la lógica para registrar al usuario
                /*
                String name = _nameController.text;
                String email = _emailController.text;
                String password = _passwordController.text;
                */

                try {
                  String name = _nameController.text;
                  String email = _emailController.text;
                  String password = _passwordController.text;

                  if (name == "") {
                    throw Exception('Ingrese un nombre');
                  }
                  if (email == "") {
                    throw Exception('Ingrese un email');
                  }
                  if (password == "") {
                    throw Exception('Ingrese una contraseña');
                  }
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );

                  // Obtener el perfil del usuario registrado
                  User? user = userCredential.user;
                  print('user:');
                  print(user);
                  print('user');
                  if (user != null) {
                    print('usuario encontrado');
                    String displayName = user.displayName ?? '';
                    String email = user.email ?? '';
                    String? photoURL = user.photoURL;
                    DateTime? creationTime = user.metadata.creationTime;
                    print(creationTime);
                    DateTime? lastSignInTime = user.metadata.lastSignInTime;

                    // Realizar acciones con la información del perfil
                    // ...
                    //await user.updateDisplayName("Usuario actualizado");
                    await user.updateDisplayName(name);
                    //await userCredential.user!.sendEmailVerification();
                    //await user.sendEmailVerification();
                    LoginGoogleUtils()
                        .currentUserSendEmailVerification()
                        .then((value) {
                      print('currentUserSendEmailVerification');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(value),
                        ),
                      );
                    });

                    // Reiniciar los controladores de texto después de registrar al usuario
                    _nameController.clear();
                    _emailController.clear();
                    _passwordController.clear();

                    // Navegar a la pantalla de inicio de sesión (LoginScreen)
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const ContinueScreen()),
                    );
                  }
                } catch (e) {
                  // Manejar errores de registro
                  print('Error al registrar el usuario: $e');

                  if (e is FirebaseAuthException) {
                    String errorMessage = e.toString();
                    String texto = '';
                    if (errorMessage.contains('invalid-email')) {
                      texto = 'Email no valido. Ingrese un email valido.';
                    } else if (errorMessage.contains('user-not-found')) {
                      texto = 'Email no registrado en el sistema.';
                    } else if (errorMessage.contains('wrong-password')) {
                      texto = 'Email correcto. Contraseña incorrecta.';
                    } else if (errorMessage.contains('too-many-requests')) {
                      texto =
                          'El acceso a esta cuenta se ha deshabilitado temporalmente debido a muchos intentos fallidos de inicio de sesión. Puede restaurarlo inmediatamente restableciendo su contraseña o puede volver a intentarlo más tarde.';
                    } else if (errorMessage
                        .contains('network-request-failed')) {
                      //texto = 'A network AuthError (such as timeout, interrupted connection or unreachable host) has occurred. No se pudo conectar a internet. Conectese a internet.';
                      texto =
                          'No se pudo conectar a internet. Conectese a internet.';
                    } else if (errorMessage.contains('internal-error')) {
                      //texto = 'Firebase: An internal AuthError has occurred. Conectese a internet.';
                      texto =
                          'No se pudo conectar a internet. Conectese a internet.';
                    } else if (errorMessage.contains('weak-password')) {
                      //texto = 'Firebase: An internal AuthError has occurred. Conectese a internet.';
                      texto = 'La contraseña debe ser de 6 o mas caracteres';
                    } else if (errorMessage.contains('email-already-in-use')) {
                      //texto = 'Firebase: An internal AuthError has occurred. Conectese a internet.';
                      texto =
                          'El email introducido está actualmente en uso. Ingrese un email diferente';
                    }
                    //

                    //(auth/network-request-failed)

                    if (texto != '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(texto),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                        ),
                      );
                    }
                    /*
                    if (credential != null) {
                      // Acceder a las propiedades de las credenciales si están disponibles
                    }
                    */

                    // Manejar el error de autenticación
                  } else {
                    //print('Error inesperado: $e');
                    print(e);
                    String errorMessage =
                        e.toString().replaceAll('Exception: ', '');
                    print(errorMessage);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        //content: Text(e.toString()),
                        content: Text(errorMessage),
                      ),
                    );
                    // Manejar otros errores inesperados
                  }
                }
              },
            ),
            const SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                // Navegar a la pantalla de inicio de sesión (LoginScreen)
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
                */
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text(
                '¿Ya tienes una cuenta? Inicia sesión',
                style: TextStyle(
                  //color: Colors.blue,
                  color: Colors.grey,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 100.0),
          ],
        ),
      ),
    );
  }
}
