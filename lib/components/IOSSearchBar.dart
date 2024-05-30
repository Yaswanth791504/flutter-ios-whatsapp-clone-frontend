import 'package:flutter/material.dart';

class IOSSearchBar extends StatefulWidget {
  const IOSSearchBar({super.key});

  @override
  State<IOSSearchBar> createState() => _IOSSearchBarState();
}

class _IOSSearchBarState extends State<IOSSearchBar> {
  late String inputValue;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: TextField(
          onChanged: (String value) {
            setState(() {
              inputValue = value;
            });
          },
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: const Color(0xFF8e8e93),
            contentPadding: const EdgeInsets.all(0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13.0),
              borderSide: BorderSide.none,
            ),
            hintText: "Search",
            hintStyle: const TextStyle(
              fontSize: 20.0,
              color: Color(0xFF8e8e93),
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: const Color(0xFFebeaeb),
          ),
        ),
      ),
    );
  }
}
