import 'package:flutter/material.dart';
import 'package:art_mix/screens/pages/page_home.dart';
import 'package:art_mix/screens/pages/page_cart.dart';
import 'package:art_mix/screens/pages/page_user.dart';

class Routes extends StatelessWidget {
  final int index;
  final String idArtista2;
  const Routes({Key? key, required this.index, required this.idArtista2})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<Widget> myList = [
      PageHome(
        idArtista2: idArtista2,
      ),
      const PageCart(),
      const ProfilePage(),
      //Mapa(),
    ];
    return myList[index];
  }
}
