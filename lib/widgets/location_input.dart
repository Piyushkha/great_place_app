import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
// import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
// import '../helperdb/location_helper.dart';
// import 'package:location_platform_interface/location_platform_interface.dart';

class LocationInput extends StatefulWidget {
  LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  // String? _priviewImageUrl;
  Position? _currentLoaction;
  String? _currentAddress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            // decoration:
            // BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
            height: 20,
            width: double.infinity,
            child: Text(
              DateTime.now().toString(),
              textAlign: TextAlign.center,
            )),
        Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
            height: 40,
            width: double.infinity,
            child: _currentAddress != null
                ? Center(child: Text(_currentAddress!))
                : null),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ignore: deprecated_member_use
            FlatButton.icon(
              onPressed: _getCurrentLoacation,
              icon: const Icon(Icons.map),
              label: const Text("Get Location"),
              textColor: Theme.of(context).primaryColor,
            )
          ],
        )
      ],
    );
  }

  _getCurrentLoacation() {
    Geolocator.getCurrentPosition(forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentLoaction = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentLoaction!.latitude, _currentLoaction!.longitude);

      Placemark first = placemarks[0];

      setState(() {
        _currentAddress =
            ('${first.locality},${first.administrativeArea}, ${first.postalCode},${first.country}');
      });
    } catch (e) {
      print(e);
    }
  }
}
