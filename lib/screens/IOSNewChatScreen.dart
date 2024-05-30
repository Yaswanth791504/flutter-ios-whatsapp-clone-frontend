import 'package:flutter/material.dart';
import 'package:textz/components/IOSBottomNavigationBar.dart';
import 'package:textz/components/IOSContact.dart';
import 'package:textz/components/IOSSearchBar.dart';
import 'package:textz/models/user.dart';

class IOSNewChatScreen extends StatefulWidget {
  const IOSNewChatScreen({super.key});

  @override
  State<IOSNewChatScreen> createState() => _IOSNewChatScreenState();
}

class _IOSNewChatScreenState extends State<IOSNewChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.chevron_left,
                    color: blueAppColor,
                    size: 40,
                  ),
                ),
                const IOSSearchBar(),
              ],
            ),
            Expanded(
                child: ListView(
              children: [
                IOSContact(
                  user: User(image: 'pic1.jpg', name: 'yaswanth', lastMessage: 'message', seen: false, time: 'ins'),
                  newChat: true,
                ),
                IOSContact(
                  user: User(image: 'pic1.jpg', name: 'yaswanth', lastMessage: 'message', seen: false, time: 'ins'),
                  newChat: true,
                ),
                IOSContact(
                  user: User(image: 'pic1.jpg', name: 'yaswanth', lastMessage: 'message', seen: false, time: 'ins'),
                  newChat: true,
                ),
                IOSContact(
                  user: User(image: 'pic1.jpg', name: 'yaswanth', lastMessage: 'message', seen: false, time: 'ins'),
                  newChat: true,
                ),
                IOSContact(
                  user: User(image: 'pic1.jpg', name: 'yaswanth', lastMessage: 'message', seen: false, time: 'ins'),
                  newChat: true,
                ),
                IOSContact(
                  user: User(image: 'pic1.jpg', name: 'yaswanth', lastMessage: 'message', seen: false, time: 'ins'),
                  newChat: true,
                ),
                IOSContact(
                  user: User(image: 'pic1.jpg', name: 'yaswanth', lastMessage: 'message', seen: false, time: 'ins'),
                  newChat: true,
                ),
                IOSContact(
                  user: User(image: 'pic1.jpg', name: 'yaswanth', lastMessage: 'message', seen: false, time: 'ins'),
                  newChat: true,
                ),
                IOSContact(
                  user: User(image: 'pic1.jpg', name: 'yaswanth', lastMessage: 'message', seen: false, time: 'ins'),
                  newChat: true,
                ),
                IOSContact(
                  user: User(image: 'pic1.jpg', name: 'yaswanth', lastMessage: 'message', seen: false, time: 'ins'),
                  newChat: true,
                ),
                IOSContact(
                  user: User(image: 'pic1.jpg', name: 'yaswanth', lastMessage: 'message', seen: false, time: 'ins'),
                  newChat: true,
                ),
                IOSContact(
                  user: User(image: 'pic1.jpg', name: 'yaswanth', lastMessage: 'message', seen: false, time: 'ins'),
                  newChat: true,
                ),
                IOSContact(
                  user: User(image: 'pic1.jpg', name: 'yaswanth', lastMessage: 'message', seen: false, time: 'ins'),
                  newChat: true,
                ),
                IOSContact(
                  user: User(image: 'pic1.jpg', name: 'yaswanth', lastMessage: 'message', seen: false, time: 'ins'),
                  newChat: true,
                ),
                IOSContact(
                  user: User(image: 'pic1.jpg', name: 'yaswanth', lastMessage: 'message', seen: false, time: 'ins'),
                  newChat: true,
                ),
                IOSContact(
                  user: User(image: 'pic1.jpg', name: 'yaswanth', lastMessage: 'message', seen: false, time: 'ins'),
                  newChat: true,
                ),
                IOSContact(
                  user: User(image: 'pic1.jpg', name: 'yaswanth', lastMessage: 'message', seen: false, time: 'ins'),
                  newChat: true,
                ),
                IOSContact(
                  user: User(image: 'pic1.jpg', name: 'yaswanth', lastMessage: 'message', seen: false, time: 'ins'),
                  newChat: true,
                ),
                IOSContact(
                  user: User(image: 'pic1.jpg', name: 'yaswanth', lastMessage: 'message', seen: false, time: 'ins'),
                  newChat: true,
                ),
                IOSContact(
                  user: User(image: 'pic1.jpg', name: 'yaswanth', lastMessage: 'message', seen: false, time: 'ins'),
                  newChat: true,
                ),
                IOSContact(
                  user: User(image: 'pic1.jpg', name: 'yaswanth', lastMessage: 'message', seen: false, time: 'ins'),
                  newChat: true,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
