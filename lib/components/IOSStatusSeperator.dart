import 'package:flutter/material.dart';

class IoSStatusSeparator extends StatelessWidget {
  const IoSStatusSeparator({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      width: double.infinity,
      color: Colors.white,
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
