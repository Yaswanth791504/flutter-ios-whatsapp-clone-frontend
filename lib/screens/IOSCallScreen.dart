import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:textz/Api/call_requests.dart';
import 'package:textz/components/IOSCallComponent.dart';
import 'package:textz/components/IOSHeader.dart';
import 'package:textz/main.dart';

class IOSCallScreen extends StatefulWidget {
  const IOSCallScreen({super.key});

  @override
  State<IOSCallScreen> createState() => _IOSCallScreenState();
}

class _IOSCallScreenState extends State<IOSCallScreen> {
  List calls = [];
  Future<void> _getCallsList() async {
    List callList = await getCalls();
    setState(() {
      calls = callList;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCallsList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const IOSHeader(screenName: "Calls"),
        Container(
          height: 25,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.topRight,
          color: const Color(0xFFf8f7f7),
          child: calls.isNotEmpty
              ? const Text(
                  "Swipe to delete",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: blueAppColor,
                    fontWeight: FontWeight.w400,
                  ),
                )
              : const SizedBox(),
        ),
        calls.isEmpty
            ? const Flexible(
                child: Center(
                  child: Text("Why don't you call someone you love 😘"),
                ),
              )
            : Flexible(
                child: ListView.builder(
                  itemCount: calls.length,
                  itemBuilder: (builder, index) {
                    return IOSCallComponent(
                      call: calls[index],
                    );
                  },
                ),
              ),
      ],
    );
  }
}
