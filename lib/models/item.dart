import 'package:art_mix/models/puja.dart';

class Item {
  final String name;
  final String imageUrl;
  final double price;
  final String currency_code;
  final List<String> imagesUrl;
  final List<Puja> pujas;

  Item({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.currency_code,
    required this.imagesUrl,
    required this.pujas,
  });
}
