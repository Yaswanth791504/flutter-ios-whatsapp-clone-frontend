import 'package:flutter/material.dart';
import 'package:textz/models/user.dart';
import 'package:textz/screens/IOSChatScreen.dart';

class IOSContact extends StatefulWidget {
  const IOSContact({super.key, required this.user, this.newChat = false});
  final User user;
  final bool newChat;

  @override
  State<IOSContact> createState() => _IOSContactState();
}

class _IOSContactState extends State<IOSContact> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IOSChatScreen(user: widget.user),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
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
                backgroundImage: AssetImage('assets/images/${widget.user.image}'),
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
                              widget.user.name.split(" ").length <= 2
                                  ? widget.user.name
                                  : "${widget.user.name.split(" ")[0]} ${widget.user.name.split(" ")[1]}",
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            !widget.newChat
                                ? Text(
                                    widget.user.time,
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      color: Color(0xFF7B7B7B),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            !widget.newChat
                                ? Icon(
                                    widget.user.seen ? Icons.done_all_outlined : Icons.check,
                                    color: const Color(0xFF7B7B7B),
                                  )
                                : const SizedBox(),
                            Text(
                              widget.user.lastMessage.length < 20
                                  ? widget.user.lastMessage
                                  : "${widget.user.lastMessage.substring(0, 19)}...",
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
