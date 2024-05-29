import "package:flutter/material.dart";
import "package:textz/components/IOSBottomNavigationBar.dart";
import "package:textz/screens/IOSCameraScreen.dart";
import "package:textz/screens/IOSEditScreen.dart";
import "package:textz/screens/IOSNewChatScreen.dart";

import 'IOSMainHomeScreen.dart';

const Color blueAppColor = Color(0xFF1067FF);

class IOSHomeScreen extends StatefulWidget {
  const IOSHomeScreen({super.key});

  @override
  State<IOSHomeScreen> createState() => _IOSHomeScreenState();
}

class _IOSHomeScreenState extends State<IOSHomeScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;
  int initialIndex = 3;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this, initialIndex: initialIndex);
    _controller.addListener(_handleScreenChange);
  }

  void _handleScreenChange() {
    setState(() {
      initialIndex = _controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F7),
      appBar: AppBar(
        primary: true,
        backgroundColor: const Color(0xFFF8F7F7),
        title: Builder(builder: (context) {
          return InkWell(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                showDragHandle: true,
                backgroundColor: const Color(0xFFF8F7F7),
                context: context,
                useSafeArea: true,
                builder: (ctx) => const IOSEditScreen(),
              );
            },
            child: const Text(
              'Edit',
              style: TextStyle(
                color: blueAppColor,
              ),
            ),
          );
        }),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Builder(builder: (context) {
              return IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const IOSNewChatScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.edit_square,
                  size: 30.0,
                  color: blueAppColor,
                ),
              );
            }),
          ),
        ],
      ),
      body: TabBarView(
        controller: _controller,
        children: const <Widget>[
          Text('status'),
          Text('calls'),
          IOSCameraScreen(),
          IOSMainHomeScreen(),
          Text('settings'),
        ],
      ),
      bottomNavigationBar: IOSBottomNavigationBar(
        selectedIndex: initialIndex,
        onDestinationChange: (int index) {
          setState(() {
            _controller.index = index;
            initialIndex = index;
          });
        },
      ),
    );
  }
}
