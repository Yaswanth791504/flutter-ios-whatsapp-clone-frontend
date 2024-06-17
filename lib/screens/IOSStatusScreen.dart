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

  @override
  void initState() {
    _getFriendStatus();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const IOSHeader(screenName: "Status"),
        const IOSStatusComponent(),
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
