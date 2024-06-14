import 'package:flutter/material.dart';
import 'package:textz/main.dart';
import 'package:textz/models/IndividualChat.dart';
import 'package:textz/screens/IOSImageViewer.dart';

class IOSUserProfile extends StatefulWidget {
  const IOSUserProfile({super.key, required this.friend});
  final IndividualChat friend;

  @override
  State<IOSUserProfile> createState() => _IOSUserProfileState();
}

class _IOSUserProfileState extends State<IOSUserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => IOSImageViewer(image: widget.friend.profile_picture))),
          child: Image.network(widget.friend.profile_picture),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.chevron_left, color: blueAppColor, size: 50)),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.55,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: blueAppColor,
              ),
              child: ListView.builder(
                itemCount: 25,
                controller: scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
              ),
            );
          },
        ),
      ],
    ));
  }
}
