import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:art_mix/screens/main_screen.dart';
//import 'dart:ui' as ui;
//import 'package:flutter_image/flutter_image.dart';

import 'package:art_mix/services/firebase_service.dart';

class Mapa extends StatefulWidget {
  const Mapa({super.key});

  @override
  State<Mapa> createState() => MapaState();
}

class MapaState extends State<Mapa> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  //final GoogleMapController _mapController;
  Future<List<Marker>> futureMarkers = Future.value([]);
  List<Marker> markers = [];
  //Marker selectedMarker;
  Marker selectedMarker = const Marker(markerId: MarkerId('dummy'));

  Future<List<Marker>> getMarkers() async {
    List<Marker> markers = [];
    const ImageConfiguration imageConfiguration =
        ImageConfiguration(size: Size(60, 60));
    final BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      imageConfiguration,
      'assets/imgs/icon4_map_small.png',
    );

    await getArtistas().then((value) {
      for (var artista in value) {
        String artistaId = artista.id;
        String artistaName = artista['name'];
        double artistaLatitude = artista['latitude'];
        double artistaLongitude = artista['longitude'];

        markers.add(
          Marker(
            markerId: MarkerId(artistaId),
            position: LatLng(artistaLatitude, artistaLongitude),
            icon: customIcon,
            onTap: () {
              //print('ID del artista: $artistaId');
              //print('Nombre del artista: $artistaName');
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    //builder: (context) => MainScreen(idArtista: artistaName)),
                    builder: (context) =>
                        MainScreen(idArtista: artistaId)),
              );
            },
          ),
        );
      }
    });

    return markers;
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initState()');

    futureMarkers = getMarkers().then((value) {
      print('pasosMarkers paso: 1 b');
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: FutureBuilder(
        //se traen las hamburguesas de la base de datos
        future: futureMarkers,
        builder: (context, snapshotFuturemarkers) {
          if (snapshotFuturemarkers.connectionState ==
              ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshotFuturemarkers.hasData) {
            print('pasosMarkers paso: 2');
            print('futureMarkers else if (snapshot.hasData)');
            print(snapshotFuturemarkers.data);
            markers = snapshotFuturemarkers.data ?? [];
            print('futureMarkers markers.length: ${markers.length}');
            return FutureBuilder<String>(
              future: rootBundle.loadString('assets/custom_map_style.json'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final MapStyle = snapshot.data;

                  print('markers.length 1 FutureBuilder: ${markers.length}');

                  return GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      controller.setMapStyle(MapStyle);
                      _controller.complete(controller);
                      //_mapController = controller;
                      //_mapController.setMapStyle(MapStyle);
                    },
                    initialCameraPosition: const CameraPosition(
                      //target: LatLng(37.7749, -122.4194),
                      //-32.304139325122364, -59.14440684350697
                      target: LatLng(-32.304139325122364, -59.14440684350697),
                      //zoom: 12.0,
                      zoom: 8.0,
                    ),
                    markers: Set<Marker>.from(markers),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            );
          } else if (snapshotFuturemarkers.hasError) {
            print(snapshotFuturemarkers.error);
            return const Text('Error');
          }

          return const Center(
              child:
                  CircularProgressIndicator()); // Otra acción por defecto en caso de conexión no esperada
        },
      ),

    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
