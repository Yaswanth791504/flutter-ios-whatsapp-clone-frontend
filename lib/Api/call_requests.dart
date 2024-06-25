import 'dart:convert';
import 'dart:math';

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:http/http.dart' as http;
import 'package:textz/Api/user_requests.dart';
import 'package:textz/main.dart';
import 'package:textz/models/Call.dart';

import '../Helpers/IOSHelpers.dart';

Future<String> sendCall(String friendPhoneNumber, String callType) async {
  try {
    final number = await phoneNumber.getNumber();
    final String callId = Random().nextInt(100000).toString();
    final request = await http.post(
      Uri.parse('$backEndUri/calls/?phone_number=$number'),
      body: jsonEncode({
        "friend_phone_number": friendPhoneNumber,
        "call_type": callType,
        "call_id": callId,
      }),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (request.statusCode == 200) {
      print('Call invitation sent');
    }
    return callId;
  } catch (e) {
    print('Something has happened');
  }
  return "";
}

Future<List<Call>> getCalls() async {
  try {
    // Get the phone number
    final String number = await phoneNumber.getNumber();
    print('Retrieved phone number: $number');

    // Make HTTP request
    final Uri uri = Uri.parse('$backEndUri/calls/?phone_number=$number');
    final http.Response request = await http.get(uri);
    print('HTTP request made to $uri');

    // Check the response status code
    if (request.statusCode != 200) {
      throw Exception(
          'Failed to load calls with status code: ${request.statusCode}');
    }

    // Decode JSON
    final List<dynamic> data = jsonDecode(request.body);
    print('Data received: $data');

    // Convert JSON to Call objects
    List<Call> calls = data.map((ele) => Call.fromJson(ele)).toList();
    print('Calls after JSON parsing: $calls');

    // Get contacts
    List<Contact> contacts =
        await FlutterContacts.getContacts(withProperties: true);
    print('Contacts retrieved: $contacts');

    // Update call information with contact names
    calls = calls.map((ele) {
      try {
        final String? name = contacts
            .firstWhere(
              (element) =>
                  IOSHelpers.getRefinedPhoneNumber(element.phones[0].number) ==
                  ele.phoneNumber,
            )
            ?.displayName;
        return Call(
          profilePicture: ele.profilePicture,
          name: name ?? 'Unknown', // Handle cases where no contact is found
          phoneNumber: ele.phoneNumber,
          sent: ele.sent,
          callerId: ele.callerId,
          callType: ele.callType,
          startedAt: ele.startedAt,
        );
      } catch (e) {
        print('Error while matching contact: $e');
        return ele; // Return the original call if there's an error
      }
    }).toList();

    print('Updated calls with contact names: $calls');
    return calls;
  } catch (e) {
    print('Error: $e');
  }
  return [];
}

Future<void> deleteCall(int id) async {
  try {
    final response =
        await http.delete(Uri.parse('$backEndUri/calls/?caller_id=$id'));
  } catch (e) {
    print(e);
  }
}
