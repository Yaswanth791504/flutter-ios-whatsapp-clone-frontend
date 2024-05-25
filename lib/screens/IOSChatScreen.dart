import 'package:flutter/material.dart';
import 'package:textz/components/IOSBottomNavigationBar.dart';
import 'package:textz/models/user.dart';

class IOSChatScreen extends StatefulWidget {
  const IOSChatScreen({super.key, required this.user});
  final User user;

  @override
  State<IOSChatScreen> createState() => _IOSChatScreenState();
}

class _IOSChatScreenState extends State<IOSChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F7F7),
        toolbarHeight: 65.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            size: 60.0,
            color: blueAppColor,
          ),
        ),
        elevation: 1.0,
        shadowColor: Colors.black,
        title: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 10.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/${widget.user.image}'),
                radius: 25.0,
              ),
            ),
            Text(
              widget.user.name.split(" ").length <= 2
                  ? widget.user.name
                  : "${widget.user.name.split(" ")[0]} ${widget.user.name.split(" ")[1]}",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.videocam_outlined,
              color: blueAppColor,
              size: 45.0,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.call_outlined,
              color: blueAppColor,
              size: 35.0,
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: const [
                // Example chat messages
                ListTile(title: Text('Hello!')),
                ListTile(title: Text('Hi, how are you?')),
                ListTile(title: Text('I\'m good, thanks!')),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(0),
        color: const Color(0xFFF8F7F7),
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                color: blueAppColor,
                size: 50.0,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: const Icon(
                      Icons.sticky_note_2_outlined,
                      color: blueAppColor,
                      size: 40,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.camera_alt_outlined,
                color: blueAppColor,
                size: 40,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.mic_none_outlined,
                color: blueAppColor,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
