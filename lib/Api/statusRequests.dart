import 'dart:convert';
import 'dart:ui';

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:http/http.dart' as http;
import 'package:textz/Api/user_requests.dart';
import 'package:textz/Helpers/IOSHelpers.dart';
import 'package:textz/main.dart';
import 'package:textz/models/Status.dart';

Future<void> uploadTextStatus(String text, Color color) async {
  try {
    final number = await phoneNumber.getNumber();
    await http.post(
      Uri.parse('$backEndUri/status/text?phone_number=$number'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'text': text,
        'color': color.value.toString(),
      }),
    );
  } catch (e) {
    print('error occured');
  }
}

Future<List<Status>?> getStatus() async {
  try {
    final number = await phoneNumber.getNumber();
    final response = await http.get(Uri.parse('$backEndUri/status/?phone_number=$number'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<Status> statusList = data.map((ele) => Status.fromJson(ele)).toList();
      List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);
      statusList = statusList.map((ele) {
        final String number = contacts
            .firstWhere((element) => IOSHelpers.getRefinedPhoneNumber(element.phones[0].number) == ele.phoneNumber)
            .displayName;
        ele.name = number;
        return ele;
      }).toList();
      return statusList;
    } else {
      print('Failed to load status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: ${e.toString()}');
  }
  return null;
}
