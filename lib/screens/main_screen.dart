import 'package:art_mix/utils/LoginGoogleUtils.dart';
import 'package:flutter/material.dart';
import 'package:art_mix/screens/pages/mapa.dart';
import 'package:art_mix/screens/pages/routes.dart';
//import '../components/job_list.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MainScreen extends StatefulWidget {
  //const MainScreen({super.key});

  final String idArtista; // Nuevo parámetro para el String

  const MainScreen({Key? key, required this.idArtista})
      : super(key: key); // Se agrega el parámetro al constructor

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  User? _currentUser;

  @override
  void initState() {
    super.initState();
    print('widget.idArtista ${widget.idArtista}');
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
      //body: Routes(index: _selectedIndex),

      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _selectedIndex = page;
          });
        },
        children: <Widget>[
          KeepAlivePage(
            child: Routes(
              index: 0,
              idArtista2: widget.idArtista,
            ),
          ),
          KeepAlivePage(
            child: Routes(
              index: 1,
              idArtista2: widget.idArtista,
            ),
          ),
          KeepAlivePage(
            child: Routes(
              index: 2,
              idArtista2: widget.idArtista,
            ),
          ),
        ],
      ),
      appBar: AppBar(
        //backgroundColor: Color.fromARGB(136, 196, 195, 195),
        backgroundColor: const Color.fromARGB(135, 255, 255, 255),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: "Cancel and Return to List",
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        automaticallyImplyLeading: false,
        title: const Text(
          "Art App",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            color: Colors.black,
            tooltip: "Save Todo and Retrun to List",
            onPressed: () {
              //save();
              print('mapa');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Mapa()),
                (route) => true,
              );
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 25,
            ),
            label: 'Inicio',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.business,
              size: 25,
            ),
            label: 'Carrito',
          ),
          BottomNavigationBarItem(
            icon: _currentUser != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(_currentUser!.photoURL!),
                    radius: 15,
                  )
                : const CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/imgs/avatar_placeholder.png'),
                    radius: 15,
                  ),
            label: 'Mi Cuenta',
          ),
        ],
        currentIndex: _selectedIndex,
        //currentIndex: 1,
        selectedItemColor: const Color(0xFF007AFF),
        unselectedItemColor: const Color.fromRGBO(60, 60, 67, 0.4),
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400,
          fontSize: 13.0,
          height: 1.0,
          //textAlign: TextAlign.center,
          letterSpacing: -0.24,
        ),

        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400,
          fontSize: 13.0,
          height: 1.0,
          //textAlign: TextAlign.center,
          letterSpacing: -0.24,
        ),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _pageController.animateToPage(_selectedIndex,
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear);
        },
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 7.0),
        child: SizedBox(
          //width: 56.0,
          //height: 56.0,
          width: 72.0,
          height: 72.0,
          child: FloatingActionButton(
            onPressed: () {
              // Acción del botón flotante
              setState(() {
                _selectedIndex = 1;
              });
              _pageController.animateToPage(_selectedIndex,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linear);
            },
            elevation: 0,
            backgroundColor: const Color.fromARGB(
                255, 244, 183, 92), // Color de fondo del botón flotante
            foregroundColor: _selectedIndex == 1
                ? const Color(0xFF007AFF)
                : const Color.fromRGBO(60, 60, 67, 0.4),
            child: const Icon(
              Icons.shopping_cart,
              size: 30,
            ), // Color del icono
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

//========= Start para preservar el estado de las paginas
class KeepAlivePage extends StatefulWidget {
  final Widget child;

  const KeepAlivePage({super.key, required this.child});

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
//========= End para preservar el estado de las paginas
