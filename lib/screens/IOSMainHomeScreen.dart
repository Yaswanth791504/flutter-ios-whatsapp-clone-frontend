import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:textz/components/IOSContact.dart';
import 'package:textz/components/IOSHeader.dart';
import 'package:textz/components/IOSOptions.dart';
import 'package:textz/components/IOSSearchBar.dart';
import 'package:textz/models/user.dart';

class IOSMainHomeScreen extends StatefulWidget {
  const IOSMainHomeScreen({super.key});

  @override
  State<IOSMainHomeScreen> createState() => _IOSMainHomeScreenState();
}

class _IOSMainHomeScreenState extends State<IOSMainHomeScreen> {
  List<User> users = [
    User(
        name: 'Steve yaswanth Rodriguez',
        lastMessage: 'There is a lot to talk about',
        seen: true,
        time: '4:16 PM',
        image: 'pic1.jpg'),
    User(name: 'Miles Thompson', lastMessage: 'I got you bro ', seen: false, time: '4:16 PM', image: 'pic2.jpg'),
    User(
        name: 'Amanda James',
        lastMessage: 'Can’t wait for tomorrow ☺️😍😍',
        seen: true,
        time: '4:16 PM',
        image: 'pic3.jpg'),
    User(name: 'Grace Teresa', lastMessage: 'Can you call?? 😕', seen: true, time: '4:16 PM', image: 'pic4.jpg'),
    User(name: 'Holly', lastMessage: 'Party Night?', seen: false, time: '4:16 PM', image: 'pic5.jpg'),
    User(name: 'Grace Teresa', lastMessage: 'Weekend Movie', seen: true, time: '4:16 PM', image: 'pic6.jpg'),
    User(name: 'Grace Teresa', lastMessage: 'Weekend Movie', seen: true, time: '4:16 PM', image: 'pic7.jpg'),
    User(name: 'Grace Teresa', lastMessage: 'Weekend Movie', seen: true, time: '4:16 PM', image: 'pic8.jpg'),
    User(name: 'Grace Teresa', lastMessage: 'Weekend Movie', seen: true, time: '4:16 PM', image: 'pic9.jpg'),
    User(name: 'Grace Teresa', lastMessage: 'Weekend Movie', seen: true, time: '4:16 PM', image: 'pic10.jpg'),
    User(name: 'Grace Teresa', lastMessage: 'Weekend Movie', seen: true, time: '4:16 PM', image: 'pic11.jpg'),
    User(name: 'Grace Teresa', lastMessage: 'Weekend Movie', seen: true, time: '4:16 PM', image: 'pic12.jpg'),
    User(name: 'Grace Teresa', lastMessage: 'Weekend Movie', seen: true, time: '4:16 PM', image: 'pic13.jpg'),
    User(name: 'Grace Teresa', lastMessage: 'Weekend Movie', seen: true, time: '4:16 PM', image: 'pic14.jpg'),
    User(name: 'Grace Teresa', lastMessage: 'Weekend Movie', seen: true, time: '4:16 PM', image: 'pic15.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const IOSHeader(screenName: "Chats"),
        const IOSSearchBar(),
        const IOSOptions(),
        Flexible(
          flex: 13,
          child: ListView(
            children: users.map((user) => IOSContact(user: user)).toList(),
          ),
        )
      ],
    );
  }
}
