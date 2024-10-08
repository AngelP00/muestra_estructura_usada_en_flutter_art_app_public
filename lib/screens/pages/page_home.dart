import 'package:art_mix/components/banners_mobile_carousel.dart';
import 'package:flutter/material.dart';
import 'package:art_mix/models/promocionBannerMobile.dart';
import 'package:art_mix/services/firebase_service.dart';
//import 'package:flutter_svg/flutter_svg.dart';
//import 'package:art_mix/screens/pages/routes.dart';
//import '../components/job_list.dart';
import '../../components/pinturas/item_list.dart';
import '../../models/item.dart';

class PageHome extends StatefulWidget {
  final String idArtista2; // Nuevo parámetro para el String

  const PageHome({Key? key, required this.idArtista2})
      : super(key: key); // Se agrega el parámetro al constructor

  @override
  State<PageHome> createState() => _MainScreenState();
}

class _MainScreenState extends State<PageHome> {
  Future<List<Item>> _burgers = Future.value([]);
  String _idArtista = 'oc6bTiqFy21DvjK2Yie5';
  //String _idArtista2 = 'default';
  
  List<BannerMobile> bannersMobile = [];

  Future<List<BannerMobile>> _bannersMobile = Future.value([]);

  List<Item> burgers = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initState()');
    /*
    getArtista(widget.idArtista2).then((value) {
      print('getArtista: ${value.data()}');
    });
    */

    print('widget.idArtista2 ${widget.idArtista2}');
    _idArtista = widget.idArtista2;
    //_burgers = getProductInfo();
    print('hola 33');
    print('page1.dart');
    print('getBannersMobile');
    _bannersMobile = getBannersMobile(_idArtista);
    getPujas(_idArtista, '1fAzZdG09d26xtk9BYkb');
    
    getArtistas().then((value) {
      print('getArtistas().then:');
      print('Artistas:');
      //print('value: $value');
      for (var artista in value) {
        print('value.forEach((artista)');
        //artistas.add(documento.data());
        //artistas.add(documento);
        print(artista.id);
        print(artista['name']);
        //print('artista: $artista');
        print('artista.data(): ${artista.data()}');
      }
    });
    _burgers = getObras(_idArtista);
  }

  @override
  Widget build(BuildContext context) {
    //print(_burgers);
    print('hola build page1.dart');
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            FutureBuilder(
              future: getArtista(widget.idArtista2),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  //String artistaName = snapshot.data!['name'];
                  //return Text('El nombre del artista es: $artistaName', style: TextStyle(fontSize: 16),
                  return Text(
                    snapshot.data!['name'],
                    //style: TextStyle(fontSize: 16),
                  );
                } else if (snapshot.hasError) {
                  return const Text('Error al obtener el nombre del artista');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),

            //Text('id: ${widget.idArtista2}'),
            FutureBuilder(
              //se traen las hamburguesas de la base de datos
              future: _bannersMobile,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  print('else if (snapshot.hasData)');
                  print(snapshot.data);
                  //burgers = snapshot.data ?? [];
                  //List<BannerMobile> banners = snapshot.data ?? [];
                  bannersMobile = snapshot.data ?? [];

                  Widget listView = _forYou(context);
                  //burgers = []; //eliminar esta linea para mantener las hamburguesasv

                  return listView;
                  //original:
                  //return BurgerList(burgers);
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Text('Error');
                }

                return const Center(
                    child:
                        CircularProgressIndicator()); // Otra acción por defecto en caso de conexión no esperada
              },
            ),
            //_forYou(context),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                //onChanged: filterItems,
                decoration: InputDecoration(
                  labelText: 'Buscar...',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: burgers.isEmpty == false
                  ?
                  /*
                  Center(
                      child: Text(
                          '(La lista "burgers" tiene hamburguesas) Hamburguesas de la lista "burgers":'))
                  */
                  Center(
                      child: Column(
                        children: [
                          const Text(
                              '(La lista "burgers" tiene hamburguesas) Hamburguesas de la lista "burgers":'),
                          // Agrega el print aquí
                          MaterialButton(
                            onPressed: () {
                              print(burgers);
                            },
                            child: const Text('Imprimir hamburguesas'),
                          ),
                        ],
                      ),
                    )
                  : FutureBuilder(
                      //se traen las hamburguesas de la base de datos
                      future: _burgers,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasData) {
                          print(snapshot.data);
                          burgers = snapshot.data ?? [];

                          print('burgers.length 2: ${burgers.length}');

                          //Widget list_view = BurgerList(burgers);
                          var listView = ItemrList(burgers);
                          //List<Burger> temp_burgers = burgers;
                          burgers =
                              []; //eliminar esta linea para mantener las hamburguesasv

                          return listView;

                          //return BurgerList(temp_burgers);
                          //original:
                          //return BurgerList(burgers);
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          //return Text('Error');
                          return Text('Error: ${snapshot.error}');
                        }

                        return const Center(
                            child:
                                CircularProgressIndicator()); // Otra acción por defecto en caso de conexión no esperada
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget _forYou(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        BannerMobileCarousel(bannersMobile),
      ],
    );
  }
}
