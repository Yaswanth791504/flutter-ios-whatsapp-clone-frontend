import 'dart:math';

import 'package:flutter/material.dart';
import 'package:textz/Api/statusRequests.dart';
import 'package:textz/main.dart';

class IOSStatusTextScreen extends StatefulWidget {
  const IOSStatusTextScreen({super.key, required this.refreshFunc});
  final refreshFunc;

  @override
  State<IOSStatusTextScreen> createState() => _IOSStatusTextScreenState();
}

class _IOSStatusTextScreenState extends State<IOSStatusTextScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final Random _random = Random();
  Color color = Colors.redAccent;

  void _generateRandomColor() {
    Color newColor = Color(_random.nextInt(4294967296));

    setState(() {
      color = newColor;
    });
  }

  @override
  void initState() {
    _generateRandomColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left,
            color: blueAppColor,
            size: 40,
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: _generateRandomColor,
              child: Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromRGBO(255, 255, 255, 0.2),
                ),
                child: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  uploadTextStatus(_controller.text.trim(), color);
                  widget.refreshFunc();
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error Occurred')));
                }
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.3),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.done,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        color: color,
        child: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                minLines: 1,
                maxLines: 20,
                cursorHeight: 43,
                cursorWidth: 3,
                cursorColor: Colors.white,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
                autofocus: true,
                textAlign: TextAlign.center,
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Type the status',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
