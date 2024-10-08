import 'package:flutter/material.dart';
import 'package:art_mix/models/promocionBannerMobile.dart';

class ItemPromocionBannerMobile extends StatefulWidget {
  BannerMobile bannerMobile;
  //bool themeDark;

  //ItemPromocionBannerMobiele(this.bannerMobile, {this.themeDark = false});
  ItemPromocionBannerMobile(this.bannerMobile, {super.key});

  @override
  _ItemPromocionBannerMobileState createState() =>
      _ItemPromocionBannerMobileState();
}

class _ItemPromocionBannerMobileState extends State<ItemPromocionBannerMobile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(right: 0, left: 0, bottom: 17.0, top: 2.5),
        child: Container(
          decoration: _boxDecoration(context),
          child: Image.network(
            widget.bannerMobile.urlImage,
            fit: BoxFit
                .cover, // Ajuste para que la imagen llene todo el espacio horizontal sin deformarse
            //height: double.infinity, // Establecer una altura infinita para que el Container se ajuste al tamaño de la imagen
            //width: double.infinity, // Establecer un ancho infinito para que el Container se expanda horizontalmente
          ),
        ));
  }

  BoxDecoration _boxDecoration(context) {
    return BoxDecoration(
      //color: this.widget.themeDark ? Theme.of(context).primaryColor : Colors.white,
      color: Colors.white,
      //color: Color.fromARGB(255, 182, 22, 22),
      borderRadius: BorderRadius.circular(5.0),
    );
  }

  Widget _infoJobTexts(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 1.0),
        Row(
          children: <Widget>[
            Icon(
              Icons.location_on,
              color: Theme.of(context).highlightColor,
              size: 0.0,
            ),
            const SizedBox(width: 5.0),
            Text(
              widget.bannerMobile.id,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ],
    );
  }
}
