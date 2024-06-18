import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:textz/Api/sockets.dart';
import 'package:textz/Api/user_requests.dart';
import 'package:textz/components/IOSCamera.dart';
import 'package:textz/components/IOSCircularProgressIndicator.dart';
import 'package:textz/components/IOSImageMessage.dart';
import 'package:textz/components/IOSMediaComponent.dart';
import 'package:textz/components/IOSMessage.dart';
import 'package:textz/models/IndividualChat.dart';
import 'package:textz/models/Message.dart';
import 'package:textz/screens/IOSUserProfile.dart';

const Color blueAppColor = Color(0xFF007AFF);

class IOSChatScreen extends StatefulWidget {
  const IOSChatScreen({super.key, required this.friend});
  final IndividualChat friend;

  @override
  State<IOSChatScreen> createState() => _IOSChatScreenState();
}

class _IOSChatScreenState extends State<IOSChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  bool _isEmojiVisible = false;
  bool _isLoading = false;
  IosSocket? socket;
  late KeyboardVisibilityController _keyboardVisibilityController;

  List<Message>? messages = [];

  Future<void> _getSocket() async {
    final newSocket = IosSocket();
    await newSocket.initialize();
    setState(() {
      socket = newSocket;
    });

    newSocket.socket.on('receive_message', (data) {
      _updateMessages(data);
    });
  }

  void _updateMessages(data) {
    if (mounted) {
      setState(() {
        messages = [
          ...?messages,
          Message(
            message: data['message'],
            timeStamp: DateTime.now().toString(),
            sent: false,
            messageType: data['message_type'],
          )
        ];
      });
      _scrollToBottom();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMessages();
    _getSocket();

    _keyboardVisibilityController = KeyboardVisibilityController();
    _keyboardVisibilityController.onChange.listen((bool isVisible) {
      if (isVisible) {
        _scrollToBottom();
      }
    });
  }

  Future<void> _fetchMessages() async {
    setState(() {
      _isLoading = true;
    });
    List<Message>? temp = await getChatMessages(widget.friend.phone_number);
    setState(() {
      messages = temp;
      _isLoading = false;
    });
    _scrollToBottom();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    socket?.dispose();
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
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    if (_formKey.currentState!.validate() && _controller.text.trim().isNotEmpty) {
      final text = _controller.text.trim();
      setState(() {
        messages = [
          ...?messages,
          Message(message: text, timeStamp: DateTime.now().toString(), sent: true, messageType: "text")
        ];
      });
      if (socket != null) {
        socket!.sendMessage(text, widget.friend.phone_number, 'text');
      }
      sendMessage(text, widget.friend.phone_number);
      _controller.text = '';
      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    double bottomPadding = (_isEmojiVisible ? 350 : 0) + 70;

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
              size: 35.0, // Adjusted size
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.call_outlined,
              color: blueAppColor,
              size: 35.0, // Adjusted size
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/images/wallpaper.jpg',
              fit: BoxFit.cover,
            ),
          ),
          if (_isLoading)
            const IOSCircularProgressIndicator()
          else
            Positioned.fill(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      color: const Color(0xFFF8F7F7),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'These messages are not encrypted, might be visible to developer. Use it for testing purpose only.',
                          textAlign: TextAlign.center,
                          style: TextStyle(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.only(bottom: bottomPadding),
                      itemCount: messages?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: messages![index].messageType.toLowerCase() == 'image'
                              ? IOSImageMessage(
                                  image: messages![index].message,
                                  sent: messages![index].sent,
                                )
                              : IOSMessage(
                                  message: messages![index].message,
                                  sent: messages![index].sent,
                                  time: messages![index].timeStamp,
                                ),
                        );
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
                Form(
                  key: _formKey,
                  child: BottomAppBar(
                    height: 70.0,
                    color: const Color(0xFFF8F7F7),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) => IOSMediaComponent(
                                  friendPhoneNumber: widget.friend.phone_number,
                                  socketInstance: socket,
                                  updateChats: _fetchMessages),
                            );
                          },
                          icon: const Icon(
                            Icons.add,
                            color: blueAppColor,
                            size: 30.0,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: TextField(
                              minLines: 1,
                              maxLines: 2,
                              controller: _controller,
                              focusNode: _focusNode,
                              onChanged: (String value) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                                fillColor: Colors.white,
                                filled: true,
                                suffixIcon: IconButton(
                                  onPressed: _toggleEmojiPicker,
                                  icon: Icon(
                                    _isEmojiVisible ? Icons.keyboard : Icons.emoji_emotions_outlined,
                                    color: blueAppColor,
                                    size: 30.0,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const IOSCamera(
                                  onPressed: null,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            color: blueAppColor,
                            size: 30.0,
                          ),
                        ),
                        _controller.text.trim().isEmpty
                            ? IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.mic_none_outlined,
                                  color: blueAppColor,
                                  size: 30.0,
                                ),
                              )
                            : IconButton(
                                onPressed: _sendMessage,
                                icon: const Icon(
                                  Icons.send,
                                  color: blueAppColor,
                                  size: 30,
                                ),
                              ),
                      ],
                    ),
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
