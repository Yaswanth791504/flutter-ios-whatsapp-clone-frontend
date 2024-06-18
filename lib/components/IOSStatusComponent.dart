import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:textz/Api/statusRequests.dart';
import 'package:textz/components/StoryIndicatorPainter.dart';
import 'package:textz/main.dart';
import 'package:textz/screens/IOSStatusTextScreen.dart';
import 'package:textz/screens/IOSStatusViewer.dart';

import 'IOSCamera.dart';

class IOSStatusComponent extends StatefulWidget {
  const IOSStatusComponent({super.key, required this.storyItems, required this.refreshFunc});
  final List<StoryItem> storyItems;
  final refreshFunc;

  @override
  State<IOSStatusComponent> createState() => _IOSStatusComponentState();
}

class _IOSStatusComponentState extends State<IOSStatusComponent> {
  void _selectStatus() async {
    try {
      Navigator.push(context, MaterialPageRoute(builder: (builder) => IOSCamera(onPressed: () {})));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.storyItems.isNotEmpty
          ? () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => IOSStatusViewer(storyItems: widget.storyItems),
                ),
              )
          : () {},
      child: Container(
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
                    onTap: widget.storyItems.isEmpty
                        ? _selectStatus
                        : () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => IOSStatusViewer(storyItems: widget.storyItems),
                              ),
                            ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/pic1.jpg'),
                          radius: 30,
                        ),
                        CustomPaint(
                          size: const Size(70, 70),
                          painter: StoryIndicatorPainter(
                            numSegments: widget.storyItems.length,
                            strokeWidth: 3.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  widget.storyItems.isEmpty
                      ? Container(
                          decoration: BoxDecoration(
                            color: blueAppColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        )
                      : const SizedBox(),
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
                      'Your Status',
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
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: blueAppColor,
                    ),
                    padding: const EdgeInsets.all(3),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => const IOSCamera(
                            onPressed: uploadImageStatus,
                          ),
                        ),
                      );
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => IOSStatusTextScreen(refreshFunc: widget.refreshFunc)));
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
      ),
    );
  }
}
