import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:textz/Api/userRequests.dart';
import 'package:textz/Helpers/IOSHelpers.dart';
import 'package:textz/components/IOSNewChat.dart';
import 'package:textz/components/IOSSearchBar.dart';
import 'package:textz/main.dart';
import 'package:textz/models/Friends.dart';

class IOSNewChatScreen extends StatefulWidget {
  const IOSNewChatScreen({super.key});

  @override
  State<IOSNewChatScreen> createState() => _IOSNewChatScreenState();
}

class _IOSNewChatScreenState extends State<IOSNewChatScreen> {
  List<Friends> friends = [];
  List<Friends> filteredList = [];
  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    if (await FlutterContacts.requestPermission()) {
      setState(() {
        _isLoading = true;
      });

      try {
        List<Contact> contacts = await FlutterContacts.getContacts(
          withProperties: true,
        );

        var futures = contacts
            .where((element) => element.phones.isNotEmpty)
            .map((e) => IOSHelpers.getRefinedPhoneNumber(e.phones[0].number))
            .map((number) => getUserContactsFromPhone(number))
            .toList();

        var results = await Future.wait(futures);
        var nonNullFriends = results.whereType<Friends>().toList();

        setState(() {
          friends = nonNullFriends;
          filteredList = nonNullFriends;
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        print('Error fetching contacts: $e');
      }
    }
  }

  void getFilterList(String value) {
    setState(() {
      filteredList = friends.where((element) => element.name.contains(value)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.chevron_left,
                    color: blueAppColor,
                    size: 40,
                  ),
                ),
                IOSSearchBar(
                  controller: _searchController,
                  onChanged: (String value) {
                    getFilterList(value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : filteredList.isNotEmpty
                      ? ListView(
                          children: filteredList.map((friend) {
                            return IOSNewChat(friend: friend);
                          }).toList(),
                        )
                      : const Center(
                          child: Text("No Friend is Found"),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
