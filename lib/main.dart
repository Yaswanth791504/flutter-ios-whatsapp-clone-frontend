import 'package:camera/camera.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:textz/Api/firebase_notifications.dart';
import 'package:textz/components/IOSCircularProgressIndicator.dart';
import 'package:textz/models/UserPreference.dart';
import 'package:textz/screens/IOSHomeScreen.dart';
import 'package:textz/screens/IOSIntroScreen.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

List<CameraDescription> cameras = [];
UserPreference userPreference = UserPreference();
PhoneNumber phoneNumber = PhoneNumber();
Cloudinary cloudinary = Cloudinary.fromCloudName(cloudName: 'drv13gs45');
final navigatorKey = GlobalKey<NavigatorState>();
const Color blueAppColor = Color(0xFF1067FF);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  try {
    cameras = await availableCameras();
  } catch (e) {
    debugPrint('Error fetching cameras: $e');
  }
  await Firebase.initializeApp();
  await FirebaseNotifications().initNotifications();
  await userPreference.initializeLoggedIn();
  await ZegoUIKit().initLog();
  ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
    [ZegoUIKitSignalingPlugin()],
  );
  runApp(MainApp(navigatorKey: navigatorKey));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key, required this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Future<bool> _checkLoginStatus() async {
    return await userPreference.isLoggedIn();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: widget.navigatorKey,
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
                child: IOSCircularProgressIndicator(),
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
