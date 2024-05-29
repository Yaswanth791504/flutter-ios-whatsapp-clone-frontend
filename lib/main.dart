import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:textz/models/UserPreference.dart';
import 'package:textz/screens/IOSHomeScreen.dart';
import 'package:textz/screens/IOSIntroScreen.dart';

List<CameraDescription> cameras = [];
UserPreference userPreference = UserPreference();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp();
  userPreference.initializeLoggedIn();
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
          // Check if the future has completed
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting
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
            // Based on login status show appropriate screen
            bool isLoggedIn = snapshot.data!;
            print(isLoggedIn);
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
