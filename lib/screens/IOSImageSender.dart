import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:textz/Api/statusRequests.dart';
import 'package:textz/main.dart';

class IOSImageSender extends StatefulWidget {
  const IOSImageSender({super.key, required this.image, required this.onPressed});
  final XFile image;
  final onPressed;

  @override
  State<IOSImageSender> createState() => _IOSImageSenderState();
}

class _IOSImageSenderState extends State<IOSImageSender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            size: 40,
            color: blueAppColor,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.file(
              File(widget.image.path),
              fit: BoxFit.contain, // Ensure the image fits within its container
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
              ),
              onPressed: () {
                uploadImageStatus(widget.image.path);
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.send_outlined,
                color: blueAppColor,
                size: 30.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
