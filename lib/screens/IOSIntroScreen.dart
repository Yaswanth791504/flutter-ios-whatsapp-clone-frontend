import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:textz/components/IOSBottomNavigationBar.dart';
import 'package:textz/components/IOSIntroButton.dart';
import 'package:textz/components/IOSTextFormField.dart';
import 'package:textz/main.dart';
import 'package:textz/screens/IOSIntroEditScreen.dart';

class IOSIntroScreen extends StatefulWidget {
  const IOSIntroScreen({super.key});

  @override
  State<IOSIntroScreen> createState() => _IOSIntroScreenState();
}

class _IOSIntroScreenState extends State<IOSIntroScreen> {
  final _introKey = GlobalKey<IntroductionScreenState>();
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _isLoading = false;
  late String phoneVerificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        initialPage: 0,
        freeze: true,
        isProgress: false,
        key: _introKey,
        pages: [
          PageViewModel(
            titleWidget: const Text(''),
            bodyWidget: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const SizedBox(
                    height: 300,
                    child: Image(
                      image: AssetImage('assets/images/intro-bg.png'),
                      fit: BoxFit.fill,
                      color: blueAppColor,
                    ),
                  ),
                  const Text(
                    "Welcome to Textz",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'I am happy to see you using my app.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'My 💙 is for you',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  IOSIntroButton(
                    onPressed: () async {
                      _introKey.currentState?.next();
                    },
                    text: 'Next',
                  )
                ],
              ),
            ),
          ),
          PageViewModel(
            titleWidget: const Text(''),
            bodyWidget: Column(
              children: <Widget>[
                const Text(
                  'Enter Your Phone Number',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Form(
                      key: _formKey,
                      child: IOSTextFormField(
                        hintText: 'Phone Number',
                        validator: (value) {
                          if (value!.isEmpty || value.contains(r'[A-Z a-z') || value.length < 10) {
                            return 'Please enter a valid phone Number';
                          }
                          return null;
                        },
                        keyboard: TextInputType.number,
                        controller: _phoneNumberController,
                      )),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                _isLoading
                    ? const CircularProgressIndicator()
                    : IOSIntroButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            if (_isLoading) {}
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: '+91${_phoneNumberController.text}',
                              verificationCompleted: (PhoneAuthCredential credential) async {
                                // Auto sign-in
                                await FirebaseAuth.instance.signInWithCredential(credential);
                              },
                              verificationFailed: (FirebaseAuthException ex) {
                                setState(() {
                                  _isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(ex.message ?? 'Verification failed. Please try again.'),
                                  ),
                                );
                              },
                              codeSent: (String verificationId, int? resendToken) {
                                setState(() {
                                  phoneVerificationId = verificationId;
                                  _isLoading = false;
                                });
                                _introKey.currentState?.next();
                              },
                              codeAutoRetrievalTimeout: (String verificationId) {
                                phoneVerificationId = verificationId;
                              },
                            );
                          }
                        },
                        text: 'Next',
                      )
              ],
            ),
          ),
          PageViewModel(
            title: '',
            bodyWidget: Column(
              children: <Widget>[
                const Text(
                  'Verifying your number',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text('Enter the otp sent to +91 ${_phoneNumberController.value.text}'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Form(
                    key: _phoneNumberKey,
                    child: OtpTextField(
                      fieldWidth: 30,
                      onSubmit: (String code) async {
                        try {
                          FirebaseAuth auth = FirebaseAuth.instance;
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(verificationId: phoneVerificationId, smsCode: code);
                          await auth.signInWithCredential(credential);
                          phoneNumber.setNumber(_phoneNumberController.value.text.toString());
                          _introKey.currentState?.next();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Something is wrong: $e')),
                          );
                        }
                      },
                      keyboardType: TextInputType.number,
                      numberOfFields: 6,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
          PageViewModel(
            titleWidget: const Text(''),
            bodyWidget: IOSIntroEditScreen(
              pageController: _introKey,
              phoneController: _phoneNumberController,
            ),
          ),
        ],
        showNextButton: false,
        showDoneButton: false,
        showSkipButton: false,
        showBackButton: false,
      ),
    );
  }
}
