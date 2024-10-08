import 'package:flutter/material.dart';
import 'package:art_mix/screens/continue_screen.dart';

import 'package:flutter/services.dart';
import 'package:art_mix/screens/pages/login_and_register/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:art_mix/utils/LoginGoogleUtils.dart';
import 'firebase_options.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      //duration: Duration(milliseconds: 4900),
      //duration: Duration(milliseconds: 3800),//en Figma
      duration: const Duration(milliseconds: 4100),
    );

    _animation = Tween<double>(begin: 1.0, end: 1.0).animate(_controller)
      ..addListener(() {
        if (_animation.isCompleted) {
          print("1");
          /*
          LoginGoogleUtils().verificarSesionActiva().then((value) {
            print('Pantalla Splash Sesion activa?: $value');
          });
          Navigator.of(context).pushReplacement(
            //MaterialPageRoute(builder: (context) => MyApp()),
            MaterialPageRoute(builder: (context) => LoginScreen()),
            //MaterialPageRoute(builder: (context) => RegistrationScreen()),
          );
          */
          LoginGoogleUtils().userActivo().then((value) {
            print('Pantalla Splash Sesion activa?: $value');
            if (value != null) {
              print("ContinueScreen()");
              //if(value.emailVerified==true)
              Navigator.of(context).pushReplacement(
                //MaterialPageRoute(builder: (context) => MyApp()),
                MaterialPageRoute(builder: (context) => const ContinueScreen()),
                //MaterialPageRoute(builder: (context) => RegistrationScreen()),
              );
            } else {
              print("LoginScreen()");
              Navigator.of(context).pushReplacement(
                //MaterialPageRoute(builder: (context) => MyApp()),
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                //MaterialPageRoute(builder: (context) => RegistrationScreen()),
              );
            }
          });
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.only(bottom: 90.84),
              height: 200,
              //color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: FadeTransition(
                      opacity: _animation,
                      child: Image.asset(
                        'assets/gifs/descarga4.gif',
                        width: 151.68,
                        height: 151.68,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ), // Espacio vertical entre la imagen y el texto
                  const Text(
                    'Art Mix',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'ABeeZee',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 18.8751,
                      height: 1.543,
                      color: Color(0xFF212330),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(
                  bottom: 40.0), // Ajusta el margen inferior aquí
              child: const Text(
                'By Pumita Studio',
                style: TextStyle(
                  fontFamily: 'ABeeZee',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 1.543,
                  //textAlign: TextAlign.center,
                  color: Color(0xFF928E8E),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter, //Alignment.bottomRight
            child: Container(
              margin: const EdgeInsets.only(
                bottom: 0.0,
              ), //right: 7.0 // Ajusta el margen inferior aquí
              child: const Text(
                'v0.0.0.2',
                style: TextStyle(
                  fontFamily: 'ABeeZee',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  height: 1.543,
                  //textAlign: TextAlign.center,
                  color: Color(0xFF928E8E),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() async {
  print('hola a0');
  WidgetsFlutterBinding.ensureInitialized();
  print('hola a1');
  //await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print(DefaultFirebaseOptions.currentPlatform);
  print('hola a2');
  runApp(const MyApp());
  print('hola a3');
}

//flutter run -d edge --web-renderer html
//flutter run -d web-server --web-renderer html

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //return LoginScreen();
    // Estilo de la barra de aplicación
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      //statusBarColor: Colors.transparent,
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,

      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Art Mix App',
      home: const SplashScreen(),
      theme: ThemeData(
        primaryColor: const Color(0xFF5F5FFF),
        //accentColor: const Color(0XFF030047),
        //accentColor: const Color(0XFF030047),
        highlightColor: const Color(0XFFB7B7D2),

        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
            color: Color(0XFF030047),
          ),
          displayMedium: TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5F5FFF),
          ),
          displaySmall: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          headlineMedium: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: Color(0XFF030047),
          ),
          bodyLarge: TextStyle(
            fontSize: 20.0,
            color: Color(0XFFB7B7D2),
          ),
          bodyMedium: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Color(0xFF5F5FFF),
          ),
          titleMedium: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Color(0XFFB7B7D2),
          ),
        ),

        //textTheme: ThemeData.light().textTheme,
        appBarTheme: const AppBarTheme(
          // Estilo de la barra de aplicación
          systemOverlayStyle: SystemUiOverlayStyle(
            //statusBarColor: Colors.transparent,
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,

            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
        ),
      ),
    );
  }
}
