import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:textz/Api/user_requests.dart';
import 'package:textz/Helpers/IOSHelpers.dart';
import 'package:textz/components/IOSCircularProgressIndicator.dart';
import 'package:textz/components/IOSIntroButton.dart';
import 'package:textz/components/IOSTextFormField.dart';
import 'package:textz/main.dart';
import 'package:textz/models/Profile.dart';
import 'package:textz/screens/IOSHomeScreen.dart';

import 'IOSEditScreen.dart';

class IOSIntroEditScreen extends StatefulWidget {
  const IOSIntroEditScreen(
      {super.key, required this.pageController, required this.phoneController});
  final GlobalKey<IntroductionScreenState> pageController;
  final TextEditingController phoneController;

  @override
  State<IOSIntroEditScreen> createState() => _IOSIntroEditScreenState();
}

class _IOSIntroEditScreenState extends State<IOSIntroEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  String imageUri =
      'http://res.cloudinary.com/drv13gs45/image/upload/v1717225161/ios-whatsapp/default.jpg';

  void _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      _isLoading = true;
    });
    final imageLink = await IOSHelpers.uploadImage(returnedImage.path);

    setState(() {
      imageUri = imageLink;
      _isLoading = false;
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
          child: _isLoading
              ? const IOSCircularProgressIndicator()
              : CircleAvatar(
                  radius: 120,
                  backgroundImage: NetworkImage(imageUri),
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate() && !_isLoading) {
                      profile = Profile(
                        name: _controller.value.text.toString(),
                        email: '',
                        image: imageUri,
                        phoneNumber:
                            widget.phoneController.value.text.toString(),
                      );
                      createUser(profile!);
                      userPreference.setLoggedIn();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => const IOSHomeScreen()));
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
