import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/greate_places.dart';

class PlaceDetail extends StatelessWidget {
  static const routeName = '/Place-detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments;
    final selectedPlace =
        Provider.of<GreatPlace>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(children: [
        Container(
          height: 250,
          width: double.infinity,
          child: Image.file(
            selectedPlace.image,
            fit: BoxFit.cover,
          ),
        )
      ]),
    );
  }
}
