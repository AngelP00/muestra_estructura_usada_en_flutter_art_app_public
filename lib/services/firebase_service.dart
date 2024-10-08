import 'package:art_mix/models/puja.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:art_mix/models/item.dart';
import 'package:art_mix/models/promocionBannerMobile.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getUsers() async {
  List users = [];
  CollectionReference collectionReferenceUser = db.collection('users');

  QuerySnapshot queryUser = await collectionReferenceUser.get();

  for (var documento in queryUser.docs) {
    users.add(documento.data());
  }
  //print('Users on body');
  //sprint(users);
  return users;
}

Future<List<BannerMobile>> getBannersMobile(String restaurantId) async {
  List<BannerMobile> bannersMobile = [];
  //print('Users on body');
  //sprint(users);
  CollectionReference collectionReferenceArtistas =
      db.collection('artistas');

  QuerySnapshot querysnapshotbannersMobile =
      await collectionReferenceArtistas
          .doc(restaurantId)
          .collection('banners_mobile')
          .get();
  //print('getBanners_mobile b1');
  for (var documento in querysnapshotbannersMobile.docs) {
    bannersMobile.add(
        BannerMobile(id: documento['id'], urlImage: documento['imageURL']));
  }
  return bannersMobile;
}

Future<List> getArtistasAnterior() async {
  List artistas = [];
  CollectionReference collectionReferenceArtistas =
      db.collection('artistas');

  QuerySnapshot queryArtista = await collectionReferenceArtistas.get();

  for (var documento in queryArtista.docs) {
    //artistas.add(documento.data());
    artistas.add(documento);
  }
  print(artistas[0]);
  print(artistas[0].id);
  print(artistas[0]['name']);

  QuerySnapshot querySnapshotObras = await collectionReferenceArtistas
      .doc(artistas[0].id)
      .collection('obras')
      .get();

  for (var obra in querySnapshotObras.docs) {
    print('obra:');
    print(obra.data());
  }

  return artistas;
}

Future<List> getArtistas() async {
  List artistas = [];
  CollectionReference collectionReferenceArtistas =
      db.collection('artistas');

  QuerySnapshot queryArtista = await collectionReferenceArtistas.get();

  for (var documento in queryArtista.docs) {
    //artistas.add(documento.data());
    artistas.add(documento);
  }

  return artistas;
}

Future<DocumentSnapshot> getArtista(String restaurantId) async {
  DocumentSnapshot artista;
  CollectionReference collectionReferenceArtistas =
      db.collection('artistas');

  artista = await collectionReferenceArtistas.doc(restaurantId).get();
  return artista;
}

Future<List> getObrasAnterior(String restaurantId) async {
  List obras = [];
  CollectionReference collectionReferenceArtistas =
      db.collection('artistas');

  QuerySnapshot querySnapshotObras = await collectionReferenceArtistas
      .doc(restaurantId)
      .collection('obras')
      .get();

  for (var obra in querySnapshotObras.docs) {
    obras.add(obra);
  }

  return obras;
}

Future<List<Item>> getObras(String restaurantId) async {
  List<Item> obras = [];
  //List obras = [];
  CollectionReference collectionReferenceArtistas =
      db.collection('artistas');

  print('getObras b0');

  QuerySnapshot querySnapshotObras = await collectionReferenceArtistas
      .doc(restaurantId)
      .collection('obras')
      .get();
  print('getObras b1');

  for (var obra in querySnapshotObras.docs) {
    //print('obra:');
    print(obra.data());
    //obras.add(obra);

    print('antes del error');
    //List<String> images = [];
    //List<dynamic> originalList = ['elemento1', 'elemento2', 'elemento3'];
    List<dynamic> originalList = obra['imagesURL'];
    List<String> convertedList =
        originalList.map((element) => element.toString()).toList();
    
    print('despues del error');
    obras.add(Item(
        name: obra['name'],
        imageUrl: obra['imageURL'],
        price: obra['price'],
        currency_code: obra['currency_code'],
        imagesUrl: convertedList,
        pujas: []));
  }

  return obras;
}

Future<List<Puja>> getPujas(String restaurantId, String itemId) async {
  print('getPujas');
  List<Puja> pujas = [];
  CollectionReference collectionReferenceArtistas =
      db.collection('artistas');

  QuerySnapshot querySnapshotPujas = await collectionReferenceArtistas
      .doc(restaurantId)
      .collection('obras')
      .doc(itemId)
      .collection('pujas')
      .get();

  for (var puja in querySnapshotPujas.docs) {
    //print('obra:');
    print(puja.data());
    //obras.add(obra);
    pujas.add(Puja(
        userId: puja['userId'],
        monto: puja['monto'],
        currency_code: puja['currency_code'],
        //dateTime: puja['dateTime']
        dateTime: DateTime.now()));
  }

  return pujas;
}
