import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginGoogleUtils {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signOut() async {
    try {
      // Paso 1: Cerrar sesión en Firebase
      await _firebaseAuth.signOut();

      // Paso 2: Cerrar sesión en Google Sign-In
      await _googleSignIn.signOut();
    } catch (e) {
      // Manejar cualquier error que ocurra durante el proceso de cierre de sesión
      print('Error al cerrar sesión: $e');
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    print("entró a: signInWithGoogle()");
    try {
      // Paso 1: Cerrar sesión en Firebase y Google Sign-In si hay una cuenta activa
      await signOut();
      // Paso 2: Iniciar sesión con Google usando Google Sign-In
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount == null) {
        // User canceled the sign-in process
        print("fnull");
        return null;
      }
      // Paso 3: Obtener las credenciales de autenticación de Google Sign-In
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Paso 4: Iniciar sesión en Firebase con las credenciales de Google
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      print("f5");
      print("entró salió bien a: signInWithGoogle()");
      return userCredential;
    } catch (e) {
      // Handle any errors that occurred during the sign-in process
      print('Error signing in with Google: $e');
      print("entró salió con error a: signInWithGoogle()");
      return null;
    }
  }

  Future<User?> userActivo() async {
    print('verificarSesionActiva');
    User? result;

    await for (User? user in FirebaseAuth.instance.authStateChanges()) {
      if (user == null) {
        print('El usuario está actualmente desconectado!');
        //result = user;
      } else {
        print('El usuario está conectado!');
        await user
            .reload(); // Actualiza la información del usuario en tiempo real
        //result = user;
        result = FirebaseAuth.instance.currentUser;
      }
      break; // Detener la escucha después de recibir el primer cambio de estado
    }
    print('resultado: $result');
    return result;
  }

  Future<String> currentUserSendEmailVerification() async {
    print('UserActivoSendEmailVerification');
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await user.sendEmailVerification();
        print('Se ha enviado un correo de verificación a ${user.email}');
        return 'Se ha enviado un correo de verificación a ${user.email}';
      } catch (e) {
        print('Error al enviar el correo de verificación: $e');
        return 'Error al enviar el correo de verificación: $e';
      }
    } else {
      print('No se ha encontrado un usuario autenticado');
      return 'No se ha encontrado un usuario autenticado';
    }
  }

  Future<String> resetPasswordFirebaseAuth(String email) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      if (email.isNotEmpty) {
        await auth.sendPasswordResetEmail(email: email);
        //print('Se ha enviado un correo electrónico para restablecer la contraseña a $email.');
        return 'Se ha enviado un correo electrónico para restablecer la contraseña a $email.';
      } else {
        //print('No se ha proporcionado una dirección de correo electrónico.');
        return 'No se ha proporcionado una dirección de correo electrónico.';
      }
    } catch (e) {
      //print('Ha ocurrido un error al restablecer la contraseña: $e');
      //return 'Ha ocurrido un error al restablecer la contraseña: $e';
      //return 'Ha ocurrido un error al restablecer la contraseña. Causa: El email introducido no es correcto; o No tiene acceso a internet';
      return 'Ha ocurrido un error al restablecer la contraseña. Verifique el email introducido. Verifique su acceso a internet.';
    }
  }
}
