import 'package:flutter/material.dart';
//import 'package:carousel_slider/carousel_options.dart';
//import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:art_mix/components/item_promocion._banner_mobile.dart';
import 'package:art_mix/models/promocionBannerMobile.dart';

//class PromocionCarousel extends StatelessWidget {
class BannerMobileCarousel extends StatelessWidget {
  List<BannerMobile> promociones;
  int activeIndex = 0;

  BannerMobileCarousel(this.promociones, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      //color: Colors.green,
      alignment: Alignment.center,
      child: Swiper(
        //enableInfiniteScroll: true,
        //reverse: false,
        viewportFraction: 1,
        autoplay: true,
        autoplayDelay: 15000,

        //duration: 5000,
        //autoPlayInterval: Duration(seconds: 10),
        itemBuilder: (BuildContext context, int index) {
          //return Image.network("https://via.placeholder.com/350x150",fit: BoxFit.fill,);
          //return this.promociones.map((e) => ItemPromocion(e, themeDark: true)).toList();
          return ItemPromocionBannerMobile(promociones[index]);
        },
        //this.promociones.map((e) => ItemPromocion(e, themeDark: true)).toList(),
        //itemCount: this.promociones.length,
        itemCount: promociones.length,
        pagination: const SwiperPagination(
          margin: EdgeInsets.all(1.0),
          builder: DotSwiperPaginationBuilder(
            color: Colors.black12,
            activeColor: Colors.grey,
            size: 8,
            activeSize: 8,
          ),
        ),
        control: const SwiperControl(
            color: Colors.transparent,
            disableColor: Colors.transparent,
            size: 70),
        //controller: control.col,
      ),
    );
    //);
  }
}
