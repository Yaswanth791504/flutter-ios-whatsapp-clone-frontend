import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textz/components/IOSBottomNavigationBar.dart';

class IOSImageViewer extends StatefulWidget {
  const IOSImageViewer({super.key, required this.image});
  final String image;

  @override
  State<IOSImageViewer> createState() => _IOSImageViewerState();
}

class _IOSImageViewerState extends State<IOSImageViewer> {
  File? imageString;

  void _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    setState(() {
      imageString = File(returnedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            color: blueAppColor,
            size: 40,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: _pickImageFromGallery,
            icon: const Icon(
              Icons.edit,
              color: blueAppColor,
              size: 35,
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: imageString != null ? Image.file(imageString!) : Image.asset('assets/images/${widget.image}'),
      ),
    );
  }
}
