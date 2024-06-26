import 'package:flutter/material.dart';
import 'package:textz/settings.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart'; // Adjust path as needed

class IOSZegoCallScreen extends StatefulWidget {
  final String callId;
  final String userId;
  const IOSZegoCallScreen(
      {super.key, required this.callId, required this.userId});

  @override
  _IOSZegoCallScreenState createState() => _IOSZegoCallScreenState();
}

class _IOSZegoCallScreenState extends State<IOSZegoCallScreen> {
  @override
  void initState() {
    super.initState();
    _joinCall();
  }

  Future<void> _joinCall() async {
    await ZegoUIKit.instance.joinRoom(widget.callId);
  }

  @override
  void dispose() {
    ZegoUIKit.instance.leaveRoom();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZegoUIKitPrebuiltCall(
        appID: appId, // Your Zego appId
        appSign: appSign, // Your Zego appSign
        callID: widget.callId,
        userID: widget.userId, // Replace with your user ID
        userName: widget.userId, // Replace with your user name
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
      ),
    );
  }
}
