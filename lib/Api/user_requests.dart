import 'dart:async';
import 'dart:convert';

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:http/http.dart' as http;
import 'package:textz/Api/firebase_notifications.dart';
import 'package:textz/Helpers/IOSHelpers.dart';
import 'package:textz/main.dart';
import 'package:textz/models/IndividualChat.dart';
import 'package:textz/models/Message.dart';
import 'package:textz/models/Profile.dart';

const String backEndUri = 'http://10.0.2.2:8000';

void createUser(Profile profile) async {
  try {
    final token = await FirebaseNotifications().initNotifications();
    await http.post(Uri.parse('$backEndUri/user/register'),
        body: jsonEncode({
          'name': profile.getName(),
          'about': profile.getAbout(),
          'profile_picture': profile.getImage(),
          'phone_number': profile.getPhoneNumber(),
          'email': 'user@example.com',
          'token': token
        }),
        headers: {
          'Content-Type': 'application/json',
        });
  } catch (e) {
    // print(e);
  }
}

Future<IndividualChat?> getUserContactsFromPhone(String phoneNumber) async {
  try {
    final response = await http.get(
      Uri.parse('$backEndUri/user/get?phone_number=$phoneNumber'),
      headers: {
        "Content-Type": "application/json",
      },
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);
    if (data.containsKey('details')) {
      return null;
    }
    data['name'] = contacts
        .where((element) => IOSHelpers.getRefinedPhoneNumber(element.phones[0].number) == data['phone_number'])
        .toList()[0]
        .displayName;
    return IndividualChat(
      name: data['name'],
      email: data['email'],
      phone_number: data['phone_number'],
      about: data['about'],
      profile_picture: data['profile_picture'],
      last_message: '',
      last_message_time: '',
      last_message_type: '',
    );
  } catch (e) {
    // print('Error: $e');
    return null;
  }
}

Future<Profile?> getCurrentUser() async {
  try {
    final String number = await phoneNumber.getNumber();
    final request = await http.get(Uri.parse('$backEndUri/user/get?phone_number=$number'));
    Map<String, dynamic> data = jsonDecode(request.body);
    return Profile(
      email: data['email'],
      name: data['name'],
      phoneNumber: data['phone_number'],
      image: data['profile_picture'],
      about: data['about'],
    );
  } catch (e) {
    // print('Error $e');
    return null;
  }
}

Future<String?> updateProfileImage(String image) async {
  try {
    final number = await phoneNumber.getNumber();
    final request = await http.put(
      Uri.parse('$backEndUri/user/update'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "phone_number": number,
        "profile_picture": image,
      }),
    );
    Map<String, dynamic> data = await jsonDecode(request.body);
    return data['profile_picture'];
  } catch (e) {
    // print('Error $e');
    return null;
  }
}

Future<Map<String, dynamic>?> updateUserDetails(String name, String about, String number) async {
  try {
    final number = await phoneNumber.getNumber();
    final request = await http.put(
      Uri.parse('$backEndUri/user/update'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "phone_number": number,
        "name": name,
        "about": about,
      }),
    );
    return await jsonDecode(request.body);
  } catch (e) {
    // print('Error $e');
    return null;
  }
}

Future<List<dynamic>?> getChats() async {
  try {
    final number = await phoneNumber.getNumber();
    final response = await http.get(Uri.parse('$backEndUri/user/chats?phone_number=$number'));
    List<dynamic> result = await jsonDecode(response.body);

    List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);
    result = result.where((chat) {
      String? chatPhoneNumber = chat['phone_number'];
      return contacts.any((contact) => IOSHelpers.getRefinedPhoneNumber(contact.phones[0].number) == chatPhoneNumber);
    }).map((chat) {
      String? chatPhoneNumber = chat['phone_number'];
      String? displayName = contacts
          .firstWhere(
            (contact) => IOSHelpers.getRefinedPhoneNumber(contact.phones[0].number) == chatPhoneNumber,
          )
          .displayName;

      return {...chat, 'name': displayName};
    }).toList();
    print(result);
    return result;
  } catch (e) {
    // print('Error - $e');
    return null;
  }
}

Future<List<Message>?> getChatMessages(String friendNumber) async {
  try {
    final userNumber = await phoneNumber.getNumber();
    final response = await http
        .get(Uri.parse('$backEndUri/user/messages?user_phone_number=$userNumber&friend_phone_number=$friendNumber'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      List<Message> messages = data.map((ele) {
        return Message(
          message: ele["message"],
          timeStamp: ele["message_time"],
          sent: ele["sender"],
          messageType: ele["message_type"],
        );
      }).toList();
      print(messages);
      return messages;
    } else {
      print('Failed to load messages: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

Future<bool> sendMessage(String message, String toNumber) async {
  try {
    final number = await phoneNumber.getNumber();
    final response = await http.post(
      Uri.parse('$backEndUri/user/message?user_phone_number=$number'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "message": message,
        "friend_phone_number": toNumber,
      }),
    );

    if (response.statusCode == 200) {
      print('sent');
      return true;
    } else {
      // print('Failed to send message: ${response.statusCode} - ${response.reasonPhrase}');
      return false;
    }
  } catch (e) {
    // print('Error sending message: $e');
    return false;
  }
}

Future<String> sendImageToUser(String path, String friendNumber) async {
  try {
    final String imageLink = await IOSHelpers.uploadImage(path);
    final String number = await phoneNumber.getNumber();
    print(number);
    print(friendNumber);
    final response = await http.post(
      Uri.parse('$backEndUri/message/send_image?phone_number=$number'),
      body: jsonEncode({
        "image": imageLink,
        "phoneNumber": friendNumber,
      }),
      headers: {"Content-Type": "application/json"},
    );
    final Map data = await jsonDecode(response.body);
    return imageLink;
    print(data);
  } catch (e) {
    return '';
  }
}
