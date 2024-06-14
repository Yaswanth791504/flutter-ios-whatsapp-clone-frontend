import 'package:flutter/material.dart';
import 'package:textz/components/IOSHeader.dart';

class IOSStatusScreen extends StatefulWidget {
  const IOSStatusScreen({super.key});

  @override
  State<IOSStatusScreen> createState() => _IOSCallScreenState();
}

class _IOSCallScreenState extends State<IOSStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        IOSHeader(screenName: "Status"),
      ],
    );
  }
}
