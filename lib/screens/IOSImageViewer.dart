import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textz/Api/userRequests.dart';
import 'package:textz/Helpers/IOSHelpers.dart';
import 'package:textz/screens/IOSEditScreen.dart';

class IOSImageViewer extends StatefulWidget {
  const IOSImageViewer({super.key, required this.image, this.isProfile = false});
  final bool isProfile;
  final String image;

  @override
  State<IOSImageViewer> createState() => _IOSImageViewerState();
}

class _IOSImageViewerState extends State<IOSImageViewer> {
  String? imageLink;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    imageLink = widget.image;
  }

  void _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final String? uploadedImage = await IOSHelpers.uploadImage(returnedImage.path);
      if (uploadedImage == null) {
        throw Exception('Image upload failed');
      }
      await updateProfileImage(uploadedImage);
      setState(() {
        imageLink = uploadedImage;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              color: blueAppColor,
              size: 40,
            ),
          ),
          actions: widget.isProfile
              ? <Widget>[
                  IconButton(
                    onPressed: _pickImageFromGallery,
                    icon: const Icon(
                      Icons.edit,
                      color: blueAppColor,
                      size: 35,
                    ),
                  )
                ]
              : <Widget>[]),
      backgroundColor: Colors.black,
      body: Center(
        child: !_isLoading
            ? (imageLink != null ? Image.network(imageLink!) : const Text('No image available'))
            : const CircularProgressIndicator(),
      ),
    );
  }
}
