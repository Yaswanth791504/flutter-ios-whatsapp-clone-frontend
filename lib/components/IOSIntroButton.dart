import 'package:flutter/material.dart';

class IOSIntroButton extends StatelessWidget {
  const IOSIntroButton({
    super.key,
    this.variation = 'primary',
    required this.onPressed,
    required this.text,
  });

  final String variation;
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        ),
        backgroundColor: MaterialStatePropertyAll(
          variation == 'primary' ? const Color(0xFF1067FF) : Colors.grey,
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Adjust the border radius here
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
