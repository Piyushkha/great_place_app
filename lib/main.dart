// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '/screens/add_places_screens.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart;
import './provider/greate_places.dart';
import 'screens/place_list_screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: GreatPlace(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.indigo, accentColor: Colors.amber),
            home: MyHomepage(),
            routes: {
              AddPlaceScreens.routeName: (ctx) => AddPlaceScreens(),
            }));
  }
}
