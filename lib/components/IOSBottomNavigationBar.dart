import "package:flutter/material.dart";

const Color blueAppColor = Color(0xFF1067FF);

class IOSBottomNavigationBar extends StatefulWidget {
  const IOSBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationChange,
  });
  final int selectedIndex;
  final ValueChanged<int> onDestinationChange;

  @override
  State<IOSBottomNavigationBar> createState() => _IOSBottomNavigationBarState();
}

class _IOSBottomNavigationBarState extends State<IOSBottomNavigationBar> {
  final navigationData = [
    {"name": "Status", "icon_out": Icons.animation_rounded, "icon_fill": Icons.animation},
    {"name": "Calls", "icon_out": Icons.call_outlined, "icon_fill": Icons.call},
    {"name": "Camera", "icon_out": Icons.camera_alt_outlined, "icon_fill": Icons.camera_alt},
    {"name": "Chats", "icon_out": Icons.chat_bubble_outline_sharp, "icon_fill": Icons.chat_bubble},
    {"name": "Settings", "icon_out": Icons.settings_outlined, "icon_fill": Icons.settings}
  ];

  @override
  Widget build(BuildContext context) {
    int selectedIndex = widget.selectedIndex;
    return NavigationBar(
      indicatorColor: Colors.transparent,
      selectedIndex: selectedIndex,
      onDestinationSelected: (int index) {
        widget.onDestinationChange(index);
      },
      height: 70.0,
      backgroundColor: const Color(0xFFF8F7F7),
      destinations: navigationData.map((e) {
        int navigationIndex = navigationData.indexOf(e);
        return NavigationDestination(
          icon: Icon(
            selectedIndex == navigationIndex ? e['icon_fill'] as IconData : e['icon_out'] as IconData,
            color: selectedIndex == navigationIndex ? blueAppColor : const Color(0xFF7B7B7B),
            size: 35.0,
          ),
          label: e['name'] as String,
        );
      }).toList(),
    );
  }
}
