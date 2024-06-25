import 'package:flutter/material.dart';
import 'package:textz/Api/call_requests.dart';
import 'package:textz/Helpers/IOSHelpers.dart';
import 'package:textz/components/IOSHeader.dart';
import 'package:textz/main.dart';
import 'package:textz/models/Call.dart';

class IOSCallComponent extends StatefulWidget {
  const IOSCallComponent({super.key, required this.call});
  final Call call;

  @override
  State<IOSCallComponent> createState() => _IOSCallComponentState();
}

class _IOSCallComponentState extends State<IOSCallComponent> {
  void _handleOnDismissed(DismissDirection direction) {
    deleteCall(widget.call.callerId);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: _handleOnDismissed,
      background: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.centerRight,
          color: blueAppColor,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.delete,
                color: Colors.white,
                size: 30,
              ),
              Icon(
                Icons.delete,
                color: Colors.white,
                size: 30,
              ),
            ],
          )),
      key: ValueKey<int>(widget.call.callerId),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color(0xFFf8f7f7),
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFd7d7d7),
            ),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.call.profilePicture),
              radius: 25,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 30,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.call.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                  ),
                  widget.call.sent
                      ? const Row(
                          children: [
                            Icon(
                              Icons.call_received,
                              color: blueAppColor,
                              size: 13,
                            ),
                            Text('In coming call')
                          ],
                        )
                      : const Row(
                          children: [
                            Icon(
                              Icons.call_made,
                              color: blueAppColor,
                              size: 13,
                            ),
                            Text('Out going call')
                          ],
                        ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                widget.call.sent
                    ? const Icon(
                        Icons.call,
                        color: blueAppColor,
                        size: 30,
                      )
                    : const Icon(
                        Icons.video_call,
                        color: blueAppColor,
                        size: 30,
                      ),
                Text(IOSHelpers.getTimeString(widget.call.startedAt, true)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
