import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../models/places.dart';
import '../helperdb/db_helper.dart';

class GreatPlace with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addplace(String pickedtitle, File pickedImage) {
    // ignore: unused_local_variable
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedtitle,
      image: pickedImage,
    );
    _items.add(newPlace);
    notifyListeners();
    dbhelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final datalist = await dbhelper.getData('user_places');
    _items = datalist
        .map((items) => Place(
            id: items['id'],
            title: items['title'],
            image: File(items['image'])))
        .toList();
    notifyListeners();
  }
}
