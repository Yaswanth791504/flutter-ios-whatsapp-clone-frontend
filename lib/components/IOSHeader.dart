import 'package:flutter/material.dart';

class IOSHeader extends StatelessWidget {
  const IOSHeader({super.key, required this.screenName});
  final String screenName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Text(
        screenName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 45.0,
        ),
      ),
    );
  }
}
