import 'dart:async';

import 'package:flutter/material.dart';
import 'package:textz/main.dart';
import 'package:textz/screens/IOSMainHomeScreen.dart';

class IOSIntroSuccessScreen extends StatefulWidget {
  const IOSIntroSuccessScreen({super.key});

  @override
  State<IOSIntroSuccessScreen> createState() => _IOSIntroSuccessScreenState();
}

class _IOSIntroSuccessScreenState extends State<IOSIntroSuccessScreen> {
  @override
  void initState() {
    super.initState();
    print(userPreference.isLoggedIn());
    userPreference.setLoggedIn();
    print(userPreference.isLoggedIn());
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) => const IOSMainHomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Initializing App ....',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Image(
          image: AssetImage('assets/images/intro-bg.png'),
        ),
        SizedBox(
          height: 100,
        ),
        CircularProgressIndicator(
          strokeWidth: 5.0,
        ),
      ],
    );
  }
}
