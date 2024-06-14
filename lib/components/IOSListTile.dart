import 'package:flutter/material.dart';
import 'package:textz/main.dart';

class IOSListTile extends StatelessWidget {
  const IOSListTile({super.key, required this.icon, required this.title, this.onPressed});

  final IconData icon;
  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.2),
          border: Border(
            bottom: BorderSide(
              color: title != "Contact" ? Colors.grey : Colors.transparent, // Color of the border
              width: title != "Contact" ? 1.0 : 0, // Width of the border
            ),
          ),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: blueAppColor,
            size: 35.0,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
    ;
  }
}
