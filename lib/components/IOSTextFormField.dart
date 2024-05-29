import 'package:flutter/material.dart';
import 'package:textz/components/IOSBottomNavigationBar.dart';

class IOSTextFormField extends StatefulWidget {
  const IOSTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.keyboard,
    required this.hintText,
  });

  final TextInputType keyboard;
  final String? Function(String?) validator;
  final String hintText;
  final TextEditingController controller;

  @override
  State<IOSTextFormField> createState() => _IOSTextFormFieldState();
}

class _IOSTextFormFieldState extends State<IOSTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyboard,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: blueAppColor,
          ),
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
