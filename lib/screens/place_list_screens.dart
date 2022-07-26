import 'package:flutter/material.dart';
import 'package:great_place/screens/add_places_screens.dart';
import 'package:great_place/screens/place_detail_screens.dart';
import 'package:provider/provider.dart';
import './add_places_screens.dart';
import '../provider/greate_places.dart';

class MyHomepage extends StatefulWidget {
  const MyHomepage({Key? key}) : super(key: key);

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Visit Places"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPlaceScreens.routeName);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlace>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<GreatPlace>(
                  child: Center(
                    child: Text("No data"),
                  ),
                  builder: (ctx, greateplaces, chh) =>
                      greateplaces.items.length <= 0
                          ? chh!
                          : ListView.builder(
                              itemCount: greateplaces.items.length,
                              itemBuilder: (ctx, i) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(greateplaces.items[i].image),
                                ),
                                title: Text(greateplaces.items[i].title),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      PlaceDetail.routeName,
                                      arguments: greateplaces.items[i].id);
                                },
                              ),
                            ),
                ),
        ));
  }
}
