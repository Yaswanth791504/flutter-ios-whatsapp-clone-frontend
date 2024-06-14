import 'package:flutter/material.dart';
import 'package:textz/screens/IOSImageViewer.dart';

class IOSImageMessage extends StatefulWidget {
  const IOSImageMessage({super.key, required this.image, required this.sent});
  final bool sent;
  final String image;

  @override
  State<IOSImageMessage> createState() => _IOSImageMessageState();
}

class _IOSImageMessageState extends State<IOSImageMessage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => IOSImageViewer(image: widget.image)));
      },
      child: Align(
        alignment: widget.sent ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              widget.image,
              fit: BoxFit.cover,
              width: 150, // Set the desired width
              height: 100, // Set the desired height
            ),
          ),
        ),
      ),
    );
  }
}
