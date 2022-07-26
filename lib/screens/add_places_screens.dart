import 'package:flutter/material.dart';
import 'package:great_place/widgets/location_input.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../provider/greate_places.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import '../widgets/location_input.dart';

class AddPlaceScreens extends StatefulWidget {
  static const routeName = '/add-place';
  const AddPlaceScreens({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreens> createState() => _AddPlaceScreensState();
}

class _AddPlaceScreensState extends State<AddPlaceScreens> {
  final _titleController = TextEditingController();
  File? _image;
  File? temimage;

  Future pickimage() async {
    // final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    temimage = File(image.path);
    setState(() {
      this._image = temimage;
    });
    final appdir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(temimage!.path);
    final savedImage = await temimage!.copy("${appdir.path}/$filename");
  }

  Future pickimagecam() async {
    // final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final cam = await ImagePicker().pickImage(source: ImageSource.camera);

    if (cam == null) return;

    temimage = File(cam.path);
    setState(() {
      this._image = temimage;
    });
    final appdir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(temimage!.path);
    final savedImage = await temimage!.copy("${appdir.path}/$filename");
  }

  void _showModel(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Container(
            child: Wrap(
              children: [
                ListTile(
                  title: Text("Gallery"),
                  leading: Icon(Icons.browse_gallery),
                  onTap: () {
                    pickimage();
                    Navigator.of(context).pop();
                  },
                ),
                // _image != null ?  : pickimage),
                ListTile(
                  title: Text("Camera"),
                  leading: Icon(Icons.camera),
                  onTap: () {
                    pickimagecam();
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ));
        });
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
                          Stack(alignment: Alignment.center, children: [
                            CircleAvatar(
                              radius: 87,
                              backgroundColor: Colors.black,
                            ),
                            CircleAvatar(
                              radius: 85,
                              backgroundColor: Colors.white,
                            ),
                            CircleAvatar(
                              radius: 80,
                              backgroundColor: Colors.grey[400],
                              backgroundImage:
                                  _image != null ? FileImage(_image!) : null,
                            ),
                            Positioned(
                                bottom: 0,
                                right: -25,
                                child: RawMaterialButton(
                                  onPressed: () {
                                    _showModel(context);
                                  },
                                  elevation: 4.0,
                                  fillColor: Color(0xFFF5F6F9),
                                  child: Icon(
                                    Icons.edit_outlined,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(15.0),
                                  shape: CircleBorder(),
                                )),
                          ]),
                          Padding(padding: EdgeInsets.all(15)),
                          SizedBox(
                            height: 15,
                          ),
                          LocationInput()
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
