import 'package:flutter/material.dart';
import 'package:textz/main.dart';

class IOSSettingsScreen extends StatefulWidget {
  const IOSSettingsScreen({super.key});

  @override
  State<IOSSettingsScreen> createState() => _IOSSettingsScreenState();
}

class _IOSSettingsScreenState extends State<IOSSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            userPreference.clearLoggedIn();
          });
        },
        child: const Text('Log out'),
      ),
    );
  }
}
