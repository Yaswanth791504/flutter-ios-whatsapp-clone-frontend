import 'package:flutter/material.dart';
import 'package:textz/settings.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class IOSZegoVideoCallingScreen extends StatefulWidget {
  const IOSZegoVideoCallingScreen(
      {super.key, required this.callId, required this.userId});
  final String callId;
  final String userId;

  @override
  State<IOSZegoVideoCallingScreen> createState() =>
      _IOSZegoVideoCallingScreenState();
}

class _IOSZegoVideoCallingScreenState extends State<IOSZegoVideoCallingScreen> {
  @override
  void initState() {
    super.initState();
    print("Initializing call screen");
    ZegoUIKit.instance.joinRoom(widget.callId);
  }

  @override
  void dispose() {
    ZegoUIKit.instance.leaveRoom();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: appId,
      appSign: appSign,
      callID: widget.callId,
      userID: widget.userId,
      userName: widget.userId,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
