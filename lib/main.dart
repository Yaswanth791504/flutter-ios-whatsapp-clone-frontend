import 'package:camera/camera.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:textz/models/UserPreference.dart';
import 'package:textz/screens/IOSHomeScreen.dart';
import 'package:textz/screens/IOSIntroScreen.dart';

List<CameraDescription> cameras = [];
UserPreference userPreference = UserPreference();
PhoneNumber phoneNumber = PhoneNumber();
Cloudinary cloudinary = Cloudinary.fromCloudName(cloudName: 'drv13gs45');

const Color blueAppColor = Color(0xFF1067FF);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp();
  userPreference.initializeLoggedIn();
  if (await userPreference.isLoggedIn()) {}
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Future<bool> _checkLoginStatus() async {
    return await userPreference.isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFF8F7F7),
        secondaryHeaderColor: blueAppColor,
        fontFamily: "SfUiText",
      ),
      home: FutureBuilder<bool>(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            // Handle error case
            return const Scaffold(
              body: Center(
                child: Text('Error loading user data'),
              ),
            );
          } else if (snapshot.hasData) {
            bool isLoggedIn = snapshot.data!;
            return isLoggedIn ? const IOSHomeScreen() : const IOSIntroScreen();
          } else {
            // Handle case where snapshot has no data
            return const Scaffold(
              body: Center(
                child: Text('Unexpected error'),
              ),
            );
          }
        },
      ),
    );
  }
}
