import 'package:flutter/material.dart';
import 'package:textz/Helpers/IOSHelpers.dart';

class IOSMessage extends StatelessWidget {
  const IOSMessage({super.key, required this.message, this.sent = false, required this.time});
  final String message;
  final bool sent;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: sent ? Colors.white : const Color(0xFF2672ff),
          borderRadius: BorderRadius.circular(15.0).copyWith(
            bottomRight: sent ? Radius.zero : const Radius.circular(15.0),
            bottomLeft: sent ? const Radius.circular(15.0) : Radius.zero,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message,
              style: TextStyle(
                color: sent ? Colors.black : Colors.white,
                fontSize: 16.0,
              ),
            ),
            Text(
              IOSHelpers.getTimeString(time, false),
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: !sent ? Colors.white : Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
