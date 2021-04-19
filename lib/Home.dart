import 'dart:io';
import 'package:capture_lens/geolocation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  File _image;
  final picker = ImagePicker();

  // void _takePhoto() async {
  //   final cameraPic = await picker.getImage(source: ImageSource.camera);

  //   // picker.getImage(source: ImageSource.camera)
  //   //     .then((File recordedImage) {
  //   if (cameraPic != null && cameraPic.path != null) {
  //     await GallerySaver.saveImage(cameraPic.path);
  //   }
  //   // });
  // }

  Future cameraImage() async {
    final cameraPic = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (cameraPic != null) {
        _image = File(cameraPic.path);
      } else {
        print('No image selected.');
      }
    });
    final String path = (await getApplicationDocumentsDirectory()).path;
    await _image.copy('$path/image1.png');
    print('$path/image1.png');
  }

  Future galleryImage() async {
    final picture = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (picture != null) {
        _image = File(picture.path);
      } else {
        print('No image selected.');
      }
    });

    final String path = (await getApplicationDocumentsDirectory()).path;
    await _image.copy('$path/image1.png');
    print('$path/image1.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.05,
          backgroundColor: Colors.deepPurpleAccent,
          actions: [
            IconButton(icon: Icon(Icons.share), onPressed: () async {}),
            // IconButton(
            //     icon: Icon(Icons.delete),
            //     onPressed: () {
            //       setState(() {
            //         _image.delete();
            //       });
            //     })
          ],
          centerTitle: true,
          title: Text(
            'Capture Lens',
            style: TextStyle(fontFamily: 'Schyler-Regular'),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              UserLocation(),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: _image == null
                      ? Text(
                          'Select an image from Gallery or Camera',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )
                      : Image.file(_image),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: galleryImage,
              tooltip: 'Select from Gallery',
              child: Icon(Icons.image_outlined),
            ),
            SizedBox(
              width: 8,
            ),
            FloatingActionButton(
              onPressed: cameraImage,
              tooltip: 'Pick Image',
              child: Icon(Icons.photo_camera_outlined),
            ),
          ],
        ));
  }
}
