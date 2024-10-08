import 'package:flutter/material.dart';
import 'package:art_mix/screens/pages/login_and_register/login_screen.dart';
import 'package:art_mix/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:art_mix/utils/LoginGoogleUtils.dart';

class ContinueScreen extends StatefulWidget {
  const ContinueScreen({super.key});

  @override
  State<ContinueScreen> createState() => _ContinueScreenState();
}

class _ContinueScreenState extends State<ContinueScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //User? _currentUser;

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _firebaseAuth.authStateChanges(),
      //stream: _firebaseAuth.userChanges(),
      builder: (context, snapshot) {
        print("stream1");
        if (snapshot.connectionState == ConnectionState.active) {
          print("stream2");
          final user = snapshot.data;

          if (user != null && user.emailVerified) {
            // El usuario ha verificado su correo electrónico
            // Mostrar la pantalla principal de la aplicación
            //return HomeScreen();
            print('Verificado');
            return Scaffold(
              body: Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //Image.asset('assets/imgs/img_main.png'),

                    Column(
                      children: <Widget>[
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
                            color:
                                Colors.black, // Cambia el color del texto aquí
                          ),
                        ),

                        //SizedBox(height: 5.0),
                        //Text('- - - - - - - - - - - - - - - -'),
                        //SizedBox(height: 10.0),
                        //Text('------Cuenta activa:------'),
                        const SizedBox(height: 10.0),
                        //SizedBox(height: 10.0),

                        //SizedBox(height: 40.0),
                        const SizedBox(height: 100.0),
                        MaterialButton(
                          elevation: 0,
                          //minWidth: 170.0,
                          minWidth: 343.0,
                          height: 44.0,

                          color: const Color(0xFFF0BF5E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Container(
                            constraints: const BoxConstraints(
                              maxWidth:
                                  300, // Establece el ancho máximo deseado
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (user.photoURL != null)
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(user.photoURL ?? ""),
                                    radius: 17,
                                  )
                                else
                                  const CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/imgs/avatar_placeholder.png'),
                                    //AssetImage('assets/imgs/google_logo.png'),
                                    radius: 17,
                                  ),
                                //SizedBox(height: 40.0),
                                const SizedBox(height: 40.0),
                                const SizedBox(width: 10),
                                const Text(
                                  'Continuar',
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
                                const SizedBox(width: 10),
                                const SizedBox(width: 17),
                                const SizedBox(width: 17),
                              ],
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainScreen(
                                      idArtista: 'oc6bTiqFy21DvjK2Yie5')),
                            );
                          },
                        ),

                        //SizedBox(height: 70.0),
                        //SizedBox(height: 40.0),
                      ],
                    ),
                  ],
                ),
              ),
            );

            //return CircularProgressIndicator();
          } else {
            // El usuario no ha verificado su correo electrónico
            // Mostrar la pantalla de verificación de correo electrónico
            //return EmailVerificationScreen();
            print('No verificado');
            return Scaffold(
              body: Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //Image.asset('assets/imgs/img_main.png'),

                    Column(
                      children: <Widget>[
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
                            color:
                                Colors.black, // Cambia el color del texto aquí
                          ),
                        ),

                        //SizedBox(height: 5.0),
                        //Text('- - - - - - - - - - - - - - - -'),
                        //SizedBox(height: 10.0),
                        //Text('------Cuenta activa:------'),
                        const SizedBox(height: 10.0),
                        /*
                Divider(
                  color: Colors.grey, // Color del separador
                  height: 1, // Altura del separador
                  thickness: 1, // Grosor del separador
                  indent: 100, // Espacio izquierdo
                  endIndent: 100, // Espacio derecho
                ),
                */
                        //SizedBox(height: 10.0),

                        //SizedBox(height: 40.0),
                        const SizedBox(height: 100.0),
                        const Text(
                          'Art App',
                          //style: Theme.of(context).textTheme.headline1,
                          style: TextStyle(
                            color:
                                Colors.black, // Cambia el color del texto aquí
                          ),
                        ),
                        const Text('Por ser la primera vez:'),
                        const Text('Para continuar debe verificar su correo.'),
                        //const Text('Entre a su correo y haz click en el enlance que le enviamos.'),
                        //const Text('Si no encuentra el correo que le enviamos podria estar es la bandeja de spam.'),
                        const Text(
                            '(El mensaje podria estar en la bandeja de spam.)'),
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
                          child: Container(
                            constraints: const BoxConstraints(
                              maxWidth:
                                  300, // Establece el ancho máximo deseado
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/imgs/avatar_placeholder.png'),
                                  //AssetImage('assets/imgs/google_logo.png'),
                                  radius: 17,
                                ),
                                //SizedBox(height: 40.0),
                                SizedBox(height: 40.0),
                                SizedBox(width: 10),
                                Text(
                                  'Continuar',
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
                                SizedBox(width: 10),
                                SizedBox(width: 17),
                                SizedBox(width: 17),
                              ],
                            ),
                          ),
                          onPressed: () {
                            LoginGoogleUtils().userActivo().then((value) {
                              print('Pantalla Splash Sesion activa?: $value');
                              if (value != null) {
                                if (value.emailVerified) {
                                  print('Verificado');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MainScreen(
                                            idArtista: 'idContinueScreen')),
                                  );
                                } else {
                                  print('Email no verificado');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Primero debe verificar su correo.'),
                                    ),
                                  );
                                }
                              } else {
                                print("UserActivo == null LoginScreen()");
                                print("LoginScreen()");
                                Navigator.of(context).pushReplacement(
                                  //MaterialPageRoute(builder: (context) => MyApp()),
                                  MaterialPageRoute(
                                      builder: (context) => const LoginScreen()),
                                  //MaterialPageRoute(builder: (context) => RegistrationScreen()),
                                );
                              }
                            });
                          },
                        ),
                        const SizedBox(height: 10.0),
                        GestureDetector(
                          onTap: () {
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
                          },
                          child: const Text(
                            //'¿Olvidaste la contraseña? Recueperala',
                            'Enviar email de verificación',
                            style: TextStyle(
                              //color: Colors.blue,
                              color: Colors.grey,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),

                        //SizedBox(height: 70.0),
                        //SizedBox(height: 40.0),
                      ],
                    ),
                  ],
                ),
              ),
            );

            //return CircularProgressIndicator();
          }
        } else {
          // Mostrar un indicador de carga o pantalla de inicio de sesión
          print("stream3");
          print('En espera');
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
