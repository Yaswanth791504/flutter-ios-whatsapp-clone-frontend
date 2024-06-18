import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:textz/Api/statusRequests.dart';
import 'package:textz/components/IOSCircularProgressIndicator.dart';
import 'package:textz/components/IOSFriendStatus.dart';
import 'package:textz/components/IOSHeader.dart';
import 'package:textz/components/IOSStatusComponent.dart';
import 'package:textz/components/IOSStatusSeperator.dart';
import 'package:textz/models/Status.dart';

class IOSStatusScreen extends StatefulWidget {
  const IOSStatusScreen({super.key});

  @override
  State<IOSStatusScreen> createState() => _IOSCallScreenState();
}

class _IOSCallScreenState extends State<IOSStatusScreen> {
  final controller = StoryController();
  List<Status> status = [];
  bool _isLoading = false;
  List<StoryItem> storyItems = [];
  @override
  void initState() {
    _getFriendStatus();
    _getMyStatus();
    super.initState();
  }

  void _refreshStatus() {
    _getMyStatus();
    _getFriendStatus();
  }

  Future<void> _getFriendStatus() async {
    setState(() {
      _isLoading = true;
    });
    final List<Status>? friendStatus = await getStatus();
    setState(() {
      status = friendStatus ?? [];
      _isLoading = false;
    });
  }

  List<StoryItem> _generateStoryItems(List<MyStatus> status) {
    List<StoryItem> stories = status.map((ele) {
      Color backgroundColor;
      try {
        backgroundColor = Color(int.parse(ele.statusTextColor));
      } catch (e) {
        backgroundColor = Colors.redAccent;
      }

      switch (ele.statusType) {
        case 'text':
          return StoryItem.text(
            title: ele.text ?? '',
            backgroundColor: backgroundColor,
            duration: const Duration(seconds: 5),
          );
        case 'media':
          return StoryItem.pageImage(
            url: ele.mediaLink ?? '',
            controller: controller,
            duration: const Duration(seconds: 10),
          );
        default:
          return StoryItem.text(
            title: '',
            backgroundColor: Colors.redAccent,
          );
      }
    }).toList();

    return stories;
  }

  Future<void> _getMyStatus() async {
    final mystatus = await getMyStatus();
    List<StoryItem> statuses = _generateStoryItems(mystatus!);
    setState(() {
      storyItems = statuses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const IOSHeader(screenName: "Status"),
        IOSStatusComponent(storyItems: storyItems, refreshFunc: _refreshStatus),
        status.isNotEmpty ? const IoSStatusSeparator(name: 'Recent Updates') : const SizedBox(),
        Expanded(
          child: _isLoading
              ? const IOSCircularProgressIndicator()
              : status.isNotEmpty
                  ? ListView.builder(
                      itemCount: status.length,
                      itemBuilder: (context, index) {
                        return IosFriendStatus(status: status[index]);
                      },
                    )
                  : const Center(
                      child: Text('No Status found'),
                    ),
        )
      ],
    );
  }
}
