import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:textz/components/IOSCamera.dart';
import 'package:textz/models/Friends.dart';
import 'package:textz/screens/IOSUserProfile.dart';

const Color blueAppColor = Color(0xFF007AFF);

class IOSChatScreen extends StatefulWidget {
  const IOSChatScreen({super.key, required this.friend});
  final Friends friend;

  @override
  State<IOSChatScreen> createState() => _IOSChatScreenState();
}

class _IOSChatScreenState extends State<IOSChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isEmojiVisible = false;

  List<String> messages = [
    'Hello!',
    'Hi, how are you?',
    'I\'m good, thanks!',
  ];

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleEmojiPicker() {
    setState(() {
      _isEmojiVisible = !_isEmojiVisible;
      if (_isEmojiVisible) {
        _focusNode.unfocus();
      } else {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F7F7),
        toolbarHeight: 65.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            size: 60.0,
            color: blueAppColor,
          ),
        ),
        elevation: 1.0,
        shadowColor: Colors.black,
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IOSUserProfile(friend: widget.friend),
              ),
            );
          },
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 10.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.friend.profile_picture),
                  radius: 25.0,
                ),
              ),
              Text(
                widget.friend.name.split(" ").length <= 2
                    ? widget.friend.name
                    : "${widget.friend.name.split(" ")[0]} ${widget.friend.name.split(" ")[1]}",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.videocam_outlined,
              color: blueAppColor,
              size: 45.0,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.call_outlined,
              color: blueAppColor,
              size: 35.0,
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text(messages[index]));
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                BottomAppBar(
                  padding: const EdgeInsets.all(0),
                  color: const Color(0xFFF8F7F7),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                          color: blueAppColor,
                          size: 50.0,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            minLines: 1,
                            maxLines: 2,
                            controller: _controller,
                            focusNode: _focusNode,
                            onChanged: (String value) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                              fillColor: Colors.white,
                              filled: true,
                              suffixIcon: IconButton(
                                onPressed: _toggleEmojiPicker,
                                icon: const Icon(
                                  Icons.emoji_emotions_outlined,
                                  color: blueAppColor,
                                  size: 40.0,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onTap: () {
                              if (_isEmojiVisible) {
                                setState(() {
                                  _isEmojiVisible = false;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const IOSCamera()));
                        },
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          color: blueAppColor,
                          size: 40,
                        ),
                      ),
                      _controller.text.trim().isEmpty
                          ? IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.mic_none_outlined,
                                color: blueAppColor,
                                size: 40,
                              ),
                            )
                          : IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.send,
                                color: blueAppColor,
                                size: 40,
                              ),
                            ),
                    ],
                  ),
                ),
                Offstage(
                  offstage: !_isEmojiVisible,
                  child: SizedBox(
                    height: 350,
                    child: EmojiPicker(
                      textEditingController: _controller,
                      config: const Config(
                        height: 256,
                        bottomActionBarConfig: BottomActionBarConfig(
                          enabled: false,
                        ),
                        categoryViewConfig: CategoryViewConfig(
                          showBackspaceButton: true,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
