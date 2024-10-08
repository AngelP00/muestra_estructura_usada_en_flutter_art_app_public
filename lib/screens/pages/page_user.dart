import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../utils/LoginGoogleUtils.dart';
import 'login_and_register/login_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser(); // Llama a la función asíncrona que maneja _getCurrentUser
  }

  Future<void> _loadCurrentUser() async {
    _currentUser = await LoginGoogleUtils().userActivo();
    setState(() {
      // Actualiza el estado después de obtener el usuario
      _currentUser = _currentUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Expanded(
                child: Center(
              child: Column(
                children: [
                  const Text('Cuenta:'),
                  const SizedBox(height: 10.0),
                  /*
                  CircleAvatar(
                    backgroundImage: NetworkImage(_photoUrl),
                    radius: 50,
                  ),
                  */
                  if (_currentUser != null)
                    CircleAvatar(
                      backgroundImage: NetworkImage(_currentUser!.photoURL!),
                      radius: 50,
                    )
                  else
                    const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/imgs/avatar_placeholder.png'),
                      //AssetImage('assets/imgs/google_logo.png'),
                      radius: 50,
                    ),

                  const SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.centerLeft, //Alignment.bottomRight
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 0.0,
                      ), //right: 7.0 // Ajusta el margen inferior aquí

                      child: const Text(
                        'Informacion de la cuenta:',
                        style: TextStyle(
                          fontFamily: 'ABeeZee',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          //fontSize: 10,
                          //height: 1.543,
                          //textAlign: TextAlign.center,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft, //Alignment.bottomRight
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 0.0,
                      ), //right: 7.0 // Ajusta el margen inferior aquí

                      child: Row(
                        children: [
                          const Text(
                            'Nombre de usuario:',
                            style: TextStyle(
                              fontFamily: 'ABeeZee',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          const SizedBox(
                              width: 10), // Espacio entre los dos textos
                          Text(
                            _currentUser?.displayName ?? 'Usuario desconocido',
                            style: const TextStyle(
                              color:
                                  Colors.blue, // Cambia el color del texto aquí
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft, //Alignment.bottomRight
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 0.0,
                      ), //right: 7.0 // Ajusta el margen inferior aquí

                      child: Row(
                        children: [
                          const Text(
                            //'Correo de la cuenta:',
                            'Correo:',
                            style: TextStyle(
                              fontFamily: 'ABeeZee',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          const SizedBox(
                              width: 10), // Espacio entre los dos textos
                          Text(
                            _currentUser?.email ?? 'Email desconocido',
                            style: const TextStyle(
                              color:
                                  Colors.blue, // Cambia el color del texto aquí
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //SizedBox(height: 10.0),
                  const SizedBox(height: 40.0),
                  Align(
                    alignment: Alignment.centerLeft, //Alignment.bottomRight
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 0.0,
                      ), //right: 7.0 // Ajusta el margen inferior aquí

                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 125, // Ancho máximo deseado
                        ),
                        child: MaterialButton(
                          elevation: 0,
                          //minWidth: 170.0,
                          minWidth: 343.0,

                          height: 44.0,

                          color: const Color(0xFFF0BF5E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Text(
                            'Cerrar Sesion',
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
                          onPressed: () {
                            print("1");
                            //LoginGoogleUtils().SesionActiva();
                            print("2");
                            LoginGoogleUtils().signOut().then((value) {
                              print("then signOut");
                              print("4");
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                                (route) => false,
                              );
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
