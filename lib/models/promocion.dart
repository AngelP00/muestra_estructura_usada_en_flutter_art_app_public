//import './company.dart';

class Promocion {
  final String location;
  final String role;
  //final Company company;
  bool isFavorite;

  Promocion(
      {required this.role,
      required this.location,
      //required this.company,
      this.isFavorite = false});
}
