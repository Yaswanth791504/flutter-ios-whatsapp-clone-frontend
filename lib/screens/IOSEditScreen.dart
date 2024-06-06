import 'package:flutter/material.dart';
import 'package:textz/Api/userRequests.dart';
import 'package:textz/models/Profile.dart';
import 'package:textz/screens/IOSImageViewer.dart';

const Color blueAppColor = Color(0xFF1067FF);

class IOSEditScreen extends StatefulWidget {
  const IOSEditScreen({super.key});

  @override
  State<IOSEditScreen> createState() => _IOSEditScreenState();
}

Profile? profile;

class _IOSEditScreenState extends State<IOSEditScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _numberController;
  late TextEditingController _aboutController;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _numberController = TextEditingController();
    _aboutController = TextEditingController();
    _fetchUserDetails();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  void _submitTheDetails() async {
    if (_formKey.currentState!.validate()) {
      if (_nameController.text == profile!.getName() && _aboutController.text == profile!.getAbout()) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Change some Details')));
        return;
      }
      setState(() {
        _isSubmitting = true;
      });
      try {
        Map<String, dynamic>? data = await updateUserDetails(
          _nameController.text,
          _aboutController.text,
          _numberController.text,
        );
        if (data != null) {
          setState(() {
            _nameController.text = data['name'];
            _aboutController.text = data['about'];
            profile!.setName(data['name']);
            profile!.setAbout(data['about']);
            _isSubmitting = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully')),
          );
        }
      } catch (e) {
        setState(() {
          _isSubmitting = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')),
        );
      }
    }
  }

  Future<void> _fetchUserDetails() async {
    profile = await getCurrentUser();
    if (profile != null) {
      setState(() {
        _nameController.text = profile!.name;
        _numberController.text = '+91 ${profile!.phoneNumber}';
        _aboutController.text = profile!.about;
      });
    }
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
            onTap: !_isSubmitting ? _submitTheDetails : null,
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
      body: profile == null || _isSubmitting
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                                        builder: (ctx) => IOSImageViewer(
                                          image: profile!.getImage(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(profile!.getImage()),
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
