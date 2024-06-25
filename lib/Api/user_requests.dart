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

const String backEndUri = 'https://ios-whatsapp-backend.onrender.com';
// const String backEndUri = 'http://10.0.2.2:8000';

void createUser(Profile profile) async {
  try {
    final notification = FirebaseNotifications();
    final token = await notification.initNotifications();
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

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data.containsKey('details')) {
        print('No user details found for phone number: $phoneNumber');
        return null;
      }

      List<Contact> contacts =
          await FlutterContacts.getContacts(withProperties: true);
      String refinedPhoneNumber = IOSHelpers.getRefinedPhoneNumber(phoneNumber);
      var contact = contacts.firstWhere(
        (contact) {
          return contact.phones.any((phone) {
            String refinedContactPhone =
                IOSHelpers.getRefinedPhoneNumber(phone.number);
            return refinedContactPhone == refinedPhoneNumber;
          });
        },
        orElse: () => Contact(),
      );
      if (contact.phones.isEmpty) {
        print('No matching contact found for phone number: $phoneNumber');
        return null;
      }
      data['name'] = contact.displayName;
      print('Fetched contact: ${data.toString()}');
      return IndividualChat(
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        phone_number: data['phone_number'] ?? '',
        about: data['about'] ?? '',
        profile_picture: data['profile_picture'] ?? '',
        last_message: '',
        last_message_time: '',
        last_message_type: '',
        isOnline: data['status'] ?? false,
      );
    } else {
      print(
          'Failed to fetch user details: ${response.statusCode} - ${response.body}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

Future<Profile?> getCurrentUser() async {
  try {
    final String number = await phoneNumber.getNumber();
    final request =
        await http.get(Uri.parse('$backEndUri/user/get?phone_number=$number'));
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

Future<Map<String, dynamic>?> updateUserDetails(
    String name, String about, String number) async {
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
    final String? number = await phoneNumber.getNumber();
    if (number == null || number.isEmpty) {
      print('Phone number is null or empty');
      return null;
    }
    final Uri url = Uri.parse('$backEndUri/user/chats?phone_number=$number');
    final http.Response response = await http.get(url);
    if (response.statusCode != 200) {
      print('Failed to fetch chats: ${response.statusCode} - ${response.body}');
      return null;
    }
    List<dynamic> chats = jsonDecode(response.body);
    if (chats.isEmpty) {
      print('No chats found for phone number: $number');
      return [];
    }
    List<Contact> contacts =
        await FlutterContacts.getContacts(withProperties: true);
    List<dynamic> result = chats.where((chat) {
      String? chatPhoneNumber = chat['phone_number'];
      if (chatPhoneNumber == null) return false;
      return contacts.any((contact) {
        return contact.phones.any((phone) {
          return IOSHelpers.getRefinedPhoneNumber(phone.number) ==
              chatPhoneNumber;
        });
      });
    }).map((chat) {
      String? chatPhoneNumber = chat['phone_number'];
      String? displayName;
      try {
        displayName = contacts.firstWhere((contact) {
          return contact.phones.any((phone) {
            return IOSHelpers.getRefinedPhoneNumber(phone.number) ==
                chatPhoneNumber;
          });
        }).displayName;
      } catch (e) {
        displayName = null;
      }
      return {...chat, 'name': displayName};
    }).toList();
    print('Fetched chats: $result');
    return result;
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

Future<List<Message>?> getChatMessages(String friendNumber) async {
  try {
    final userNumber = await phoneNumber.getNumber();
    final response = await http.get(Uri.parse(
        '$backEndUri/user/messages?user_phone_number=$userNumber&friend_phone_number=$friendNumber'));

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

Future<void> setUserState(bool isOnline) async {
  try {
    final String number = await phoneNumber.getNumber();
    final request = await http.post(
        Uri.parse('$backEndUri/user/status?phone_number=$number'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            "status": isOnline,
          },
        ));
    if (request.statusCode == 200) {
      print("user Status upadted");
    }
  } catch (e) {
    print(e);
  }
}
