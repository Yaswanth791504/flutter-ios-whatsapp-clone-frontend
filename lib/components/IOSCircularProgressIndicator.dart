import 'package:flutter/material.dart';
import 'package:textz/main.dart';

class IOSCircularProgressIndicator extends StatelessWidget {
  const IOSCircularProgressIndicator({super.key, this.appColor = blueAppColor});
  final Color appColor;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      color: appColor,
    ));
  }
}
