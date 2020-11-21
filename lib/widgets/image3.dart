import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hacakthon_app/models/blueprint.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
//import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:firebase_storage/firebase_storage.dart';

class Image3 extends StatefulWidget {
  @override
  _Image3State createState() => _Image3State();
}

class _Image3State extends State<Image3> {
  File _storedImage;
  bool pressed = false;
  bool iconPressed = false;

  final _picker = ImagePicker();

  Future<void> _takePicture() async {
    final imageFile = await _picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
      Models.image3 = _storedImage;
    });
    // final appDir = await syspaths.getApplicationDocumentsDirectory();
    // final fileName = path.basename(imageFile.path);
    //final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    //widget.onSelectImage(savedImage);
  }

  Future uploadImage3(BuildContext context) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('User Images/${Path.basename(_storedImage.path)}}');

    // .child('User Picked Image/')
    // .child(Models.userUid + '.jpg');
    StorageUploadTask uploadTask = storageReference.putFile(_storedImage);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        Models.image3Url = fileURL;
        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Third image uploaded successfully...',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: _takePicture,
              child: Container(
                width: 180,
                height: 130,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                ),
                child: _storedImage != null
                    ? Image.file(
                        _storedImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : Image.asset(
                        'images/addimage.png',
                        height: 105,
                        width: 125,
                        fit: BoxFit.cover,
                      ),
                alignment: Alignment.center,
              ),
            ),
          ),
          SizedBox(
            width: 3.0,
          ),
          ClipOval(
            child: Material(
              color: pressed ? Colors.black : Colors.black,
              child: InkWell(
                child: SizedBox(
                  width: 46,
                  height: 46,
                  child: Icon(
                    iconPressed ? Icons.done_outline : Icons.file_upload,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  setState(() {
                    pressed = !pressed;
                    iconPressed = !iconPressed;
                  });
                  uploadImage3(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
