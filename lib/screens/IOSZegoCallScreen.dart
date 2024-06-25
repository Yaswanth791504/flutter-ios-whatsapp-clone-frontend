import 'package:flutter/material.dart';
import 'package:textz/settings.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class IOSZegoCallingScreen extends StatefulWidget {
  const IOSZegoCallingScreen(
      {super.key, required this.callId, required this.userId});
  final String callId;
  final String userId;

  @override
  State<IOSZegoCallingScreen> createState() => _IOSZegoCallingScreenState();
}

class _IOSZegoCallingScreenState extends State<IOSZegoCallingScreen> {
  @override
  void initState() {
    super.initState();
    print("Initializing call screen");
    ZegoUIKit.instance.joinRoom(widget.callId);
  }

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: appId,
      appSign: appSign,
      callID: widget.callId,
      userID: widget.userId,
      userName: widget.userId,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    );
  }

  @override
  void dispose() {
    // Leave the room when the screen is disposed
    ZegoUIKit.instance.leaveRoom();
    super.dispose();
  }
}
