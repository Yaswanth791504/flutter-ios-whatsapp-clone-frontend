import 'package:flutter/material.dart';
import 'package:textz/components/IOSBottomNavigationBar.dart';

const TextStyle styles = TextStyle(
  fontSize: 17.0,
  color: blueAppColor,
  fontWeight: FontWeight.w400,
);

class IOSOptions extends StatelessWidget {
  const IOSOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFB3B3B3),
        ),
        color: Colors.white,
      ),
      margin: const EdgeInsets.only(top: 15.0),
      padding: const EdgeInsets.all(15.0),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Broadcast Lists',
            style: styles,
          ),
          Text(
            'New Group',
            style: styles,
          ),
        ],
      ),
    );
  }
}
