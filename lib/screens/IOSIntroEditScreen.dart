import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:textz/components/IOSIntroButton.dart';
import 'package:textz/components/IOSTextFormField.dart';

class IOSIntroEditScreen extends StatefulWidget {
  const IOSIntroEditScreen({super.key, required this.pageController});
  final GlobalKey<IntroductionScreenState> pageController;

  @override
  State<IOSIntroEditScreen> createState() => _IOSIntroEditScreenState();
}

class _IOSIntroEditScreenState extends State<IOSIntroEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  File? imageString;

  void _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    setState(() {
      imageString = File(returnedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text('Enter Your Details'),
        const SizedBox(
          height: 40,
        ),
        GestureDetector(
          onTap: _pickImageFromGallery,
          child: const CircleAvatar(
            radius: 120,
            backgroundImage: AssetImage('assets/images/pic1.jpg'),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: IOSTextFormField(
                  keyboard: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty || value == '') {
                      return 'Enter Your Name';
                    }
                    return null;
                  },
                  hintText: 'Name',
                  controller: _controller,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              IOSIntroButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.pageController.currentState?.next();
                    }
                  },
                  text: 'Next')
            ],
          ),
        )
      ],
    );
  }
}
