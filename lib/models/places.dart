import 'dart:io';

class PlaceLoaction {
  final double latitude;
  final double longitude;
  final String placeaddress;

  PlaceLoaction(
      {required this.latitude,
      required this.longitude,
      required this.placeaddress});
}

class Place {
  final String id;
  final String title;
  // final PlaceLoaction locationVisit;
  final File image;

  Place({required this.id, required this.title, required this.image});
}
