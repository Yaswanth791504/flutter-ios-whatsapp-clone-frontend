import 'package:flutter/material.dart';
import 'package:textz/models/user.dart';
import 'package:textz/screens/IOSImageViewer.dart';

const Color blueAppColor = Color(0xFF1067FF);

class IOSEditScreen extends StatefulWidget {
  const IOSEditScreen({super.key});

  @override
  State<IOSEditScreen> createState() => _IOSEditScreenState();
}

class _IOSEditScreenState extends State<IOSEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final User user = User(name: 'yaswanth', lastMessage: 'nothing', seen: false, time: 'tine', image: 'pic1.jpg');
  final TextEditingController _nameController = TextEditingController(text: 'yaswanth');
  final TextEditingController _numberController = TextEditingController(text: '+918106344135');
  final TextEditingController _aboutController = TextEditingController(text: 'This is my about');

  void _submitTheDetails() async {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F7),
      appBar: AppBar(
        leadingWidth: 120,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Row(
            children: <Widget>[
              Icon(
                Icons.chevron_left,
                color: blueAppColor,
                size: 40,
              ),
              Text(
                'Back',
                style: TextStyle(
                  fontSize: 20,
                  color: blueAppColor,
                ),
              )
            ],
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                // Handle submit action
              }
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Center(
                child: Text(
                  'Change',
                  style: TextStyle(
                    color: blueAppColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
        elevation: 2,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: blueAppColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Card(
                elevation: 2,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => const IOSImageViewer(
                                    image: 'pic1.jpg',
                                  ),
                                ),
                              );
                            },
                            child: const CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage('assets/images/pic1.jpg'),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Expanded(
                            child: Text(
                              'Enter Your Name and add an optional Profile Picture',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'PHONE NUMBER',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: _numberController,
                      enabled: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'ABOUT',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: _aboutController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
