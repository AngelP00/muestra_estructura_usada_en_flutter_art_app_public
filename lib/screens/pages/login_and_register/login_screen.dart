import 'package:flutter/material.dart';
import 'package:art_mix/screens/pages/login_and_register/register_screen.dart';
import '../../../utils/LoginGoogleUtils.dart';
import '../../continue_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  bool _isTextVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(
            0xFFF0BF5E), // Cambia el color de fondo de la AppBar aquí
        title: const Text('Inicio de Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.start,
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
            Visibility(
              visible: _isTextVisible,
              child: GestureDetector(
                onTap: () {
                  // Navegar a la pantalla de registro (RegistrationScreen)
                  //resetPasswordFirebaseAuth('example@example.com');
                  LoginGoogleUtils()
                      .resetPasswordFirebaseAuth(_emailController.text)
                      .then((result) {
                    print(result);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        //content: Text(e.toString()),
                        content: Text(result),
                      ),
                    );
                  });
                },
                child: const Text(
                  //'¿Olvidaste la contraseña? Recueperala',
                  'Recuperar contraseña',
                  style: TextStyle(
                    //color: Colors.blue,
                    color: Colors.grey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
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
                'Iniciar Sesión',
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
                String email = _emailController.text;
                if (email == "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Error al iniciar sesión: Ingrese un email'),
                    ),
                  );
                }
                String password = _passwordController.text;
                if (email == "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Error al iniciar sesión: Ingrese una contraseña'),
                    ),
                  );
                }
                */

                try {
                  String email = _emailController.text;
                  String password = _passwordController.text;
                  if (email == "") {
                    throw Exception('Ingrese un email');
                  }
                  if (password == "") {
                    throw Exception('Ingrese una contraseña');
                  }

                  print('Error al iniciar sesión0:');
                  UserCredential userCredential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  print('Error al iniciar sesión1:');
                  User? user = userCredential.user;
                  print('Error al iniciar sesión2:');
                  if (user != null) {
                    // Realizar acciones con el usuario autenticado
                    // ...

                    // Reiniciar los controladores de texto después de iniciar sesión
                    _emailController.clear();
                    _passwordController.clear();

                    // Navegar a la siguiente pantalla (ContinueScreen)
                    /*
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContinueScreen()),
                    );
                    */
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const ContinueScreen()),
                    );
                  }
                  print('Error al iniciar sesión3:');
                } catch (e) {
                  // Manejar errores de inicio de sesión
                  print('Error al iniciar sesión4: $e');

                  if (e is FirebaseAuthException) {
                    /*
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error al iniciar sesión: ' + e.code),
                      ),
                    );
                    */
                    /*
                    String errorCode = e.code;
                    String? errorMessage = e.message;
                    String email = e.email ?? '';
                    AuthCredential? credential = e.credential ?? null;

                    print('Código de error: $errorCode');
                    print('Mensaje de error: $errorMessage');
                    print('Correo electrónico: $email');
                    */
                    String errorMessage = e.toString();
                    String texto = '';
                    if (errorMessage.contains('invalid-email')) {
                      texto = 'Email no valido. Ingrese un email valido.';
                    } else if (errorMessage.contains('user-not-found')) {
                      texto = 'Email no registrado en el sistema.';
                    } else if (errorMessage.contains('wrong-password')) {
                      texto = 'Email correcto. Contraseña incorrecta.';
                      setState(() {
                        //_isTextVisible = !_isTextVisible;
                        _isTextVisible = true;
                      });
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
                    } else if (errorMessage.contains('user-not-found')) {
                      texto = 'Email no registrado en el sistema.';
                    } else if (errorMessage.contains('user-disabled')) {
                      texto =
                          'La cuenta ingresada ha sido desabilitada por el admministrador.';
                    }

                    //(auth/network-request-failed)
                    /*
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(texto),
                      ),
                    );
                    */
                    if (texto != '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(texto),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          //content: Text('Firebase Exeption2: ' + e.toString()),
                          content: Text(errorMessage),
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
            MaterialButton(
              elevation: 0,
              //minWidth: 100.0,
              minWidth: 343.0,
              height: 44.0,
              //color: const Color(0xFFDB4437),
              //color: const Color(0xFFF0BF5E),
              //color: Colors.grey[400],
              color: Colors.grey[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              onPressed: () {
                //LoginGoogleUtils().signOut();
                LoginGoogleUtils().signInWithGoogle().then((result) {
                  if (result != null) {
                    // El inicio de sesión con Google fue exitoso, muestra el contenido del resultado
                    print('Resultado del inicio de sesión con Google: $result');

                    UserCredential userCredential =
                        result; // Resultado del inicio de sesión con Google

                    // Acceder a AdditionalUserInfo
                    bool isNewUser =
                        userCredential.additionalUserInfo?.isNewUser ?? false;
                    Map<String, dynamic>? profile =
                        userCredential.additionalUserInfo?.profile;
                    String? providerId =
                        userCredential.additionalUserInfo?.providerId;
                    String? username =
                        userCredential.additionalUserInfo?.username;

                    // Acceder a AuthCredential
                    String? authCredentialProviderId =
                        userCredential.credential?.providerId;
                    String? authCredentialSignInMethod =
                        userCredential.credential?.signInMethod;
                    int? authCredentialToken = userCredential.credential?.token;
                    String? authCredentialAccessToken =
                        userCredential.credential?.accessToken;

                    // Acceder a User
                    String? displayName = userCredential.user?.displayName;
                    String? email = userCredential.user?.email;
                    bool isEmailVerified =
                        userCredential.user?.emailVerified ?? false;
                    bool isAnonymous =
                        userCredential.user?.isAnonymous ?? false;
                    UserMetadata? metadata = userCredential.user?.metadata;
                    String? phoneNumber = userCredential.user?.phoneNumber;
                    String? photoURL = userCredential.user?.photoURL;
                    List<UserInfo>? providerData =
                        userCredential.user?.providerData;
                    String? refreshToken = userCredential.user?.refreshToken;

                    // Acceder a la información específica de providerData
                    if (providerData != null) {
                      for (UserInfo userInfo in providerData) {
                        String? userInfoDisplayName = userInfo.displayName;
                        String? userInfoEmail = userInfo.email;
                        String? userInfoPhoneNumber = userInfo.phoneNumber;
                        String? userInfoPhotoURL = userInfo.photoURL;
                        String? userInfoProviderId = userInfo.providerId;
                        String? userInfoUid = userInfo.uid;
                      }
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        //content: Text("Inicio de sesión con: ${profile?['email'] ?? 'Correo no disponible'}"),
                        content:
                            Text("Inicio de sesión con: ${profile?['email']}"),
                      ),
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const ContinueScreen()),
                    );
                  } else {
                    // El inicio de sesión con Google fue cancelado o falló
                    print('Inicio de sesión con Google cancelado o fallido');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        //content: Text('Firebase Exeption2: ' + e.toString()),
                        content: Text(
                            "Inicio de sesión con Google cancelado o fallido"),
                      ),
                    );
                  }
                });

              },

              child: Container(
                constraints: const BoxConstraints(maxWidth: 200.0),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      //'assets/google_logo.png', // Replace with your own image asset
                      //'assets/imgs/descarga4.png',
                      'assets/imgs/google_logo.png',
                      height: 24.0,
                      width: 24.0,
                    ),
                    const SizedBox(width: 8.0),
                    const Text(
                      //'Iniciar sesión con Google',
                      'Continuar con Google',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 17.0,
                        height: 1.29,
                        letterSpacing: -0.408,
                        //color: Color(0xFFFFFFFF),
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

            ),
            const SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                // Navegar a la pantalla de registro (RegistrationScreen)
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationScreen()),
                );
                */
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                );
              },
              child: const Text(
                '¿No tienes una cuenta? Regístrate',
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
