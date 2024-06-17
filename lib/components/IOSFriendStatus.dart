import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:textz/Helpers/IOSHelpers.dart';
import 'package:textz/models/Status.dart';
import 'package:textz/screens/IOSStatusViewer.dart';

class IosFriendStatus extends StatefulWidget {
  const IosFriendStatus({super.key, required this.status});
  final Status status;

  @override
  State<IosFriendStatus> createState() => _IosFriendStatusState();
}

class _IosFriendStatusState extends State<IosFriendStatus> {
  List<StoryItem> storyItems = [];
  final controller = StoryController();

  void _generateStoryItems() {
    List<StoryItem> stories = widget.status.status.map((ele) {
      switch (ele.statusType) {
        case 'text':
          return StoryItem.text(
            title: ele.text ?? '',
            backgroundColor: Colors.redAccent,
          );
        case 'media':
          print(ele.mediaLink);
          return StoryItem.pageImage(
            url: ele.mediaLink ?? '',
            controller: controller,
          );
        default:
          return StoryItem.text(
            title: '',
            backgroundColor: Colors.redAccent,
          );
      }
    }).toList();
    setState(() {
      storyItems = stories;
    });
  }

  @override
  void initState() {
    _generateStoryItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IOSStatusViewer(
              storyItems: storyItems,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color(0xFFfffbfe),
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFd7d7d7),
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(widget.status.profilePicture),
              radius: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 30,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.status.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    IOSHelpers.getTimeString(widget.status.uploadedAt, true),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
