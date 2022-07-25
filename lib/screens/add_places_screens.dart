// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../provider/greate_places.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
// import "package:table_calendar/table_calendar.dart";

class AddPlaceScreens extends StatefulWidget {
  static const routeName = '/add-place';
  const AddPlaceScreens({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreens> createState() => _AddPlaceScreensState();
}

class _AddPlaceScreensState extends State<AddPlaceScreens> {
  final _titleController = TextEditingController();
  File? _image;

  Future pickimage() async {
    final cam = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (cam == null) return;
    final tempary = File(cam.path);
    setState(() {
      this._image = tempary;
    });
    final appdir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(tempary.path);
    final savedImage = await tempary.copy("${appdir.path}/$filename");
  }

  void _saveData() {
    if (_titleController.text.isEmpty || _image == null) {
      return;
    }
    Provider.of<GreatPlace>(context, listen: false)
        .addplace(_titleController.text, _image!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Place"),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Tittle',
                      ),
                      controller: _titleController,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                _image != null ? FileImage(_image!) : null,
                          ),
                          Padding(padding: EdgeInsets.all(15)),
                          ElevatedButton.icon(
                              onPressed: () => pickimage(),
                              label: Text("Pick image"),
                              icon: Icon(
                                Icons.camera,
                                size: 50,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
            RaisedButton.icon(
              onPressed: _saveData,
              label: Text("Add-Place"),
              icon: Icon(Icons.add),
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: Theme.of(context).accentColor,
            )
          ]),
    );
  }
}
