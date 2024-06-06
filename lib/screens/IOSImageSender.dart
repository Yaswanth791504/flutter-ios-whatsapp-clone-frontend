import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:textz/main.dart';

class IOSImageSender extends StatefulWidget {
  const IOSImageSender({super.key, required this.image});
  final XFile image;

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
          Image.file(File(widget.image.path)),
          Positioned(
            right: 10,
            bottom: 10,
            child: ElevatedButton(
              style: const ButtonStyle(
                shape: MaterialStatePropertyAll(CircleBorder()),
                iconSize: MaterialStatePropertyAll(30.0),
                padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
              ),
              onPressed: () {},
              child: const Icon(
                Icons.send_outlined,
                color: blueAppColor,
                // size: 40.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
