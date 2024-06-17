import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textz/Helpers/IOSHelpers.dart';
import 'package:textz/main.dart';
import 'package:textz/screens/IOSCameraScreen.dart';
import 'package:textz/screens/IOSStatusTextScreen.dart';

class IOSStatusComponent extends StatefulWidget {
  const IOSStatusComponent({super.key});

  @override
  State<IOSStatusComponent> createState() => _IOSStatusComponentState();
}

class _IOSStatusComponentState extends State<IOSStatusComponent> {
  void _selectStatus() async {
    try {
      final status = await ImagePicker().pickMedia();
      if (status == null) {
        return;
      }
      final mediaLink = await IOSHelpers.uploadVideo(status.path);
      print(mediaLink);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                GestureDetector(
                  onTap: _selectStatus,
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/pic1.jpg'),
                    radius: 30,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: blueAppColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 30,
            ),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'name',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    'Add to my status',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min, // Ensure buttons don't expand unnecessarily
              children: <Widget>[
                IconButton.filled(
                  style: IconButton.styleFrom(
                    backgroundColor: blueAppColor,
                  ),
                  padding: const EdgeInsets.all(3),
                  // color: Colors.black,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder) => const IOSCameraScreen()));
                  },
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 35,
                ),
                IconButton.filled(
                  padding: const EdgeInsets.all(3),
                  style: IconButton.styleFrom(
                    backgroundColor: blueAppColor,
                  ),
                  // color: Colors.black,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder) => const IOSStatusTextScreen()));
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
