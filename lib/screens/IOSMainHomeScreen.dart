import 'package:flutter/material.dart';
import 'package:textz/components/IOSHeader.dart';
import 'package:textz/components/IOSNewChat.dart';
import 'package:textz/components/IOSOptions.dart';
import 'package:textz/components/IOSSearchBar.dart';
import 'package:textz/main.dart';
import 'package:textz/models/Friends.dart';

class IOSMainHomeScreen extends StatefulWidget {
  const IOSMainHomeScreen({super.key});

  @override
  State<IOSMainHomeScreen> createState() => _IOSMainHomeScreenState();
}

class _IOSMainHomeScreenState extends State<IOSMainHomeScreen> {
  List chats = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const IOSHeader(screenName: "Chats"),
        IOSSearchBar(
          controller: _searchController,
          onChanged: (String values) {},
        ),
        const IOSOptions(),
        Flexible(
          flex: 13,
          child: chats.isNotEmpty
              ? ListView(
                  children: [
                    IOSNewChat(
                        friend: Friends(
                      name: 'yaswanth',
                      email: 'user@email.com',
                      phone_number: '8106344135',
                      about: 'anything',
                      profile_picture:
                          'https://res.cloudinary.com/drv13gs45/image/upload/v1717225334/ios-whatsapp/default.jpg',
                    ))
                  ],
                )
              : const Center(
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Click on the ',
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    Icon(
                      Icons.edit_square,
                      size: 32.0,
                      color: blueAppColor,
                    ),
                    Text(
                      ' to start chat on top right',
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                )),
        )
      ],
    );
  }
}
