import 'package:flutter/material.dart';
import 'package:textz/settings.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class IOSZegoCallingScreen extends StatefulWidget {
  const IOSZegoCallingScreen({super.key, required this.callId, required this.userId});
  final String callId;
  final String userId;

  @override
  State<IOSZegoCallingScreen> createState() => _IOSZegoCallingScreenState();
}

class _IOSZegoCallingScreenState extends State<IOSZegoCallingScreen> {
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
}
