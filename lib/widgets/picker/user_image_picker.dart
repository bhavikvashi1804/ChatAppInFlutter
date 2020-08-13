import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) pickImage;
  UserImagePicker(this.pickImage);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;
  String _imagePath = "";
  final picker = ImagePicker();

  void _imagePick() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _pickedImage = File(pickedFile.path);
      _imagePath = pickedFile.path;
    });

    widget.pickImage(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: kIsWeb
              ? _imagePath.length == 0 ? null : NetworkImage(_imagePath)
              : _pickedImage == null ? null : FileImage(_pickedImage),
        ),
        FlatButton.icon(
          onPressed: () => _imagePick(),
          icon: Icon(Icons.image),
          label: Text('Add Image'),
        ),
      ],
    );
  }
}
