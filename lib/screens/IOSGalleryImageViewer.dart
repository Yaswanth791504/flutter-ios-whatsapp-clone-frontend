import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:textz/Api/sockets.dart';
import 'package:textz/Api/user_requests.dart';
import 'package:textz/components/IOSCircularProgressIndicator.dart';
import 'package:textz/main.dart';

class IOSGalleryImageViewer extends StatefulWidget {
  const IOSGalleryImageViewer(
      {super.key,
      required this.file,
      required this.phoneNumber,
      required this.socketInstance,
      required this.updateChats});
  final updateChats;
  final IosSocket? socketInstance;
  final String phoneNumber;

  final Future<File?> file;
  @override
  State<IOSGalleryImageViewer> createState() => _IOSGalleryImageViewerState();
}

class _IOSGalleryImageViewerState extends State<IOSGalleryImageViewer> {
  bool _sending = false;

  Future<void> _sendImage() async {
    setState(() {
      _sending = true;
    });
    final file = await widget.file;
    if (file != null) {
      final imageLink = await sendImageToUser(file.path, widget.phoneNumber);
      widget.socketInstance?.sendMessage(imageLink, widget.phoneNumber, 'image');
    }
    await widget.updateChats();
    setState(() {
      _sending = false;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: blueAppColor,
          onPressed: () => _sendImage(),
          child: _sending
              ? Container(
                  decoration: BoxDecoration(
                    color: blueAppColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const IOSCircularProgressIndicator(
                    appColor: Colors.white,
                  ),
                )
              : const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xFF000000),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.chevron_left,
              size: 40,
              color: blueAppColor,
            ),
          ),
        ),
        body: FutureBuilder<File>(
          future: widget.file.then((onValue) => onValue!),
          builder: (_, snapshot) {
            final file = snapshot.data;
            if (file == null) return Container();
            return PhotoView(imageProvider: FileImage(file));
          },
        ));
  }
}
