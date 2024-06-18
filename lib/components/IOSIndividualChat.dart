import 'package:flutter/material.dart';
import 'package:textz/Helpers/IOSHelpers.dart';
import 'package:textz/models/IndividualChat.dart';
import 'package:textz/screens/IOSChatScreen.dart';

class IOSIndividualChat extends StatefulWidget {
  const IOSIndividualChat({super.key, required this.friend});
  final IndividualChat friend;

  @override
  State<IOSIndividualChat> createState() => _IOSIndividualChat();
}

class _IOSIndividualChat extends State<IOSIndividualChat> {
  @override
  Widget build(BuildContext context) {
    // print(widget.friend.last_message_type);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IOSChatScreen(
              friend: widget.friend,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color(0xFFfffbfe),
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFd7d7d7),
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 10.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.friend.profile_picture),
                radius: 35.0,
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              widget.friend.name.split(" ").length <= 2
                                  ? widget.friend.name
                                  : "${widget.friend.name.split(" ")[0]} ${widget.friend.name.split(" ")[1]}",
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            if (widget.friend.last_message_type.toLowerCase() == 'image') ...[
                              const Icon(
                                Icons.image,
                                color: Color(0xFF7B7B7B),
                              ), // Show image icon
                              const SizedBox(width: 4), // Space between icon and text
                            ],
                            Text(
                              widget.friend.last_message.length < 20
                                  ? widget.friend.last_message
                                  : "${widget.friend.last_message.substring(0, 19)}...",
                              style: const TextStyle(
                                fontSize: 17.0,
                                color: Color(0xFF7B7B7B),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Text(
                    IOSHelpers.getTimeString(widget.friend.last_message_time),
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_sharp,
                    size: 30.0,
                    color: Color(0xFFC7C7CC),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
