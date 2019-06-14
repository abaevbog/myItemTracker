import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

class ImageInput extends StatefulWidget {
  Function setImg;
  ImageInput(this.setImg);

  @override
  State<StatefulWidget> createState() {
    return ImageInputState();
  }
}

class ImageInputState extends State<ImageInput> {
  File _imgFile;
  void _getImage(BuildContext context, ImageSource src) {
    ImagePicker.pickImage(source: src, maxWidth: 400).then((File file) {
      setState(() {
        _imgFile = file;
      });
      widget.setImg(file);
      Navigator.of(context).pop();
    });
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150,
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Text("Pick an image"),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  child: Text("Use camera"),
                  textColor: Theme.of(context).accentColor,
                  onPressed: () {
                    _getImage(context, ImageSource.camera);
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                FlatButton(
                  child: Text("From gallery"),
                  textColor: Theme.of(context).accentColor,
                  onPressed: () {
                    _getImage(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        OutlineButton(
          borderSide: BorderSide.none,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.camera_alt),
              SizedBox(width: 5),
              Text("Add image")
            ],
          ),
          onPressed: () {
            _openImagePicker(context);
          },
        ),
        SizedBox(height: 10),
        _imgFile == null
            ? Text("Please pick an image")
            : Image.file(
                _imgFile,
                fit: BoxFit.cover,
                height: 300,
                alignment: Alignment.topCenter,
                width: MediaQuery.of(context).size.width * 0.9,
              ),
      ],
    );
  }
}
