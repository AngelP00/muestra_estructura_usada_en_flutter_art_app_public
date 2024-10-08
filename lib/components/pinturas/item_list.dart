import 'package:art_mix/components/item_image_pintura_carousel.dart';
import 'package:art_mix/components/item_promocion._banner_mobile.dart';
import 'package:art_mix/models/promocionBannerMobile.dart';
import 'package:flutter/material.dart';
import '../../models/item.dart';
//import '../compact_item_job.dart';
import 'package:card_swiper/card_swiper.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ItemrList extends StatelessWidget {
  List<Item> burgers;
  //List<Job> jobs;

  ItemrList(this.burgers, {super.key});

  @override
  Widget build(BuildContext context) {

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Número de columnas en la cuadrícula
        crossAxisSpacing: 8.0, // Espacio horizontal entre elementos
        mainAxisSpacing: 8.0, // Espacio vertical entre elementos
      ),
      //shrinkWrap: true,
      //physics: NeverScrollableScrollPhysics(),
      itemCount: burgers.length,
      itemBuilder: (BuildContext context, int index) {
        final burger = burgers[index];
        return GestureDetector(
          onTap: () {
            // Manejar el evento de toque para cada pintura si es necesario
            print(burger.name);
            _showDetailsDialog(context, burgers[index]);
          },
          child: Card(
            //color: Color.fromARGB(133, 158, 158, 158),
            color: const Color(0xFFfdfdfd),
            
            elevation: 0,
            child: Image.network(
              burger.imageUrl,
              //fit: BoxFit.,
            ),
          ),

        );
      },
    );

  }
  void _showDetailsDialog(BuildContext context, Item painting) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 1.00,
          maxChildSize: 1.0,
          minChildSize: 0.70,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: GestureDetector(
                          onTap: () {
                            _showImageDialog(context, painting.imageUrl);
                          },
                          child: Image.network(
                            painting.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          painting.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '\$${painting.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Descripción: Esta pintura captura la belleza majestuosa de la naturaleza en todo su esplendor. Con una paleta de colores vibrantes y pinceladas sueltas, el artista ha plasmado un paisaje exuberante y sereno. La escena muestra un extenso campo de flores silvestres que se extiende hasta el horizonte, mientras que un río tranquilo serpentea a través de la tierra pintoresca.\n\nLa luz del sol derrama su cálida luz sobre el paisaje, creando sutiles sombras y reflejos en el agua. El cielo despejado y azul brinda un fondo perfecto para resaltar la abundancia de la naturaleza en primer plano.\n\nCada detalle, desde las delicadas pinceladas que componen las flores hasta la textura de los árboles lejanos, demuestra la habilidad y pasión del artista por capturar la esencia misma de la naturaleza. Esta obra invita al espectador a sumergirse en la tranquilidad y armonía que solo la naturaleza puede ofrecer.',
                        ),
                      ),
                      if (painting.imagesUrl.length > 1)
                        _forYou__2(painting.imagesUrl),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cerrar'),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 8.0,
                    left: 8.0,
                    child: SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[100],
                        ),
                        child: IconButton(
                          iconSize: 24.0,
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding:
              EdgeInsets.zero, // Para eliminar el espacio alrededor del diálogo
          child: Stack(
            children: [
              SizedBox(
                //height: 600, // Altura deseada para la imagen
                height: 700, // Altura deseada para la imagen
                child: PhotoViewGallery.builder(
                  itemCount: 1,
                  backgroundDecoration:
                      const BoxDecoration(color: Colors.white),
                  builder: (context, index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(imageUrl),
                      initialScale: PhotoViewComputedScale.contained,
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 2.0,
                    );
                  },
                ),
              ),
              Positioned(
                top: 8.0,
                left: 8.0,
                child: SizedBox(
                  width: 40.0, // Ancho deseado para el botón
                  height: 40.0, // Altura deseada para el botón
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      //color: Colors.white,
                      color: Colors.grey[100],
                      /*
                      border: Border.all(
                        color: Colors.black,
                        width: 4.0,
                      ),
                      */
                    ),
                    alignment: Alignment.center,
                    child: IconButton(
                      iconSize: 24.0, // Tamaño del ícono del botón
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _forYou__(context) {
    print('hola11');
    List<BannerMobile> bannersMobile = [
      BannerMobile(
        id: 'id',
        urlImage:
            'https://firebasestorage.googleapis.com/v0/b/art-mix-1b9f0.appspot.com/o/pintura01.jpg?alt=media&token=870d2655-644c-43cb-a07f-7db003241a62',
      ),
      BannerMobile(
          id: 'id',
          urlImage:
              'https://firebasestorage.googleapis.com/v0/b/art-mix-1b9f0.appspot.com/o/pintura01.jpg?alt=media&token=870d2655-644c-43cb-a07f-7db003241a62'),
    ];
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
          //return bannersMobile.map((e) => ItemPromocion(e, themeDark: true)).toList();
          return ItemPromocionBannerMobile(bannersMobile[index]);
        },
        //bannersMobile.map((e) => ItemPromocion(e, themeDark: true)).toList(),
        //itemCount: bannersMobile.length,
        itemCount: bannersMobile.length,
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
  }

  Widget _forYou__2(List<String> imagesURL) {
    print('hola11');
    return Container(
      width: double.infinity,
      height: 400,
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
          //return bannersMobile.map((e) => ItemPromocion(e, themeDark: true)).toList();
          return ItemImageBannerMobile(imagesURL[index]);
        },
        //bannersMobile.map((e) => ItemPromocion(e, themeDark: true)).toList(),
        //itemCount: bannersMobile.length,
        itemCount: imagesURL.length,
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
  }
}
