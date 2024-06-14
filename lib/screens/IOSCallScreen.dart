import 'package:flutter/material.dart';
import 'package:textz/components/IOSHeader.dart';

class IOSCallScreen extends StatefulWidget {
  const IOSCallScreen({super.key});

  @override
  State<IOSCallScreen> createState() => _IOSCallScreenState();
}

class _IOSCallScreenState extends State<IOSCallScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        IOSHeader(screenName: "Calls"),
      ],
    );
  }
}
