import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:textz/screens/IOSHomeScreen.dart';

import 'components/IOSCamera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const IOSHomeScreen();
  }
}
