import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class cameraHomeScreen extends StatefulWidget {
  const cameraHomeScreen({super.key});

  @override
  State<cameraHomeScreen> createState() => _cameraHomeScreenState();
}

class _cameraHomeScreenState extends State<cameraHomeScreen> {
  File? _imageFile;
  List<File> _listImageFile = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('camera'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_imageFile != null) Image.file(_imageFile!),
            Container(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _listImageFile.length,
                itemBuilder: (context, index) {
                  return Image.file(_listImageFile[index]);
                },
              ),
            ),
            //mengambil gambar dari foto kamera belakang
            ElevatedButton(
                onPressed: () async {
                  final PickedFile =
                      // ignore: deprecated_member_use
                      await ImagePicker().getImage(
                    source: ImageSource.camera,
                    imageQuality: 50,
                    maxWidth: 1080,
                    maxHeight: 1920,
                    preferredCameraDevice: CameraDevice.rear,
                  );
                  if (PickedFile != null) {
                    setState(() {
                      _imageFile = File(PickedFile.path);
                    });
                  }
                },
                child: Text('buka kamera')),

            //mengambil gambar dari galeri
            ElevatedButton(
                onPressed: () async {
                  final PickedFile =
                      // ignore: deprecated_member_use
                      await ImagePicker().getImage(
                    source: ImageSource.gallery,
                    imageQuality: 50,
                    maxWidth: 1080,
                    maxHeight: 1920,
                  );
                  if (PickedFile != null) {
                    setState(() {
                      _imageFile = File(PickedFile.path);
                    });
                  }
                },
                child: Text('buka galeri')),

            //mengambil video dari kamera
            ElevatedButton(
                onPressed: () async {
                  final PickedFile =
                      // ignore: deprecated_member_use
                      await ImagePicker().getVideo(
                    source: ImageSource.camera,
                    maxDuration: Duration(),
                    preferredCameraDevice: CameraDevice.rear,
                  );
                  if (PickedFile != null) {
                    setState(() {
                      _imageFile = File(PickedFile.path);
                    });
                  }
                },
                child: Text('buka video')),

            //memgambil gambar di galeri secara banyak
            ElevatedButton(
                onPressed: () async {
                  final PickedFile =
                      // ignore: deprecated_member_use
                      await ImagePicker().getMultiImage();
                  if (PickedFile != null) {
                    setState(() {
                      PickedFile.forEach((element) {
                        _listImageFile.add(File(element.path));
                      });
                    });
                  }
                  // if (PickedFile != null) {
                  //   setState(() {
                  //     _imageFile = File(PickedFile.path);
                  //   });
                  // }
                },
                child: Text('buka galeri multi')),
          ],
        ),
      ),
    );
  }
}
