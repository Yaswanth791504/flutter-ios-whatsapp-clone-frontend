import 'dart:async';

import 'package:flutter/material.dart';
import 'package:textz/Api/user_requests.dart';
import 'package:textz/components/IOSHeader.dart';
import 'package:textz/components/IOSIndividualChat.dart';
import 'package:textz/components/IOSOptions.dart';
import 'package:textz/components/IOSSearchBar.dart';
import 'package:textz/models/IndividualChat.dart';

const Color blueAppColor = Color(0xFF007AFF);

class IOSMainHomeScreen extends StatefulWidget {
  const IOSMainHomeScreen({super.key});

  @override
  State<IOSMainHomeScreen> createState() => _IOSMainHomeScreenState();
}

class _IOSMainHomeScreenState extends State<IOSMainHomeScreen> {
  List<dynamic> chats = [];
  List<dynamic> searchedChats = [];
  final TextEditingController _searchController = TextEditingController();
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _fetchChats();
    _startAutoRefresh();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _startAutoRefresh() {
    _refreshTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _fetchChats();
    });
  }

  Future<void> _fetchChats() async {
    final userFriendChats = await getChats();
    setState(() {
      chats = userFriendChats ?? [];
      searchedChats = chats;
    });
  }

  void getFilterList(String value) {
    setState(() {
      searchedChats = chats
          .where((element) =>
              element['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8f7f7),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const IOSHeader(screenName: "Chats"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IOSSearchBar(
              controller: _searchController,
              onChanged: (String value) {
                getFilterList(value);
              },
            ),
          ),
          const IOSOptions(),
          Expanded(
            child: searchedChats.isNotEmpty
                ? ListView.builder(
                    itemCount: searchedChats.length,
                    itemBuilder: (BuildContext context, int index) {
                      return IOSIndividualChat(
                        friend: IndividualChat(
                          name: searchedChats[index]['name'] ?? '',
                          phone_number:
                              searchedChats[index]['phone_number'] ?? '',
                          about: 'anything',
                          profile_picture:
                              searchedChats[index]['profile_picture'] ?? '',
                          last_message:
                              searchedChats[index]["last_message"] ?? '',
                          last_message_time:
                              searchedChats[index]["last_message_time"] ?? '',
                          last_message_type:
                              searchedChats[index]["last_message_type"] ?? '',
                          isOnline: searchedChats[index]['status'] ?? false,
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Click on the ',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        Icon(
                          Icons.edit_square,
                          size: 32.0,
                          color: blueAppColor,
                        ),
                        Text(
                          ' to start chat on top right',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
