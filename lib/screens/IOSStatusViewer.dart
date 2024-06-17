import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class IOSStatusViewer extends StatefulWidget {
  const IOSStatusViewer({super.key, required this.storyItems});
  final List<StoryItem> storyItems;

  @override
  State<IOSStatusViewer> createState() => _IOSStatusViewerState();
}

class _IOSStatusViewerState extends State<IOSStatusViewer> {
  final controller = StoryController();

  @override
  Widget build(BuildContext context) {
    List<StoryItem> storyItems = widget.storyItems;

    return StoryView(
      storyItems: storyItems,
      controller: controller,
      repeat: false,
      onVerticalSwipeComplete: (direction) {
        if (direction == Direction.down) {
          Navigator.pop(context);
        }
      },
    );
  }
}
