import 'package:flutter/cupertino.dart';
import 'package:textz/components/IOSCamera.dart';

class IOSCameraScreen extends StatefulWidget {
  const IOSCameraScreen({super.key});

  @override
  State<IOSCameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<IOSCameraScreen> {
  @override
  Widget build(BuildContext context) {
    return IOSCamera(
      onPressed: () {},
    );
  }
}
