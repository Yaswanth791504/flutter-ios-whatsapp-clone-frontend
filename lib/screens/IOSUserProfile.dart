import 'package:flutter/material.dart';
import 'package:textz/components/IOSCardComponent.dart';
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
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => IOSImageViewer(image: widget.friend.profile_picture)),
            ),
            child: Image.network(widget.friend.profile_picture),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 30,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                size: 50,
                Icons.chevron_left,
                color: blueAppColor,
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.55,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.transparent,
                ),
                child: ListView(
                  controller: scrollController,
                  children: <Widget>[
                    IOSCardComponent(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.friend.name,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '+91 ${widget.friend.phone_number}',
                                    style: const TextStyle(color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  padding: const EdgeInsets.all(13),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEDEDFF),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Icon(
                                    Icons.chat,
                                    color: Color(0xFF50555C),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  padding: const EdgeInsets.all(13),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEDEDFF),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Icon(
                                    Icons.videocam,
                                    color: Color(0xFF50555C),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  padding: const EdgeInsets.all(13),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEDEDFF),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Icon(
                                    Icons.phone,
                                    color: Color(0xFF50555C),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IOSCardComponent(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.friend.about,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IOSCardComponent(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.80,
                        alignment: Alignment.center,
                        child: const Text(
                          'Coming soon',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
